import 'package:flutter/material.dart';

class GridSize {
  final Size size;
  final Size gridSize;
  final int xCount;
  final int yCount;

  GridSize(this.size, this.xCount, this.yCount, this.gridSize);
}

GridSize getWidgetSize(Size size, double padding) {
  // var strokeWidth = 3.0;

  var width = size.width - 2 * padding;
  var height = size.height - 2 * padding;
  //设一个格子为80x80

  //求x有几个格子
  int xCount = (width / 80).ceil();
  //求y有几个格子
  int yCount = (height / 80).ceil();

  //求每个格子的宽度
  double xWidth = width / xCount;
  //求每个格子的高度
  double yHeight = height / yCount;
  return GridSize(Size(width, height), xCount, yCount, Size(xWidth, yHeight));
}
