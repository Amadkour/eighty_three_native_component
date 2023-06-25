import 'package:flutter_bloc/flutter_bloc.dart';

class BaseController<T> extends Cubit<T> {
  late T initial;

  BaseController(super.initialState) {
    initial = state;
  }

  void stopLoading() {
  }
}
