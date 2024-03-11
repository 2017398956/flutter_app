import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/NewPage.dart';
import 'package:flutter_app/pages/NewRoute.dart';
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
                                    return NewPage();
                                  },
                                  fullscreenDialog: true))
                          .then(
                              (value) => {log("push callback value:${value}")})
                          .catchError(
                              (onError) => {log('push failed: $onError')})
                    },
                    child: Text(
                      "打开下一个页面",
                      style: TextStyle(
                          height: 2.test, backgroundColor: Colors.amberAccent),
                    ),
                  );
                  break;
                case 1:
                  children = const Text(
                    "datadatadatadatadatadatadatadatadatadatadata",
                    style: TextStyle(height: 15, backgroundColor: Colors.blue),
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
                          context, const NewRoute());
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
                    child: Text("data $index"),
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
