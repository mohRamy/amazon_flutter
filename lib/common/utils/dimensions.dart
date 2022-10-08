import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext{
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;

  double get toPadding => MediaQuery.of(this).viewPadding.top;
  double get bottom => MediaQuery.of(this).viewInsets.bottom;
  
  // page
  double get pageView => screenHeight / 2.64;
  double get pageViewContainer => screenHeight / 3.84;
  double get pageViewTextContainer => screenHeight / 7.03;

  // dynamic height padding and margin
  double get height10 => screenHeight / 84.4;
  double get height15 => screenHeight / 56.27;
  double get height20 => screenHeight / 42.2;
  double get height30 => screenHeight / 28.13;
  double get height45 => screenHeight / 18.76;

  // dynamic width padding and margin
  double get width10 => screenHeight / 84.4;
  double get width15 => screenHeight / 56.27;
  double get width20 => screenHeight / 42.2;
  double get width30 => screenHeight / 28.13;

  // font size
  double get font16 => screenHeight / 52.75;
  double get font20 => screenHeight / 42.2;
  double get font26 => screenHeight / 32.46;

  // radius
  double get radius15 => screenHeight / 56.27;
  double get radius20 => screenHeight / 42.2;
  double get radius30 => screenHeight / 28.13;

  // icon Size
  double get iconSize24 => screenHeight / 35.17;
  double get iconSize16 => screenHeight / 52.75;

  // list view size
  double get listViewImgSize => screenWidth / 3.25;
  double get listViewTextConSize => screenWidth / 3.9;

  // spash screen
  double get splashImg => screenHeight / 3.38;

// to use 'context.width'
}