import 'package:flutter/material.dart';

const Widget sizedHeight5 = SizedBox(height: 5);

extension SpacedXY on double {
  SizedBox get spaceX => SizedBox(width: this);
  SizedBox get spaceY => SizedBox(height: this);
}

extension SpacediXY on int {
  SizedBox get spaceX => SizedBox(width: toDouble());
  SizedBox get spaceY => SizedBox(height: toDouble());
}
