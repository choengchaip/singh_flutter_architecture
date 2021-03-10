import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneralMiddleWare extends StatefulWidget {
  final Widget child;

  GeneralMiddleWare({
    @required this.child,
  });

  @override
  State<StatefulWidget> createState() {
    return GeneralMiddleWareState();
  }
}

class GeneralMiddleWareState extends State<GeneralMiddleWare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
    );
  }
}
