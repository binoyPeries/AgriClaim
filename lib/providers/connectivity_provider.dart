import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum NetworkStatus { notDetermined, on, off }

class NetworkDetectorNotifier extends StateNotifier<NetworkStatus> {
  StreamController<ConnectivityResult> controller =
      StreamController<ConnectivityResult>();

  NetworkStatus newState = NetworkStatus.notDetermined;

  NetworkDetectorNotifier() : super(NetworkStatus.notDetermined) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Use Connectivity() here to gather more info if you need t
      switch (result) {
        case ConnectivityResult.mobile:
          newState = NetworkStatus.on;
          break;
        case ConnectivityResult.wifi:
          newState = NetworkStatus.on;
          break;
        case ConnectivityResult.none:
          newState = NetworkStatus.off;
          break;
        case ConnectivityResult.bluetooth:
          newState = NetworkStatus.off;
          break;
        case ConnectivityResult.ethernet:
          newState = NetworkStatus.off;
          break;
        case ConnectivityResult.vpn:
          newState = NetworkStatus.off;
          break;
      }
    });
  }
}

final networkAwareProvider = StateNotifierProvider((ref) {
  return NetworkDetectorNotifier();
});
