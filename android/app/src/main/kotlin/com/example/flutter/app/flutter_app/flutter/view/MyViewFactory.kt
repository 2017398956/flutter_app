package com.example.flutter.app.flutter_app.flutter.view

import android.content.Context
import io.flutter.Log
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory


class MyViewFactory(createArgsCodec: MessageCodec<Any>?) : PlatformViewFactory(createArgsCodec) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as Map<String, Any>
        Log.d(TAG, "params:$params and createArgsCodec:$createArgsCodec")
        return AndroidTextView(context, createArgsCodec, viewId, params)
    }

    companion object {
        const val TAG = "MyViewFactory"
    }
}