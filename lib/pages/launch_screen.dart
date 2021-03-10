import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/middlewares/GeneralMiddleWare.dart';
import 'package:singh_architecture/pages/product_page.dart';
import 'package:singh_architecture/repositories/page_repository.dart';
import 'package:singh_architecture/repositories/product_repository.dart';

class LaunchScreen extends StatefulWidget {
  final BasePageRepository launchScreenRepository;

  LaunchScreen({
    @required this.launchScreenRepository,
  });

  @override
  State<LaunchScreen> createState() {
    return LaunchScreenState();
  }
}

class LaunchScreenState extends State<LaunchScreen> {
  IContext myContext;
  IConfig config;
  ProductRepository productRepository;

  @override
  void initState() {
    super.initState();

    this.config = Config();
    this.myContext = Context(
      config: config,
    );

    widget.launchScreenRepository.toLoadingStatus();
    this.initialConfig();
  }

  Future<void> initialConfig() async {
    try {
      await this.config.initial();
      sleep(Duration(seconds: 3));
      widget.launchScreenRepository.toLoadedStatus();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => GeneralMiddleWare(
            child: ProductPage(context: this.myContext, config: this.config),
          ),
        ),
      );
    } catch (e) {
      widget.launchScreenRepository.toErrorStatus(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<bool>(
        stream: widget.launchScreenRepository.isLoadedSC.stream,
        builder: (BuildContext context, data) {
          if (!data.hasData || data?.data == false) {
            return Center(
              child: Container(
                child: Icon(Icons.favorite),
              ),
            );
          }

          return Center();
        },
      ),
    );
  }
}
