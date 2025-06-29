/*
 * This file includes code from the 'word_cloud' project by RGLie,
 * licensed under the MIT License.
 * https://github.com/RGLie/word_cloud
 *
 * Copyright (c) 2023 RGLie
 * See THIRD-PARTY-LICENSES.md for the full license text.
 */





class WordCloudData {
  final List<({String word, double weight})> _data;

  WordCloudData({
    required List<({String word, double weight})> sortedData,
  }):
    _data = sortedData;

  late final _mapped = _data.map((e) => {'word': e.word, 'value': e.weight}).toList();

  List<Map> mapData() => _mapped;
}
