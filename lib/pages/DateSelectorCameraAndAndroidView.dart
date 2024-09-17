import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/native_view/MyTextView.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:permission_handler/permission_handler.dart';

class DateSelectorCameraAndAndroidView extends StatefulWidget {
  const DateSelectorCameraAndAndroidView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewRouteState();
  }
}

class _NewRouteState extends State<DateSelectorCameraAndAndroidView> {
  String dateString = '';
  CameraController? cameraController;
  Future<void>? initializeControllerFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("New Route"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateString,
            style: const TextStyle(fontSize: 14),
          ),
          const MyTextView(text: "我是来自 Android 的原生 TextView",),
          FilledButton(
              onPressed: () {
                Pickers.showDatePicker(context, mode: DateMode.YMDHM,
                    onConfirm: (p) {
                  log("返回数据：$p");
                  setState(() {
                    dateString =
                        "${p.year}-${p.month}-${p.day} ${p.hour}:${p.minute}";
                  });
                }, onChanged: (p) {
                  log("数据改变：$p");
                });
              },
              child: const Text("选则日期")),
          const Padding(padding: EdgeInsets.all(5)),
          FilledButton(
              onPressed: () async {
                await Permission.location.request();
                await Permission.camera.onGrantedCallback(() async {
                  var cameras = await availableCameras();
                  var firstCamera = cameras.first;
                  log("firstCamera:$firstCamera and camera size:${cameras.length}");
                  cameraController =
                      CameraController(firstCamera, ResolutionPreset.medium);
                  setState(() {
                    initializeControllerFuture = cameraController?.initialize();
                  });
                }).request();
              },
              child: const Text("打开相机")),
          FutureBuilder<void>(
            future: initializeControllerFuture,
            builder: (context, snapshot) {
              log("snapshot state:$snapshot");
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: cameraController!.value.aspectRatio,
                  child: CameraPreview(
                    cameraController!,
                    child: const Text("Hello"),
                  ),
                );
              } else {
                return const Center();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }
}
