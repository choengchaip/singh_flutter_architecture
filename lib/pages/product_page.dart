import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/repositories/product_repository.dart';

class ProductPage extends StatefulWidget {
  final IContext context;
  final IConfig config;

  ProductPage({
    @required this.context,
    @required this.config,
  });

  @override
  State<StatefulWidget> createState() {
    return PagePageState();
  }
}

class PagePageState extends State<ProductPage> {
  ProductRepository productRepository;

  @override
  void initState() {
    super.initState();

    productRepository = widget.context.repositories().productRepository(widget.config);
    productRepository.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream:
        productRepository.isLoadedSC.stream,
        builder: (context, data) {
          if (!data.hasData || data?.data == false) {
            return Container(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            child: Text(
              "Finish",
            ),
          );
        },
      ),
    );
  }
}
