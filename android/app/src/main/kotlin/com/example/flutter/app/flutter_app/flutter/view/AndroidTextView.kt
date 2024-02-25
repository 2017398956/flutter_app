package com.example.flutter.app.flutter_app.flutter.view

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.platform.PlatformView


class AndroidTextView(
    context: Context,
    createArgsCodec: MessageCodec<Any>?,
    viewId: Int,
    params: Map<String, Any>
) : PlatformView {

    private var myNativeView: TextView

    init {
        myNativeView = TextView(context)
        myNativeView.text = "我是来自 Android 的原生 TextView"
    }

    override fun getView(): View {
        return myNativeView
    }

    override fun dispose() {
    }
}