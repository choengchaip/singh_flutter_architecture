import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/widgets/base_widget.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/repositories/page_repository.dart';

class BasePage extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final BasePageRepository pageRepository;
  final List<BaseWidget> widgets;

  BasePage({
    @required this.context,
    @required this.config,
    @required this.pageRepository,
    @required this.widgets,
  });

  @override
  State<BasePage> createState() {
    return BasePageState();
  }
}

class BasePageState extends State<BasePage> {
  @override
  void initState() {
    super.initState();
    // Do your thing before start app
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
