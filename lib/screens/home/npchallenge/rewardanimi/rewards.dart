import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:quiznp/firebase.dart';
import 'package:quiznp/screens/home/npchallenge/controller/question_controller.dart';
import 'package:quiznp/screens/home/home.dart';

import '../../../../constants.dart';

class RewardScreen extends StatefulWidget {

  @override
  _RewardScreenState createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {

  @override
  Widget build(BuildContext context) {

    NPQuestionController _questionController = Get.put(NPQuestionController());
    money = money+c;

    dollars(money);
    c=0;

    Future.delayed(Duration(seconds: 2), () {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Reward collected successfully'),
        behavior: SnackBarBehavior.floating,
      ));

      Get.offAll(Home());
    });

    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Expanded(
            child: Container(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/gifs/tea.gif', scale: 1.5),
                  Text(
                    "Coins has been collected..",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
