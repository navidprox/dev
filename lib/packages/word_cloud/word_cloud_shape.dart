/*
 * This file includes code from the 'word_cloud' project by RGLie,
 * licensed under the MIT License.
 * https://github.com/RGLie/word_cloud
 *
 * Copyright (c) 2023 RGLie
 * See THIRD-PARTY-LICENSES.md for the full license text.
 */





class WordCloudShape {
  double boundaryStartX = 0;
  double boundaryEndX = 0;
  double boundaryStartY = 0;
  double boundaryEndY = 0;
  String type = 'normal';

  String getType() {
    return type;
  }
}

class WordCloudCircle extends WordCloudShape {
  double radius;

  WordCloudCircle({required this.radius}) {
    type = 'circle';
  }

  double getRadius() {
    return radius;
  }
}

class WordCloudEllipse extends WordCloudShape {
  double majoraxis;
  double minoraxis;

  WordCloudEllipse({
    required this.majoraxis,
    required this.minoraxis,
  }) {
    type = 'ellipse';
  }

  double getMajorAxis() {
    return majoraxis;
  }

  double getMinorAxis() {
    return minoraxis;
  }
}
