import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/widgets/banners/banner_head_line.dart';

class ProductPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  ProductPage({
    required this.context,
    required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return ProductPageState();
  }
}

class ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          BannerHeadLine(
            context: widget.context,
            config: widget.config,
          ),
          Container(

          ),
        ],
      ),
    );
  }
}
