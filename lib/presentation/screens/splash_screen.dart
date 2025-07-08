import 'package:flutter/material.dart';
import 'package:tractian/core/constants/route_names.dart';
import 'package:tractian/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Constants.splashDelay);
    if (mounted) {
      Navigator.pushReplacementNamed(context, RoutesPage.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/tractian_logo.png',
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
