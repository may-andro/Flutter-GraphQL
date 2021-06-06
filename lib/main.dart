import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_graphql/presentation/application.dart';

import 'di/locator.dart';

void main() => run();

Future run() async {
	WidgetsFlutterBinding.ensureInitialized();

	initialiseDI();

	SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

	SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
		runApp(Application());
	});
}
