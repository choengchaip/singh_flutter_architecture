import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/repositories/page_repository.dart';

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

  @override
  void initState() {
    super.initState();

    this.myContext = Context();
    this.config = Config();

    widget.launchScreenRepository.toLoadingStatus();
    this.initialConfig();
  }

  Future<void> initialConfig() async {
    try {
      await this.config.initial();
      sleep(Duration(seconds: 3));
      widget.launchScreenRepository.toLoadedStatus();
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
