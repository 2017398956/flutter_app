import 'package:flutter/material.dart';
import 'package:flutter_app/base/ViewUtil.dart';

class Page03 extends StatelessWidget {
  const Page03({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewUtil.createPageView(
        context,
        "第三章 基础组件",
        const Column(children: [
          Text("data"),
          Text("data"),
        ],));
  }
}
