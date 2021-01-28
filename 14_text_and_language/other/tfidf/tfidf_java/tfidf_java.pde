// term frequency ==> the raw count of a term in a document
// inverse document frequency ==> logarithmically scaled inverse fraction of the documents that contain the word

import java.util.*;
import java.util.HashMap;
import java.util.Set;

BufferedReader[] readers;
HashMap<String, Integer>[] dicts;
float margin;

void setup() {
  size(800, 800);
  background(253);
  margin = 80;

  textFont(createFont("Helvetica-Bold", 48));
  fill(0);
  
  
  readers = new BufferedReader[2]; 
  readers[0] = createReader("little_women.txt");
  readers[1] = createReader("frankenstein.txt");

  dicts = new HashMap[2];
  dicts[0] = new HashMap<String, Integer>();
  dicts[1] = new HashMap<String, Integer>();
  
  
  textAlign(LEFT, CENTER);
  text("Little Women", width/3, margin-10);
  text("Frankenstein", width/3, margin-10 + height/dicts.length - 30);
  
  readAndCount(); 
  
  // Get the inverse document frequency 
  // ==> logarithmically scaled inverse fraction of the documents that contain the word
  HashMap<String, Float> idf_dict = new HashMap<String, Float>();
  Set<String> words = dicts[0].keySet();
  for (String word: words) {
    int appearances = 0;
    for (HashMap<String, Integer> dict: dicts) {
      int freq = dict.get(word);
      if (freq > 0) {
        appearances += 1;
      }
    }
    float idf = log(dicts.length/appearances);
    idf_dict.put(word, idf);
  }
  
  // Calculate tfidf for each text
  for (int i = 0; i < readers.length; i++) {
    HashMap<String, Float> tfidf_dict = new HashMap<String, Float>();
    for (String word: words) {
      float tfidf = dicts[i].get(word) * idf_dict.get(word);
      tfidf_dict.put(word, tfidf);
    }
    
    // TODO: sort words by tfidf
    List<Map.Entry<String, Float>> tfidf_list = 
                 new LinkedList<Map.Entry<String, Float> >(tfidf_dict.entrySet()); 
    
    Collections.sort(tfidf_list, new Comparator<Map.Entry<String, Float> >() { 
              public int compare(Map.Entry<String, Float> o1,  
                                 Map.Entry<String, Float> o2) 
              { 
                  return (o2.getValue()).compareTo(o1.getValue()); 
              } 
          });
    
    println(tfidf_list.subList(0, 5));
    println();
    
    drawGraph(tfidf_list.subList(0, 5), margin+i*(height/dicts.length - 30));
  }
  
  noLoop();
}

void draw() {
}

void drawGraph(List<Map.Entry<String, Float>> data, float top) {
  textSize(32);
  textAlign(RIGHT, CENTER);
  noStroke();
  
  float rectH = 44;
  
  float maxWidth = width/2;
  float maxValue = data.get(0).getValue();
  for (int i = 0; i < data.size(); i++) {
    Map.Entry<String, Float> pair = data.get(i);
    fill(0);
    text(pair.getKey(), width/3-30, top+(i+1)*54);
    
    fill(0);
    float w = map(pair.getValue(), 0, maxValue, 0, maxWidth);
    rect(width/3, top+(i+1)*54-rectH/2, w, rectH);
  }
}

void readAndCount() {
  String line;
  
  BufferedReader reader;
  
  for (int i = 0; i < readers.length; i++) {
    println("Reading...");
    reader = readers[i];
    line = "";

    while (line != null) {
      String cleaned = (line.replaceAll("[^a-zA-Z ]+", ""));
      String[] cleaned_arr = cleaned.split(" ");
      for (int w = 0; w < cleaned_arr.length; w++) {
        String word = cleaned_arr[w];
        for (int d = 0; d < dicts.length; d++) {
          HashMap<String, Integer> curDict = dicts[d];
          if (!curDict.containsKey(word)) {
            curDict.put(word, 0);
          }
          if (d == i) {
            curDict.put(word, curDict.get(word)+1);
          }
        }
      }
      
      try {
        line = reader.readLine();
      } catch (IOException e) {
        e.printStackTrace();
        line = null;
      }
    }
  }
}



void keyPressed() {
  if (key == ' ') {
    saveFrame("tfidf.png");
  }
}
