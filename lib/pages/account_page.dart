import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/widgets/common/loading_stack.dart';
import 'package:singh_architecture/widgets/common/top_bar.dart';

class AccountPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  AccountPage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return AccountPageState();
  }
}

class AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingStack(
        isLoadingSCs: [],
        children: () => [
          TopBar(
            title: "Notification",
          ),
        ],
      ),
    );
  }
}
