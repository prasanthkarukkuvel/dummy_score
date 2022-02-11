import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    if (!kReleaseMode) {
      // ignore: avoid_print
      print(error);
    }

    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);

    if (!kReleaseMode) {
      // ignore: avoid_print
      print(transition);
    }
  }
}
