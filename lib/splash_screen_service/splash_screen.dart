import 'dart:async';

import 'package:covid_app/screen/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.repeat();

    Timer(
      const Duration(seconds: 4),
      () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.of(context).size.height;
    final wt = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: RotationTransition(
              turns: controller,
              child: Image.asset(
                'assets/virus.png',
                width: ht * 0.30,
                height: ht * 0.30,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            'Covid-19\nTracker App',
            style: TextStyle(
                fontSize: wt * 0.07,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
