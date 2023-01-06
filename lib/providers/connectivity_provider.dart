import 'dart:async';
import 'package:agriclaim/ui/constants/enums.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkDetectorNotifier extends StateNotifier<NetworkStatus> {
  StreamController<ConnectivityResult> controller =
      StreamController<ConnectivityResult>();

  NetworkDetectorNotifier() : super(NetworkStatus.notDetermined) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.mobile:
          state = NetworkStatus.on;
          break;
        case ConnectivityResult.wifi:
          state = NetworkStatus.on;
          break;
        case ConnectivityResult.none:
          state = NetworkStatus.off;
          break;
        case ConnectivityResult.bluetooth:
          state = NetworkStatus.off;
          break;
        case ConnectivityResult.ethernet:
          state = NetworkStatus.off;
          break;
        case ConnectivityResult.vpn:
          state = NetworkStatus.off;
          break;
      }
    });
  }
}

final networkAwareProvider =
    StateNotifierProvider<NetworkDetectorNotifier, NetworkStatus>((ref) {
  return NetworkDetectorNotifier();
});
