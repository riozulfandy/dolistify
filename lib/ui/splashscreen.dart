import 'dart:async';
import 'package:dolistify/widget/bottom_nav.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BottomNav())));
    _fadeInImage();
  }

  void _fadeInImage() {
    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      setState(() {
        _opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
            Color.fromARGB(255, 163, 255, 201),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(seconds: 2),
            child: SizedBox(
              width: 300, // Set your desired width
              height: 300, // Set your desired height
              child: Image.asset('assets/images/splash.png'),
            ),
          ),
        ],
      ),
    );
  }
}
