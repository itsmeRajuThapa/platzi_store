import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  late Connectivity connectivity;
  StreamSubscription? _subscription;

  InternetCubit() : super(InternetInitial()) {
    connectivity = Connectivity();
    _subscription = connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        emit(state.copyWith(status: ConnectStatus.connected));
      } else {
        emit(state.copyWith(status: ConnectStatus.unconnected));
      }
    });
  }
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
