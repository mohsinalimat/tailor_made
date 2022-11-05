import 'dart:async' show Future;

import 'package:flutter/foundation.dart';
import 'package:rebloc/rebloc.dart';
import 'package:tailor_made/rebloc/app_state.dart';

class LoggerBloc extends SimpleBloc<AppState> {
  LoggerBloc(this.isTesting);

  final bool isTesting;

  @override
  Future<Action> afterware(DispatchFunction dispatcher, AppState state, Action action) async {
    if (!isTesting) {
      debugPrint(state.toString());
    }
    return action;
  }

  @override
  Future<Action> middleware(DispatchFunction dispatcher, AppState state, Action action) async {
    debugPrint('[ReBLoC]: ${action.runtimeType}');

    return action;
  }
}
