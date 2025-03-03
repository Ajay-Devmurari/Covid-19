
import 'package:covid_app/splash_screen_service/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DevicePreview(
    builder: (context) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.blueGrey[900],
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.blueGrey[900],
            )),
        home: const SplashScreen());
  }
}
