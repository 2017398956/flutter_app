import 'package:flutter/cupertino.dart';

/// 定义自己的字体图标，fontFamily 要在 asset 中配置，这里没有配置
class MyIcons {
  // book 图标
  static const IconData book =
      IconData(0xe614, fontFamily: 'myIcon', matchTextDirection: true);

  // 微信图标
  static const IconData wechat =
      IconData(0xec7d, fontFamily: 'myIcon', matchTextDirection: true);
}
