import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return AnimatedSplashScreen(
        splash: Column(
          children: [
            Image.asset('assets/logoicon.jpg', width: 150, height: 150),
            const SizedBox(height: 10),
            const Text('Guess The Emoji', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(249, 195, 9, 1.0))),
            Lottie.asset('assets/Animation2.json', width: 61, height: 61)
          ],
        ),
        splashIconSize: 250,
        backgroundColor: Colors.black,
        duration: 4000,
        nextScreen: const Home());
  }
}
