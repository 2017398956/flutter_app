import 'package:flutter/material.dart';

import '../base/ViewUtil.dart';

class Page04 extends StatefulWidget {
  const Page04({super.key});

  @override
  State<Page04> createState() => _Page04_01_State();
}

class _Page04State extends State<Page04> {
  Widget redBox = const DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    return ViewUtil.createPageView(
        context,
        "第四章 布局类组件",
        Column(
          children: <Widget>[
            // Flex的两个子widget按1：2来占据水平空间
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 30.0,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30.0,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                height: 100.0,
                // Flex 的三个子widget，在垂直方向按 2：1：1 来占用100像素的空间
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 30.0,
                        color: Colors.red,
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 30.0,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class _Page04_01_State extends State<Page04> {
  static const redBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );
  static const redSizedBox = SizedBox(
    width: 50,
    height: 50,
    child: redBox,
  );
  static const redText =
      Text("This is a Text.", style: TextStyle(backgroundColor: Colors.red));

  @override
  Widget build(BuildContext context) {
    return ViewUtil.createPageView(
        context,
        "title",
        Container(
          color: Colors.green,
          child: Column(
            children: [
              Expanded(
                  child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                color: Colors.yellowAccent,
                child: const Expanded(child: redText),
              ))
            ],
          ),
        ));
  }
}
