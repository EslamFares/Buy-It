
import 'package:flutter/material.dart';

class MyPopMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;
  MyPopMenuItem({@required this.onClick, @required this.child})
      : super(child: child);

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopMenuItemState();
  }
}

class MyPopMenuItemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, MyPopMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}
