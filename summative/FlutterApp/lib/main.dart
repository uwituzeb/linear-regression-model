import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primaryColor: Colors.pink,
        fontFamily: 'Outfit',
      ),
      initialRoute: '/welcome',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/welcome': (context) => const WelcomeScreen()
      }
      
    );
  }
}



