import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CursorPositionController extends GetxController {
  var xPosition = (-100).toDouble().obs;
  var yPosition = (-100).toDouble().obs;
  var isHover = false.obs;

  CursorPositionController();

  void updatePosition(Offset offset) {
    xPosition.value = offset.dx;
    yPosition.value = offset.dy;
  }

  double get dx {
    return xPosition.value;
  }

  double get dy {
    return yPosition.value;
  }
}
