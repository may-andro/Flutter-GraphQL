import 'dart:io';

abstract class ConnectivityManager {
  Future<bool> get isConnected;
}

class ConnectivityManagerImpl implements ConnectivityManager {

  Future<bool> _checkIsNetworkAvailable() async {
	  bool statusConnected = false;
	  try {
		  final result = await InternetAddress.lookup('google.com');
		  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
			  print('connected');
			  statusConnected = true;
		  }
	  } on SocketException catch (_) {
		  print('not connected');
	  }
	  return statusConnected;
  }

  @override
  Future<bool> get isConnected => _checkIsNetworkAvailable();
}
