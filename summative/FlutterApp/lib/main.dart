import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'home.dart';
import 'prediction_result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF006D6F),
        fontFamily: 'Outfit',
      ),
      initialRoute: '/welcome',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/result': (context) => const ResultScreen(),
      }
      
    );
  }
}



