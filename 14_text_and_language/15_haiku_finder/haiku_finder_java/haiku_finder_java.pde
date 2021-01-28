/* From Little Women:
 
 Meg and Jo closed their 
 weary eyes, and lay at rest, 
 like storm beaten boats 
 
 Mrs. Brooke, with her 
 apron over her head, sat 
 sobbing dismally. 
 
 My sister and friends 
 have just come home, and we are 
 all very happy. 
 
 She was wrapped up in 
 Beth, and never wished to hear 
 the word love again. 
 
 He had not foreseen 
 this turn of affairs, and was 
 not prepared for it. 
 
 Beth slept. "Not asleep, 
 but so happy, dear. See, I 
 found this and read it. 
 
 I intend to work 
 hard," said Amy in her most 
 energetic tone. 
 
 Jo looked a little 
 queer likewise, for a name had 
 almost escaped her. 
 
 Laurie's mischief has 
 spoiled you for me. I see it, 
 and so does Mother. 
 
 Do you remember 
 our castles in the air?" 
 asked Amy, smiling 
 */

/*   Haiku Finder.
 *   from http://allendowney.com/haiku/Haiku.java
 *
 *   ------------------------------------------------------
 *
 *   copyright 2002 Allen B. Downey
 *   copyleft  2002 Allen B. Downey
 
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 
 
     ------------


     Haiku.java: this program takes one command-line argument, the
     name of a file.  It searches the file for instances of complete
     sentences that form a haiku (a three-line stanza with 5 syllables
     in the first line, seven in the second, and 5 in the last).
     
     It uses a file named c06d to build a hashtable of words and their
     syllable counts.  This file is from the ftp site
 
           ftp://ftp.cs.cmu.edu/afs/cs.cmu.edu/data/anonftp/project/fgdata/dict/
         
     at CMU.  The idea for this comes from danny@spesh.com
 
           http://www.oblomovka.com/code/haiku/
 
     which provides a similar program in Python.  I looked at his
     code before writing mine, but we use somewhat different algorithms.
     He has some capabilities I don't (like guessing the syllable
     count of unknown words).  But I have some capabilities he doesn't
     (like recognizing multiple-stanza haiku).
 
 */

import java.io.*;
import java.util.Hashtable;
import java.util.StringTokenizer;
import java.util.Vector;

Hashtable syltab;         // table of ( words --> syllable counts )
Vector v;                 // the current line of word pairs
int syllables;            // number of syllables in the current line
Vector lines;             // the accumulated lines
BufferedReader fin;       // the file we are reading
StringTokenizer tokens;   // tokens we have read

boolean finished;
String toDraw;

// constructor: initialize instance variables
void setup () {
  
  size(800, 800); 
  noLoop();
  
  boolean bHuntForHaiku = true;
  if (bHuntForHaiku) {
    syltab = new Hashtable ();
    v = new Vector ();
    syllables = 0;
    lines = new Vector ();
    
    toDraw = "";
    finished = false;

    String syllableDictionary = dataPath("") + "/cmudict.0.6d.txt";
    try {
      readDictionary (syllableDictionary);
    }
    catch (Exception e) {
      System.out.println ("Couldn't read the dictionary: " + syllableDictionary);
      System.exit(-1);
    }

    int[] form = {5, 7, 5}; // the form of a haiku
    String inputDocument = dataPath("") + "/little_women.txt"; 
    getForms (inputDocument, form);
  }

}

void drawHaikus() {
  background(253); 

  System.out.println("Drawing..." + toDraw.length());
  
  String haikus = toDraw; 
  //haikus += "Meg and Jo closed their" + "\n"; 
  //haikus += "weary eyes, and lay at rest," + "\n";
  //haikus += "like storm beaten boats" + "\n";
  //haikus += "" + "\n";
  //haikus += "Mrs. Brooke, with her" + "\n";
  //haikus += "apron over her head, sat" + "\n";
  //haikus += "sobbing dismally." + "\n";
  //haikus += "" + "\n";
  //haikus += "“Do you remember" + "\n";
  //haikus += "our castles in the air?”" + "\n";
  //haikus += "asked Amy, smiling" + "\n"; 

  fill(0); 
  PFont myFont = loadFont("CenturySchoolbook-60.vlw"); 
  textFont(myFont, 40); 
  textLeading(64); 
  textAlign(LEFT); 
  text (haikus, 50, 96);

}

//--------------------------------------------
void keyPressed(){
  if (key == ' '){
    saveFrame("haiku_finder.png"); 
  }
}

//--------------------------------------------
void draw() {
  drawHaikus();
}


//--------------------------------------------
// readDictionary: read c06d and build syltab
void readDictionary (String filename)
  throws FileNotFoundException, IOException {

  FileReader fileReader = new FileReader (filename);
  BufferedReader in = new BufferedReader (fileReader);

  while (true) {
    String s = in.readLine();
    if (s == null) break;
    if (s.charAt(0) == '#') continue; // skip comments
    dictionaryEntry (s);
  }
}

// dictionaryEntry: make an entry in syltab
void dictionaryEntry (String s) {
  StringTokenizer st = new StringTokenizer (s);
  if (!st.hasMoreTokens ()) return;
  String word = st.nextToken().toLowerCase();

  int syls = 0;
  while (st.hasMoreTokens ()) {
    String phone = st.nextToken ();
    if (hasDigit (phone)) syls++;
  }
  //System.out.println (word + " " + syls);
  syltab.put (word, new Integer (syls));
}

// hasDigit: return true if the string contains a digit
//   <note> In cmudict.0.6d.txt, a digit in the string indicates the existence of a syllable.
boolean hasDigit (String s) {
  for (int i=0; i<s.length(); i++) {
    if (Character.isDigit (s.charAt (i))) return true;
  }
  return false;
}


// getForms: get all the forms from the given file.
// only print the ones that are complete sentences.
void getForms (String filename, int[] form) {
  try {
    FileReader fileReader = new FileReader (filename);
    fin = new BufferedReader (fileReader);
  }
  catch (Exception e) {
    println ("Error opening file: " + filename);
    System.exit (-1);
  }

  while (!finished) {
    getForm (form);
    if (completeSentence ()) {
      print ();
    }
    lines.removeAllElements ();
  }
  
  System.out.println("Finished reading.");
}

// getForm: find the next set of words that can be assembled
// into lines with the given form.  The form is an array of
// integers specifying the number of syllables in each line
void getForm (int[] form) {

  if (finished) {
    return;
  }
  
  for (int i=0; i <form.length && !finished; ) {
    getSyllables (form[i]);

    if (syllables == 0 ||
      syllables > form[i] ||
      lines.size()==0 && badStart(v)) {

      // either we found a word with unknown syllables
      // or we have too many syllables
      // or this is not an acceptable first line...
      // in any case we have to start over

      shift ();
      lines.removeAllElements();
      i = 0;
    } else {
      // the current line is good.
      // save it and start the next
      lines.add (v);
      v = new Vector ();
      syllables = 0;
      i++;
    }
  }
}

// getSyllables: keep adding word pairs to the current line
// until the total syllables gets to syls
void getSyllables (int syls) {
  if (finished) {
    return;
  }
  
  while (!finished && syllables < syls) {
    Pair p = getPair ();
    if (p.syls == -1) {
      syllables = 0;
      v.removeAllElements();
      return;
    } else {
      syllables += p.syls;
      v.add (p);
    }
  }
}

// getPair: get the next word-syllable pair from the file
Pair getPair () {
  if (finished) return null;
  String word = getWord ();
  Integer syls = (Integer) syltab.get (clean (word));
  if (syls == null) {
    return new Pair (word, -1);
  } else {
    return new Pair (word, syls.intValue());
  }
}

// getWord: get the next word from the file
String getWord () {
  if (finished) return null;
  while (!finished && (tokens == null || tokens.hasMoreTokens() == false)) {
    tokens = getTokens ();
  }
  if (finished) return null;
  return tokens.nextToken ();
}

// getTokens: read a line from the file and tokenize it
// BUG: gets rid of hyphens
public StringTokenizer getTokens () {
  if (finished) return null;
  try {
    String s = fin.readLine();
    if (s == null) {
      finished = true;
      System.out.println("Reached end of file.");
      return null;
      //System.out.println("Exiting at getTokens() 1"); 
      //System.exit (0);
    }
    return new StringTokenizer (s, " -");
  } 
  catch (Exception e) {
    System.out.println ("I/O Error.");
    System.out.println("Exiting at getTokens() 2");
    System.exit (-1);
  }
  return null;
}

// shift: remove the first word from the current line
void shift () {
  if (v.size() > 0) {
    Pair p = (Pair) v.remove (0);
    syllables -= p.syls;
  }
}

// clean: clean a string by tokenizing it and taking the
// first token that begins with a letter
// BUG: expressions like object.method will have the syllable
// count of the first word only
String clean (String s) {
  if (s == null) return "";
  StringTokenizer st = new StringTokenizer (s, 
    "0123456789@#$%^&*\"`'()<>[]{}.,:;?!+=/\\");
  while (st.hasMoreTokens ()) {
    String word = st.nextToken ();
    if (Character.isLetter (word.charAt (0))) 
      return word.toLowerCase();
  }      
  return "";
}

// badStart: return true if this line doesn't begin with a
// capital letter
boolean badStart (Vector v) {
  Pair p = (Pair) v.get(0);
  return !Character.isUpperCase (p.word.charAt(0));
}

// completeSentence: return true if the first line begins
// with a capital letter and the last line ends with a period
boolean completeSentence () {
  if (finished) return false;
  
  Vector first = (Vector) lines.get(0);
  if (badStart (first)) return false;

  Vector last = (Vector) lines.get(lines.size()-1);
  Pair p = (Pair) last.get(last.size()-1);
  return p.word.charAt(p.word.length()-1) == '.';
}


// printLine: print a vector of word pairs with spaces between
void printLine (Vector line) {
  for (int i=0; i < line.size(); i++) {
    Pair p = (Pair) line.get(i);
    System.out.print (p.word + " ");
    toDraw += (p.word+" ");
  }
  toDraw += ("\n");
  System.out.println ("");
}

// print: print all the lines
void print () {
  for (int i=0; i<lines.size(); i++) {
    printLine ((Vector) lines.get(i));
  }
  toDraw += ("\n");
  System.out.println ("");
}
