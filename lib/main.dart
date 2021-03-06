import 'package:almaty_bus/api/api.dart' as api;
import 'package:almaty_bus/pages/home_page.dart';
import 'package:almaty_bus/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  await SharedPreferencesManager.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData darkTheme = ThemeData(primarySwatch: Colors.blueGrey, brightness: Brightness.dark);
  final ThemeData lightTheme = ThemeData();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      title: 'Almatybus',
      theme: darkTheme,
      home: HomePage(),
    );
  }
}
