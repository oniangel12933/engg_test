// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';

final log = Logger("AppBlocObserver");

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    //print(event);
    log.info(event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    //print(error);
    log.info(error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    //print(change);
    log.info(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    //print(transition);
    log.info(transition);
  }
}
