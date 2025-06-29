/*
 * This file includes code from the 'word_cloud' project by RGLie,
 * licensed under the MIT License.
 * https://github.com/RGLie/word_cloud
 *
 * Copyright (c) 2023 RGLie
 * See THIRD-PARTY-LICENSES.md for the full license text.
 */





class WordCloudTap {
  Map<String, Function> wordtap = {};

  void addWordtap(String word, Function func) {
    wordtap[word] = func;
  }

  Map<String, Function> getWordTaps() {
    return wordtap;
  }
}
