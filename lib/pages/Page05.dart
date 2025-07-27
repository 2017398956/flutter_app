import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/ViewUtil.dart';
import 'package:flutter_app/widgets/SingleLineFittedBox.dart';

class Page05 extends StatefulWidget {
  const Page05({super.key});

  @override
  State<StatefulWidget> createState() {
    return Page05State();
  }
}

class Page05State extends State<Page05> {
  Widget wContainer(BoxFit boxFit) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.red,
      child: FittedBox(
        fit: boxFit,
        // 子容器超过父容器大小
        child: Container(width: 60, height: 70, color: Colors.blue),
      ),
    );
  }

  // 直接使用Row
  Widget wRow(String text) {
    Widget child = Text(text);
    child = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [child, child, child],
    );
    return child;
  }

  Widget? createWidgetByType(int type) {
    Widget? widget;
    switch (type) {
      case 0:
        widget = DecoratedBox(
            decoration: BoxDecoration(
                border: const Border(
                    bottom: BorderSide(color: Colors.black, width: 5)),
                gradient: LinearGradient(
                    colors: [Colors.red, Colors.orange.shade700]), //背景渐变
                borderRadius: BorderRadius.circular(13.0), //3像素圆角
                boxShadow: const [
                  //阴影
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0)
                ]),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            ));
        break;
      case 1:
        widget = Transform(
          origin: const Offset(-150, 0),
          alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
          transform: Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.deepOrange,
            child: const Text('Apartment for rent!'),
          ),
        );
        break;
      case 2:
        widget = DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          //默认原点为左上角，左移20像素，向上平移5像素
          child: Transform.translate(
            offset: const Offset(-20.0, -5.0),
            child: const Text("Hello world"),
          ),
        );
        break;
      case 3:
        widget = DecoratedBox(
          decoration: const BoxDecoration(color: Colors.red),
          child: Transform.rotate(
            //旋转90度
            angle: math.pi / 2,
            child: const Text("Hello world"),
          ),
        );
        break;
      case 4:
        widget = DecoratedBox(
            decoration: const BoxDecoration(color: Colors.red),
            child: Transform.scale(
                scale: 2, //放大到1.5倍
                child: const Text("Hello world")));
        break;
      case 5:
        widget = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
                child: Transform.scale(
                    scale: 1.5, child: const Text("Hello world"))),
            const Text(
              "你好",
              style: TextStyle(color: Colors.green, fontSize: 18.0),
            )
          ],
        );
        break;
      case 6:
      // RotatedBox 和 Transform.rotate 功能相似，它们都可以对子组件进行旋转变换，
      // 但是有一点不同：RotatedBox 的变换是在 layout 阶段，会影响在子组件的位置和大小。
        widget = const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              //将Transform.rotate换成RotatedBox
              child: RotatedBox(
                quarterTurns: 1, //旋转90度(1/4圈)
                child: Text("Hello world"),
              ),
            ),
            Text(
              "你好",
              style: TextStyle(color: Colors.green, fontSize: 18.0),
            )
          ],
        );
        break;
      case 7:
      // 头像
        Widget avatar = Image.asset("images/thunder.png", width: 60.0);
        widget = Center(
          child: Column(
            children: <Widget>[
              avatar, //不剪裁
              ClipOval(child: avatar), //剪裁为圆形
              ClipRRect(
                //剪裁为圆角矩形
                borderRadius: BorderRadius.circular(15.0),
                child: avatar,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    widthFactor: .5, //宽度设为原来宽度一半，另一半会溢出
                    child: avatar,
                  ),
                  const Text(
                    "你好世界",
                    style: TextStyle(color: Colors.green),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRect(
                    //将溢出部分剪裁
                    child: Align(
                      alignment: Alignment.topLeft,
                      widthFactor: .5, //宽度设为原来宽度一半
                      child: avatar,
                    ),
                  ),
                  const Text("你好世界", style: TextStyle(color: Colors.green))
                ],
              ),
              DecoratedBox(
                decoration: const BoxDecoration(color: Colors.red),
                child: ClipRect(
                    clipper: MyClipper(), //使用自定义的clipper
                    child: avatar),
              ),
              DecoratedBox(
                decoration: const BoxDecoration(color: Colors.yellowAccent),
                child: ClipPath(
                    clipper: MyClipperPath(), //使用自定义的clipper
                    clipBehavior: Clip.antiAlias,
                    child: avatar),
              ),
            ],
          ),
        );
        break;
      case 8:
        widget = Center(
          child: Column(
            children: [
              // 子 View 超出父 View 和下面的 Text 重合
              wContainer(BoxFit.none),
              const Text('Wendux'),
              wContainer(BoxFit.contain),
              const Text('Flutter中国'),
              // 裁减掉超出父 View 的部分
              ClipRect(child: wContainer(BoxFit.none),),
              const Text('Wendux'),
            ],
          ),
        );
        break;
      case 9:
        widget = Center(
          child: Column(
            children: [
              wRow(' 900000000000000000000000000000000 '),
              FittedBox(child: wRow(' 90000000000000000 ')),
              wRow(' 800 '),
              FittedBox(child: wRow(' 800 ')),
              SingleLineFittedBox(child: wRow(' 800 '),),
              SingleLineFittedBox(child: wRow(' 900000000000000000000000000000000 '),),
            ].map((e) =>
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: e,
                ))
                .toList(),
          ),
        );
        break;
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return ViewUtil.createPageView(
        context, "第五章 容器类组件", createWidgetByType(9));
  }
}

class MyClipper extends CustomClipper<Rect> {
  // getClip() 是用于获取剪裁区域的接口，由于图片大小是 60×60，我们返回剪裁区域为
  // Rect.fromLTWH(10.0, 15.0, 40.0, 30.0)，即图片中部 40×30 像素的范围。
  @override
  Rect getClip(Size size) => const Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);

  // shouldReclip() 接口决定是否重新剪裁。如果在应用中，剪裁区域始终不会发生变化时应该返回 false，
  // 这样就不会触发重新剪裁，避免不必要的性能开销。如果剪裁区域会发生变化（比如在对剪裁区域执行一个动画），
  // 那么变化后应该返回 true 来重新执行剪裁。
  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}

class MyClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    log("size width:${size.width},height:${size.height}");
    double w = size.width / 2;
    double h = size.height / 2;
    Path path;
    path = Path()
      ..moveTo(0, h)
      ..lineTo(w, 0)..lineTo(2 * w, h)..lineTo(w, 2 * h)
      ..close();
    // path = Path()..addRect(const Rect.fromLTWH(10.0, 15.0, 40.0, 30.0));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
