import 'package:flutter/material.dart';

import 'feature/search_character/page/SearchCharacterPage.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Issues',
      theme: ThemeData(
	      primaryColor: Colors.blueGrey,
	      primaryColorDark: Colors.blueGrey[700],
	      primaryColorLight: Colors.blueGrey[300],
	      accentColor: Colors.deepOrange[700],
	      backgroundColor: Colors.white,
      ),
      home: Scaffold(
        body: SearchCharacterPage(),
      ),
    );
  }
}
