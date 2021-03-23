import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:singh_architecture/configs/config.dart';
import 'package:singh_architecture/models/product_model.dart';
import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';
import 'package:singh_architecture/utils/requester.dart';
import 'package:singh_architecture/utils/time_helper.dart';

class ProductRepository extends BaseDataRepository<ProductModel> {
  final BuildContext buildCtx;
  final IConfig config;
  final IRepositoryOptions options;

  ProductRepository({
    required this.buildCtx,
    required this.config,
    required this.options,
  }) : super(buildCtx, config, options);

  @override
  List<ProductModel> transforms(tss) {
    return ProductModel.toList(tss);
  }

  @override
  ProductModel? transform(ts) {
    return ProductModel.fromJson(ts);
  }
}
