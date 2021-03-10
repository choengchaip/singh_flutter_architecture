import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:singh_architecture/repositories/types.dart';

abstract class BaseRepository {
  bool get isLoading;

  bool get isLoaded;

  bool get isError;

  String get errorMessage;

  StreamController<bool> get isLoadingSC;

  StreamController<bool> get isLoadedSC;

  StreamController<bool> get isErrorSC;

  StreamController<String> get errorMessageSC;

  void toLoadingStatus();

  void toLoadedStatus();

  void toErrorStatus(FlutterError e);

  void dispose();
}

class NewRepository implements IRepositories {
  @override
  productRepository() {
    return null;
  }
}
