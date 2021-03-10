import 'package:singh_architecture/repositories/base_repository.dart';
import 'package:singh_architecture/repositories/types.dart';

abstract class IContext {
  IRepositories repositories();
}

class Context implements IContext {
  IRepositories _repositories;

  @override
  IRepositories repositories() {
    if (this._repositories == null) {
      this._repositories = NewRepository();
    }
    return this._repositories;
  }
}
