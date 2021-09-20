import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './login/login_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark),
        child: MaterialApp(
          themeMode: ThemeMode.dark,
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.purple,
          ),
          home: App(),
        ));
  }
}
