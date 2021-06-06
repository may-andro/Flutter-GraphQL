import 'package:flutter/material.dart';

class BlocProvider<T extends BlocBase> extends InheritedWidget {
  final T bloc;

  const BlocProvider({
    required this.bloc,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(_) => true;

  static T of<T extends BlocBase>(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<BlocProvider<T>>())!.bloc;
  }
}

abstract class BlocBase {
  void dispose();
}
