import 'package:flutter/animation.dart';

class MyAnimationUtil {
  /// 路由跳转动画：从右往左进，从左往右出
  static Animation<Offset> createPageAnimationDefault(
      Animation<double> animation) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return animation.drive(tween);
  }
}
