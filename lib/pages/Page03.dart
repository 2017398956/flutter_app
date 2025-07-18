import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/ViewUtil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Page03 extends StatefulWidget {
  const Page03({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Page03State();
  }
}

class _Page03State extends State<Page03> {
  static const String TAG = "Page03";
  bool _switchSelected = false;
  bool? _checkboxSelected;
  String text = "Hello world! I'm Jack. " * 3;
  static const content =
      "Hello world! I'm Jack. Hello world! I'm Jack. Hello world! I'm Jack. Hello world! I'm Jack. Hello world! I'm Jack. ";
  String icons = "";

  //定义一个controller
  final TextEditingController _unameController = TextEditingController();
  late FocusScopeNode _focusScopeNode;
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _pwdFocusNode = FocusNode();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // accessible: 0xe03e
    icons += "\uE03e";
// error:  0xe237
    icons += " \uE237";
// fingerprint: 0xe287
    icons += " \uE287";
    //监听输入改变
    _unameController.addListener(() {
      log(_unameController.text, name: TAG);
    });
    // _unameController.text="hello world!";
    // _unameController.selection=TextSelection(
    //     baseOffset: 2,
    //     extentOffset: _unameController.text.length
    // );
    _nameFocusNode.addListener(() {
      log("name focus changed to ${_nameFocusNode.hasFocus}", name: TAG);
    });
  }

  @override
  Widget build(BuildContext context) {
    _focusScopeNode = FocusScope.of(context);
    return ViewUtil.createPageView(
        context,
        "第三章 基础组件",
        Scrollbar(
          child: SingleChildScrollView(
              child: Column(
            textDirection: TextDirection.rtl,
            verticalDirection: VerticalDirection.down,
            children: [
              const Text(
                content,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textScaler: TextScaler.linear(2.0),
              ),
              const Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontFamily: "Courier",
                  // package: "包名",
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.blue,
                  decorationStyle: TextDecorationStyle.dashed,
                  decorationThickness: 2.0,
                  backgroundColor: Colors.yellow,
                ),
              ),
              Text.rich(TextSpan(children: [
                const TextSpan(text: "Home: "),
                TextSpan(
                    text: "https://flutterchina.club",
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        log("click url.", name: "Page03");
                        Fluttertoast.showToast(msg: "click url.");
                      }),
              ])),
              const DefaultTextStyle(
                // 1.设置文本默认样式
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.start,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("hello world"),
                    Text("I am Jack"),
                    Text(
                      "I am Jack",
                      style: TextStyle(
                          inherit: false, // 2.不继承默认样式
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text("normal"),
                onPressed: () {},
              ),
              ElevatedButton.icon(
                  onPressed: () {},
                  label: const Text("发送"),
                  icon: const Icon(Icons.send)),
              TextButton(
                child: const Text("normal"),
                onPressed: () {},
              ),
              TextButton.icon(
                icon: const Icon(Icons.info),
                label: const Text("详情"),
                onPressed: () {},
              ),
              OutlinedButton(
                child: const Text("normal"),
                onPressed: () {},
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("添加"),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.thumb_up),
                onPressed: () {},
              ),
              Text(
                icons,
                style: const TextStyle(
                  fontFamily: "MaterialIcons",
                  fontSize: 24.0,
                  color: Colors.green,
                ),
              ),
              // 使用图标就像使用文本一样，但是这种方式需要我们提供每个图标的码点，这对开发者并不友好，
              // 所以，Flutter封装了IconData和Icon来专门显示字体图标，上面的例子也可以用如下方式实现：
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.accessible, color: Colors.green),
                  Icon(Icons.error, color: Colors.red),
                  Icon(Icons.fingerprint, color: Colors.green),
                ],
              ),
              Switch(
                value: _switchSelected, //当前状态
                onChanged: (value) {
                  //重新构建页面
                  setState(() {
                    _switchSelected = value;
                  });
                },
              ),
              Checkbox(
                // 三态
                tristate: true,
                value: _checkboxSelected,
                activeColor: Colors.red, //选中时的颜色
                onChanged: (value) {
                  setState(() {
                    _checkboxSelected = value;
                  });
                },
              ),
              TextField(
                autofocus: true,
                focusNode: _nameFocusNode,
                decoration: const InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  prefixIcon: Icon(Icons.person),
                  // 未获得焦点下划线设为灰色
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  //获得焦点下划线设为蓝色
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                controller: _unameController,
                onEditingComplete: () {
                  log("onEditingComplete", name: TAG);
                },
                onSubmitted: (value) {
                  log("onSubmitted", name: TAG);
                  _focusScopeNode.requestFocus(_pwdFocusNode);
                },
              ),
              TextField(
                focusNode: _pwdFocusNode,
                decoration: const InputDecoration(
                    labelText: "密码",
                    hintText: "您的登录密码",
                    prefixIcon: Icon(Icons.lock)),
                obscureText: true,
              ),
              Form(
                key: _formKey, //设置globalKey，用于后面获取FormState
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: "用户名",
                        hintText: "用户名或邮箱",
                        icon: Icon(Icons.person),
                      ),
                      // 校验用户名
                      validator: (v) {
                        return v!.trim().isNotEmpty ? null : "用户名不能为空";
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "密码",
                        hintText: "您的登录密码",
                        icon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                      //校验密码
                      validator: (v) {
                        return v!.trim().length > 5 ? null : "密码不能少于6位";
                      },
                    ),
                    // 登录按钮
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text("登录"),
                              ),
                              onPressed: () {
                                // 通过_formKey.currentState 获取FormState后，
                                // 调用validate()方法校验用户名密码是否合法，校验
                                // 通过后再提交数据。
                                if ((_formKey.currentState as FormState)
                                    .validate()) {
                                  //验证通过提交数据
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SpinKitCubeGrid(color: Colors.blue),
            ],
          )),
        ));
  }
}
