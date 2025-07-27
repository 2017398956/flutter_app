import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/pages/Page03.dart';
import 'package:flutter_app/pages/Page06.dart';
import 'package:flutter_app/utils/MyPageRouteUtil.dart';

import 'Page04.dart';
import 'Page05.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.fromLTRB(20.dp, 50.dp, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: const Text("第三章 基础组件"),
              onTap: () =>
                  {MyPageRouteUtil.rightInAndLeftOut(context, const Page03())},
            ),
            GestureDetector(
              child: const Text("第四章 布局类组件"),
              onTap: () =>
                  {MyPageRouteUtil.rightInAndLeftOut(context, const Page04())},
            ),
            GestureDetector(
              child: const Text("第五章 容器类组件"),
              onTap: () =>
              {MyPageRouteUtil.rightInAndLeftOut(context, const Page05())},
            ),
            GestureDetector(
              child: const Text("第六章 可滚动组件"),
              onTap: () =>
              {MyPageRouteUtil.rightInAndLeftOut(context, const Page06())},
            ),
          ],
        ),
      ),
    );
  }
}
