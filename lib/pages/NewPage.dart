import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/Person.dart';

class NewPage extends StatelessWidget {

  NewPage({super.key});

  Person? person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: const Text("data")),
      body: Center(
        child: PopScope(
          canPop: false,
          onPopInvoked: (pop) {
            print('will pop : $pop');
          },
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, 'pop from NewPage.');
            },
            // style: const ButtonStyle(backgroundColor:),
            child: const Text("返回上一页"),
          ),
        ),
      ),
    );
  }
}
