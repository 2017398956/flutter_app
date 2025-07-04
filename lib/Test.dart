import 'dart:async';
import 'dart:developer';
import 'dart:io';

// void main() {
//   log("Dart Test");
// }

void testDart() {
  // testFuture();
  // testStream();
}

void testFuture() {
  Future.delayed(const Duration(seconds: 2), () {
    // return "hi world!";
    throw AssertionError("Error");
  }).then((data) {
    // log(data);
  }, onError: (error) {
    error("This is onError");
  }).catchError((error) {
    // error("This is catchError");
    // error(error.toString());
  }).whenComplete(() {
    log("Test Future complete.");
  });
  ///////////////////////////////////////////////
  Future.wait([
    // 2秒后返回结果
    Future.delayed(const Duration(seconds: 2), () {
      return "hello";
    }),
    // 4秒后返回结果
    Future.delayed(const Duration(seconds: 4), () {
      return " world";
    })
  ]).then((results) {
    log(results[0] + results[1]);
  }).catchError((e) {
    log(e);
  });
  ////////////////////////////////////////////////
  loginAndSaveData();
  log("loginAndSaveData");
}

void loginAndSaveData() async {
  var id = await login("userName", "pwd");
  var userInfo = await getUserInfo(id);
  await saveUserInfo(userInfo);
}

//先分别定义各个异步任务
login(String userName, String pwd) async {
  log("login:$userName,pwd:$pwd");
  sleep(const Duration(seconds: 2));
  return "123456";
  //用户登录
}

getUserInfo(String id) async {
  log("userId:$id");
  sleep(const Duration(seconds: 2));
  return "user_info";
  //获取用户信息
}

saveUserInfo(String userInfo) async {
  log("userInfo:$userInfo");
  sleep(const Duration(seconds: 2));
  return "save_complete";
  // 保存用户信息
}

void testStream() {
  Stream.fromFutures([
    // 1秒后返回结果
    Future.delayed(const Duration(seconds: 3), () {
      return "hello 1";
    }),
    // 抛出一个异常
    Future.delayed(const Duration(seconds: 2), () {
      throw AssertionError("Error");
    }),
    // 3秒后返回结果
    Future.delayed(const Duration(seconds: 1), () {
      return "hello 3";
    })
  ]).listen((data) {
    log(data);
  }, onError: (e) {
    log(e.message);
  }, onDone: () {
    log("Stream Done");
  });
}
