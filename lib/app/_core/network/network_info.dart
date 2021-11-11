import 'package:connectivity_plus/connectivity_plus.dart';

abstract class INetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfo implements INetworkInfo {
  final Connectivity connectivity;

  NetworkInfo(this.connectivity);

  @override
  Future<bool> isConnected() async {
    final result = await connectivity.checkConnectivity();

    if (result == ConnectivityResult.none) {
      return false;
    }

    return true;
  }
}
