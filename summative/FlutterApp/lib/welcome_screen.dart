import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'PayPredict',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'images/img.jpg',
                width: 250,
                height: 250,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              const Text(
                'Know Your Worth,\nClaim Your Value!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome to PayPredict, where our aim is to promote pay transparency and equity',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Start predicting',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
