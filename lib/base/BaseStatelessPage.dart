import 'package:flutter/material.dart';

class BaseStatelessPage extends StatelessWidget {
  const BaseStatelessPage({super.key, this.title, this.contentView});

  final String? title;
  final Widget? contentView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title != null ? title! : ""),
      ),
      body: contentView,
    );
  }
}
