import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/AnimatedSwitcherDemo.dart';
import 'package:flutter_app/pages/NewPage.dart';
import 'package:flutter_app/pages/DateSelectorCameraAndAndroidView.dart';
import 'package:flutter_app/pages/StaggerDemo.dart';
import 'package:flutter_app/pages/VideoPlayerPage.dart';
import 'package:flutter_app/pages/WebViewPage.dart';
import 'package:flutter_app/utils/BatteryChannel.dart';
import 'package:flutter_app/utils/MyPageRouteUtil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        // 添加路由表信息
        "newPage": (context) => const NewPage()
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (builder) {
          // 不在上面路由表中的命名路由跳转会进入这个方法，在这里可以对用户是否登录或是否有权限进行判断
          log("onGenerateRoute: ${settings.name}");
          switch (settings.name) {
            case "testPage":
              {
                return const DateSelectorCameraAndAndroidView();
              }
            case "StaggerDemo":
              {
                return const StaggerDemo();
              }
            case "AnimatedSwitcherDemo":
              {
                return const AnimatedSwitcherDemo();
              }
            default:
              {
                return const Text("This is not a valid page.");
              }
          }
        });
      },
      home: const MyHomePage(title: 'Home'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    BatteryChannel.initChannels();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void test() {}

  @override
  Widget build(BuildContext context) {
    BatteryChannel.getBatteryLevel()
        .then((value) => {log('Battery Level:$value')})
        .catchError((onError) {
      log('Get battery level failed: $onError');
    });

    final colorList = <Color>[
      Colors.purple[50]!,
      Colors.purple[100]!,
      Colors.transparent,
      Colors.transparent,
      Colors.transparent,
      Colors.purple[200]!,
      Colors.purple[300]!,
      Colors.purple[400]!,
      Colors.purple[500]!,
      Colors.purple[600]!,
      Colors.purple[700]!,
      Colors.purple[800]!,
      Colors.purple[900]!,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.grey[100],
        child: ListView.builder(
            itemCount: colorList.length,
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Widget children;
              switch (index) {
                case 0:
                  children = GestureDetector(
                    onTap: () => {
                      Navigator.push(
                              context,
                              MaterialPageRoute<String>(
                                  builder: (context) {
                                    return const NewPage();
                                  },
                                  fullscreenDialog: true))
                          .then((value) => {log("push callback value:$value")})
                          .catchError(
                              (onError) => {log('push failed: $onError')})
                    },
                    child: Row(
                      children: [
                        Text(
                          "打开下一个页面",
                          style: TextStyle(
                              height: 2.test,
                              backgroundColor: Colors.amberAccent),
                        ),
                        const Image(image: AssetImage("assets/img_test.jpg"))
                      ],
                    ),
                  );
                  break;
                case 1:
                  children = GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, "testPage", arguments: "")
                    },
                    child: const Text(
                      "datadatadatadatadatadatadatadatadatadatadata",
                      style:
                          TextStyle(height: 15, backgroundColor: Colors.blue),
                    ),
                  );
                  break;
                case 2:
                  children = InkWell(
                    child: Row(children: [
                      IconButton(
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(60, 60))),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add_business,
                            color: Colors.green,
                          )),
                      const Text("打开日期选择器和相机")
                    ]),
                    onTap: () {
                      // 自定义转场动画
                      MyPageRouteUtil.rightInAndLeftOut(
                          context, const DateSelectorCameraAndAndroidView());
                    },
                  );
                  break;
                case 3:
                  children = InkWell(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(60, 60))),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.video_library,
                                color: Colors.green,
                              )),
                          const Text("打开视频播放器")
                        ]),
                    onTap: () {
                      // 自定义转场动画
                      MyPageRouteUtil.rightInAndLeftOut(
                          context, const VideoPlayerPage());
                    },
                  );
                  break;
                case 4:
                  children = InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(60, 60))),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.web_rounded,
                              color: Colors.green,
                            )),
                        const Text("打开 WebView")
                      ],
                    ),
                    onTap: () {
                      // 自定义转场动画
                      MyPageRouteUtil.rightInAndLeftOut(
                          context, const WebViewPage());
                    },
                  );
                  break;
                default:
                  children = Padding(
                    padding: const EdgeInsets.all(15),
                    child: GestureDetector(
                      onTap: () {
                        switch (index) {
                          case 5:
                            Navigator.pushNamed(context, "StaggerDemo");
                            break;
                          case 6:
                            Navigator.pushNamed(
                                context, "AnimatedSwitcherDemo");
                            break;
                        }
                        log("data $index");
                      },
                      child: () {
                        switch (index) {
                          case 5:
                            return const Text("StaggerAnimation");
                          case 6:
                            return const Text("AnimatedSwitcherDemo");
                          default:
                            return Text("data $index");
                        }
                      }(),
                    ),
                  );
                  break;
              }
              return Container(
                color: colorList[index],
                child: children,
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

extension ScreenSizeScaleUtil on int {
  double get test => this * 2;
}
