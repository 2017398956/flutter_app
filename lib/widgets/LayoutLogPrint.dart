import 'dart:developer';

import 'package:flutter/cupertino.dart';

class LayoutLogPrint<T> extends StatelessWidget {
  const LayoutLogPrint({
    super.key,
    this.tag,
    required this.child,
  });

  final Widget child;
  final T? tag; //指定日志 tag

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // assert在编译release版本时会被去除
      assert(() {
        log('${tag ?? key ?? child}: $constraints');
        return true;
      }());
      return child;
    });
  }
}
