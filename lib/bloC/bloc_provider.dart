import 'package:flutter/material.dart';
import 'bloc.dart';

class BlocProvider<T extends Bloc> extends InheritedWidget {
  const BlocProvider({
    Key key,
    this.bloc,
    @required this.child,
  }) : super(key: key);

  final Widget child;
  final T bloc;

  bool updateShouldNotify(_) => true;

  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T> provider = context.dependOnInheritedWidgetOfExactType<BlocProvider<T>>();
    return provider.bloc;
  }
}
