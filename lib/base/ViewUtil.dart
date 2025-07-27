import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/SingleLineFittedBox.dart';

class ViewUtil {
  static Widget createPageView(
      BuildContext context, String? title, Widget? contentView) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(title ?? ""),),
      ),
      body: Container(
        color: Colors.green[100],
        child: contentView,
      ),
    );
  }
}
