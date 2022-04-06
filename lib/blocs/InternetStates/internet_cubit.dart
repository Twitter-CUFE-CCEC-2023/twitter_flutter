import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'internet_cubit.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  late StreamSubscription connectivityStreamSubscription;
  final Connectivity connectivity;
  InternetCubit(this.connectivity) : super(InternetLoading()) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emit(InternetConnected(ConnectionType.wifi));
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emit(InternetConnected(ConnectionType.mobile));
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(InternetDisconnected());
      }
    });

    Future.delayed(const Duration(seconds: 10)).then((_){
      if(state is InternetLoading)
        {
          emit(InternetDisconnected());
        }
    });

  }

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
