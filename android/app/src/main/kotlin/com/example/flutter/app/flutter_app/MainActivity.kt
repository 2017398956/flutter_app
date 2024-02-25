package com.example.flutter.app.flutter_app

import com.example.flutter.app.flutter_app.flutter.BatteryChannel
import com.example.flutter.app.flutter_app.flutter.view.MyViewFactory
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.StandardMessageCodec

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        BatteryChannel(flutterEngine.dartExecutor.binaryMessenger, context) // 实例化通道
        flutterEngine.platformViewsController.registry.registerViewFactory(
            "nflAndroidTextView",
            MyViewFactory(StandardMessageCodec())
        ).let {
            Log.d("MainActivity", "registerViewFactory result:$it")
        }
    }
}
