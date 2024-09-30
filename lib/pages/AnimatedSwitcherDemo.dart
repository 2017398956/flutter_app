import 'package:flutter/material.dart';

class AnimatedSwitcherDemo extends StatefulWidget {
  const AnimatedSwitcherDemo({super.key});

  @override
  State createState() => _AnimatedSwitcherState();
}

class _AnimatedSwitcherState extends State<AnimatedSwitcherDemo>
    with SingleTickerProviderStateMixin {
  IconData _actionIcon = Icons.favorite_border;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('点击中间的❤️'),
        actions: const <Widget>[],
      ),
      body: Center(
        child: AnimatedSwitcher(
          transitionBuilder: (child, anim) {
            return ScaleTransition(scale: anim, child: child);
          },
          duration: const Duration(milliseconds: 350),
          child: IconButton(
            iconSize: 100,
            key: ValueKey(_actionIcon),
            icon: Icon(
              _actionIcon,
              color: Colors.pink,
            ),
            onPressed: () {
              setState(
                () {
                  if (_actionIcon == Icons.favorite_border) {
                    _actionIcon = Icons.favorite;
                  } else {
                    _actionIcon = Icons.favorite_border;
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
