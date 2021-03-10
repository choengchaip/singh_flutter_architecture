import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/repositories/widget_repository.dart';

class BaseWidget extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final BaseWidgetRepository widgetRepository;
  final Widget Function(Context) component;

  BaseWidget({
    @required this.context,
    @required this.config,
    @required this.widgetRepository,
    @required this.component,
  });

  @override
  State<BaseWidget> createState() {
    return BaseWidgetState();
  }
}

class BaseWidgetState extends State<BaseWidget> {
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
