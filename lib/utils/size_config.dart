import 'package:flutter/widgets.dart';

/// dynamic sizing according to your mobile screen
class SizeConfig {
  /// safeArea in horizontal direction for width
  static double? safeAreaHorizontal;

  /// safeArea in vertical direction for height
  static double? safeAreaVertical;

  /// to initialize with mediaQuery
  void init(BuildContext context) {
    safeAreaHorizontal = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left +
        MediaQuery.of(context).padding.right;
    safeAreaVertical = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
  }
}
