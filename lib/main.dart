import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/Test.dart';
import 'package:flutter_app/pages/AnimatedSwitcherDemo.dart';
import 'package:flutter_app/pages/DateSelectorCameraAndAndroidView.dart';
import 'package:flutter_app/pages/MainDrawer.dart';
import 'package:flutter_app/pages/NewPage.dart';
import 'package:flutter_app/pages/StaggerDemo.dart';
import 'package:flutter_app/pages/VideoPlayerPage.dart';
import 'package:flutter_app/pages/WebViewPage.dart';
import 'package:flutter_app/utils/BatteryChannel.dart';
import 'package:flutter_app/utils/MyPageRouteUtil.dart';

void collectLog(String line) {
  //收集日志
}

void reportErrorAndLog(FlutterErrorDetails details) {
  //上报错误和日志逻辑
}

FlutterErrorDetails? makeDetails(Object obj, StackTrace stack) {
  // 构建错误信息
  return null;
}

void main() {
  var onError = FlutterError.onError; //先将 onerror 保存起来
  FlutterError.onError = (FlutterErrorDetails details) {
    onError?.call(details); //调用默认的onError
    reportErrorAndLog(details); //上报
  };
  runZoned(
    () => runApp(const MyApp()),
    zoneSpecification: ZoneSpecification(
      // 拦截 print
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        collectLog(line);
        parent.print(zone, "Interceptor: $line");
      },
      // 拦截未处理的异步错误
      handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone,
          Object error, StackTrace stackTrace) {
        // reportErrorAndLog(details);
        parent.print(zone, '${error.toString()} $stackTrace');
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log("StatelessWidget#build()", name: "lifecycle");
    testDart();
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // initialRoute:"main", //名为"/"的路由作为应用的home(首页)
      routes: {
        // 添加路由表信息
        // "main": (context) => const MyApp(),
        "newPage": (context) => const NewPage(),
        // 如果 NewPage 中需要传递一个 text 参数，则在路由表中可以这样写
        // "newPage": (context) => const NewPage(text: ModalRoute.of(context)!.settings.arguments),
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
            builder: (builder) {
              // 不在上面路由表中的命名路由跳转会进入这个方法，在这里可以对用户是否登录或是否有权限进行判断
              log("onGenerateRoute, name:${settings.name}, arguments:${settings.arguments}");
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
            },
            settings: settings);
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

/// State 生命周期
/// initState()：在第一次创建 widget 时调用，之后不再调用。
/// didChangeDependencies()：在 widget 的依赖项发生变化时调用，例如：当父 widget 的某个值发生变化时。
/// didUpdateWidget()：在 widget 的配置发生变化时调用，例如：当父 widget 的某个值发生变化时。
/// deactivate()：当 widget 从树中移除时调用，之后 widget 可能会被重新插入到树中。
/// dispose()：在 widget 被永久移除时调用，之后 widget 将不再被使用。
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _selectedIndex = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void test() {}

  @override
  void initState() {
    super.initState();
    BatteryChannel.initChannels();
    print("This is main page.");
    log("initState()", name: "lifecycle");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    log("didChangeDependencies()", name: "lifecycle");
  }

  /// State 第一次生成的时候不会调用，再次生成的时候会先于 build 方法执行
  @override
  void reassemble() {
    super.reassemble();
    log("reassemble()", name: "lifecycle");
  }

  @override
  Widget build(BuildContext context) {
    log("State#build()", name: "lifecycle");
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
                        const Image(image: AssetImage("assets/img_test.jpg")),
                        Image.asset("images/thunder.png")
                      ],
                    ),
                  );
                  break;
                case 1:
                  children = GestureDetector(
                    onTap: () async {
                      var result = await Navigator.pushNamed(
                          context, "testPage",
                          arguments: "{testArguments:\"ok\"}");
                      log("Next Page disposed return value:$result");
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
                          case 7:
                            Scaffold.of(context).openDrawer();
                          case 8:
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("SnackBar Test")));
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
                          case 7:
                            return const Text("OpenDrawer");
                          case 8:
                            return const Text("SnackBar");
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: const Drawer(child: MainDrawer()),
      // bottomNavigationBar: BottomNavigationBar( // 底部导航
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
      //     BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
      //   ],
      //   currentIndex: _selectedIndex,
      //   fixedColor: Colors.blue,
      //   onTap: _onItemTapped,
      // ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.home), onPressed: () {  },),
            const SizedBox(), //中间位置空出
            IconButton(icon: const Icon(Icons.business), onPressed: () {  },),
          ], //均分底部导航栏横向空间
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    log("didUpdateWidget()", name: "lifecycle");
  }

  @override
  void deactivate() {
    super.deactivate();
    log("deactivate()", name: "lifecycle");
  }

  @override
  void dispose() {
    super.dispose();
    log("dispose()", name: "lifecycle");
  }
}

extension ScreenSizeScaleUtil on int {
  double get test => this * 2;
  double get dp => this * 2;
}
