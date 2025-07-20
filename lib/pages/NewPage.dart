import 'package:flutter/material.dart';
import 'package:flutter_app/models/Person.dart';
import 'package:fluttertoast/fluttertoast.dart';

@immutable
class NewPage extends StatefulWidget {
  final Person? person;

  const NewPage({super.key, this.person});

  @override
  State<StatefulWidget> createState() {
    return _NewPageState();
  }
}

class _NewPageState extends State<NewPage>
    with SingleTickerProviderStateMixin<NewPage> {
  late AnimationController _animController;
  late CurvedAnimation _opacityAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 4000));
    _opacityAnim =
        CurvedAnimation(parent: _animController, curve: Curves.linear)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animController.forward();
            }
          });
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _MyWidget(
      animation: _opacityAnim,
    );
  }
}

class _MyWidget extends AnimatedWidget {
  final Animation<double> animation;

  final Tween<double> _opacityTween = Tween(begin: 0.0, end: 1.0);

  late final Animation<double> _heightTweenAnim;

  _MyWidget({required this.animation}) : super(listenable: animation) {
    _heightTweenAnim = Tween(begin: 1.0, end: 5.0).animate(animation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: const [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            )
          ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("data")),
      body: Center(
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (pop, resultData) {
            if (!pop) {
              Fluttertoast.showToast(
                  msg: "返回按钮被拦截",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, 'pop from NewPage.');
            },
            // style: const ButtonStyle(backgroundColor:),
            child: Opacity(
              opacity: _opacityTween.evaluate(animation),
              child: Text("返回上一页",
                  style: TextStyle(
                      color: Colors.amber, height: _heightTweenAnim.value)),
            ),
          ),
        ),
      ),
    );
  }
}
