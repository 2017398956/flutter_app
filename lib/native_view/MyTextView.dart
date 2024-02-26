import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextView extends StatefulWidget {
  const MyTextView({super.key, this.textSize = 12, this.text});

  final double textSize;
  final String? text;

  @override
  State<MyTextView> createState() {
    return _MyTextViewState();
  }
}

class _MyTextViewState extends State<MyTextView> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return Container(
        color: Colors.blue,
        width: null,

        height: widget.textSize,
        child: AndroidView(
          viewType: "personal.nfl.flutter.view/AndroidTextView",
          creationParams: {"text": widget.text, "textSize": widget.textSize},
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else {
      return const Text(
          "This should be a native TextView.But it is a flutter Text.");
    }
  }
}
