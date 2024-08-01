import 'package:flutter/cupertino.dart';

enum Type {
  rightToLeft,
  leftToRight,
}

class CustomPageRoute extends PageRouteBuilder {

  final Widget child;
  final Type type;

  CustomPageRoute({required this.child, required this.type}) : super(opaque: false,transitionDuration: const Duration(milliseconds: 500),pageBuilder : (context, animation, secondaryAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {

    Offset begin;
    if (type == Type.rightToLeft) {
      begin = const Offset(1, 0);
    } else {
      begin = const Offset(-1, 0);
    }

    return SlideTransition(
      position: Tween<Offset>(
          begin: begin,
          end: Offset.zero
      ).animate(animation),
      child: child,
    );
  }
}