import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'MyAnimationUtil.dart';

class MyPageRouteUtil {
  static Future rightInAndLeftOut(BuildContext context, Widget widget) {
    return Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return SlideTransition(
                position: MyAnimationUtil.createPageAnimationDefault(animation),
                child: widget,
              );
            }));
  }
}
