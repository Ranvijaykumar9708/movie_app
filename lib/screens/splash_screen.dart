import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double _textOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _fadeInText();
    navigateToHome();
  }

  Future<void> _fadeInText() async {
    await Future.delayed(Duration(seconds: 2)); // Delay before starting the fade-in
    setState(() {
      _textOpacity = 1.0;
    });
  }

  Future<void> navigateToHome() async {
    await Future.delayed(Duration(seconds: 6));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/logo.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              AnimatedOpacity(
                opacity: _textOpacity,
                duration: Duration(seconds: 2), // Duration of the fade-in effect
                child: const Text(
                  "Your all choice is here",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
