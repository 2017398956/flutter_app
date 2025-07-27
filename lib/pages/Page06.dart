import 'package:flutter/cupertino.dart';
import 'package:flutter_app/base/ViewUtil.dart';

class Page06 extends StatefulWidget {
  const Page06({super.key});

  @override
  State<StatefulWidget> createState() {
    return Page06State();
  }

}

class Page06State extends State<Page06> {

  @override
  Widget build(BuildContext context) {
    return ViewUtil.createPageView(context, "第六章 可滚动组件", null);
  }

}