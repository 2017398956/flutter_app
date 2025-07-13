import 'package:flutter/material.dart';

class ViewUtil {
  static Widget createPageView(
      BuildContext context, String? title, Widget? contentView) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title ?? ""),
      ),
      body: Container(
        color: Colors.green[100],
        child: contentView,
      ),
    );
  }
}
