/*
 * This file includes code from the 'word_cloud' project by RGLie,
 * licensed under the MIT License.
 * https://github.com/RGLie/word_cloud
 *
 * Copyright (c) 2023 RGLie
 * See THIRD-PARTY-LICENSES.md for the full license text.
 */





import 'package:flutter/material.dart';
import 'word_cloud_data.dart';
import 'word_cloud_setting.dart';
import 'word_cloud_shape.dart';
import 'word_cloud_tap.dart';

class WordCloudTapView extends StatefulWidget {
  final WordCloudData data;
  final Color? mapcolor;
  final Decoration? decoration;
  final double mapwidth;
  final String? fontFamily;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final double mapheight;
  final List<Color>? colorlist;
  final int attempt;
  final double mintextsize;
  final double maxtextsize;
  final WordCloudShape? shape;
  final WordCloudTap wordtap;

  const WordCloudTapView({
    super.key,
    required this.data,
    required this.mapwidth,
    required this.mapheight,
    required this.wordtap,
    this.mintextsize = 10,
    this.maxtextsize = 100,
    this.attempt = 30,
    this.shape,
    this.fontFamily,
    this.fontStyle,
    this.fontWeight,
    this.mapcolor,
    this.decoration,
    this.colorlist,
  });
  @override
  State<WordCloudTapView> createState() => _WordCloudTapViewState();
}

class _WordCloudTapViewState extends State<WordCloudTapView> {
  late WordCloudShape wcshape;
  late WordCloudSetting wordcloudsetting;

  @override
  void initState() {
    super.initState();
    if (widget.shape == null) {
      wcshape = WordCloudShape();
    } else {
      wcshape = widget.shape!;
    }

    wordcloudsetting = WordCloudSetting(
      data: widget.data.mapData(),
      minTextSize: widget.mintextsize,
      maxTextSize: widget.maxtextsize,
      attempt: widget.attempt,
      shape: wcshape,
    );

    wordcloudsetting.setMapSize(widget.mapwidth, widget.mapheight);
    wordcloudsetting.setFont(
        widget.fontFamily, widget.fontStyle, widget.fontWeight);
    wordcloudsetting.setColorList(widget.colorlist);
    wordcloudsetting.setInitial();
    wordcloudsetting.drawTextOptimized();

    
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragDown: (details) {
        final mapData = widget.data.mapData();
        for (var i = 0; i < mapData.length; i++) {
          List points = wordcloudsetting.textPoints;
          double w = wordcloudsetting.textlist[i].width;
          double h = wordcloudsetting.textlist[i].height;
          if (points[i][0] < details.localPosition.dx &&
              details.localPosition.dx < (points[i][0] + w) &&
              points[i][1] < details.localPosition.dy &&
              details.localPosition.dy < (points[i][1] + h)) {
            if(widget.wordtap.getWordTaps().containsKey(mapData[i]['word'] )){
              widget.wordtap.getWordTaps()[mapData[i]['word']]!();
            }
            
          }
        }
      },
      child: Container(
        width: widget.mapwidth,
        height: widget.mapheight,
        color: widget.mapcolor,
        decoration: widget.decoration,
        child: CustomPaint(
          painter: WCTpaint(wordcloudpaint: wordcloudsetting),
        ),
      ),
    );
  }
}

class WCTpaint extends CustomPainter {
  final WordCloudSetting wordcloudpaint;
  WCTpaint({
    required this.wordcloudpaint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < wordcloudpaint.getDataLength(); i++) {
      if (wordcloudpaint.isdrawed[i]) {
        wordcloudpaint.getTextPainter()[i].paint(
            canvas,
            Offset(wordcloudpaint.getWordPoint()[i][0],
                wordcloudpaint.getWordPoint()[i][1]));
      }
    }
  }

  @override
  bool shouldRepaint(WCTpaint oldDelegate) => oldDelegate.wordcloudpaint != wordcloudpaint;
}
