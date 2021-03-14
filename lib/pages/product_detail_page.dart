import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/cores/context.dart';
import 'package:singh_architecture/repositories/product_repository.dart';
import 'package:singh_architecture/utils/object_helper.dart';

class ProductDetailPage extends StatefulWidget {
  final IContext context;
  final IConfig config;
  final String id;

  ProductDetailPage({
    required this.context,
    required this.config,
    required this.id,
  });

  @override
  State<StatefulWidget> createState() {
    return ProductDetailPageState();
  }
}

class ProductDetailPageState extends State<ProductDetailPage> {
  late ProductRepository productRepository;

  @override
  void initState() {
    super.initState();

    this.productRepository = widget.context.repositories().productRepository();
    this.productRepository.get(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: this.productRepository.isLoadingSC.stream,
      builder: (context, snapshot) {
        if (ObjectHelper.isSnapshotStateLoading(snapshot)) {
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Container();
      },
    );
  }
}
