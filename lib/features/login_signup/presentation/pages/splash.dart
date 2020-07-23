
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image:DecorationImage(
            image:AssetImage('assets/coffee_splash.png'),
            fit:BoxFit.cover,
          ),
        ),
    )
    );
  }
}