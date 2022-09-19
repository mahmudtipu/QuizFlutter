import 'package:flutter/material.dart';
import 'package:quiznp/screens/home/npchallenge/components/body.dart';

class ChalengeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color(0xFFFEAC5E),
                    Color(0xFFC779D0),
                    Color(0xFF4BC0C8),
                  ]
              )
          ),
          child: Body()
      ),
    );
  }
}