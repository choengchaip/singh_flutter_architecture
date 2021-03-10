import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';

class BaseComponent extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final Widget Function(Context) component;

  BaseComponent({
    @required this.context,
    @required this.config,
    @required this.component,
  });

  @override
  State<BaseComponent> createState() {
    return BaseComponentState();
  }
}

class BaseComponentState extends State<BaseComponent> {
  @override
  void initState() {
    super.initState();
    // Do your thing before start app
  }

  @override
  Widget build(BuildContext _) {
    return widget.component(widget.context);
  }
}
