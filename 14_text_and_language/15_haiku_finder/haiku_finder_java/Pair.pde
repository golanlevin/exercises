// the pair class is used to store words and their syllable counts
class Pair {
  String word;
  int syls;

  Pair (String word, int syls) {
    this.word = word;
    this.syls = syls;
  }

  String toString () {
    return word + " " + syls;
  }
}
