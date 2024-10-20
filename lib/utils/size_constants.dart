import 'package:flutter/material.dart';

class SizeConst {
  static EdgeInsets pagePadding =
      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 30.0);
}

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;
  static double? devicePixel;
  static EdgeInsets? padding;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    devicePixel = _mediaQueryData!.devicePixelRatio;
    padding = _mediaQueryData!.padding;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
    _safeAreaHorizontal =
        _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical =
        _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;
    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;
  }
}

extension SizeExtension on num {
  double get w => SizeConfig.blockSizeHorizontal! * this;
  double get h => SizeConfig.blockSizeVertical! * this;
  double get sw => SizeConfig.safeBlockHorizontal! * this;
  double get sh => SizeConfig.safeBlockVertical! * this;
  Widget get wBox => SizedBox(width: w);
  Widget get hBox => SizedBox(height: h);
}
