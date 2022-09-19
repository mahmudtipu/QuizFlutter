import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quiznp/constants.dart';
import 'package:quiznp/screens/payment/form.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int moneycount =0;

    if(money>=100)
      {
        moneycount = 100;
      }
    else
      {
        moneycount = money;
      }

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueGrey, Colors.blueGrey],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        title: const Text('Payment'),
      ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10),
              child: Text(
                "Your earning : \$$money",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black87),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child:  LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2000,
                percent: moneycount/100,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 10),
              child: Text(
                "Minimum threshold : \$$thre",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black87),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child:  LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2000,
                percent: 1,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ),
            Spacer(),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 60.0, right: 60, bottom: 10),
                  child: Text(
                    "Please fill up this form for making withdrawal request",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if(money>=thre)
                        {
                          Get.to(FormFillup());
                        }
                      else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Not enough balance'),
                            behavior: SnackBarBehavior.floating,
                          ));
                        }
                    },
                    child: Text('Form Fillup'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black87,
                        onPrimary: Colors.white,
                        shape: StadiumBorder()
                    ),
                  ),
                )
              ],
            ),
            Spacer(),
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Payment through",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.black87),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    children: [
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/btc.png',
                          scale: 8,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/paypal.png',
                          scale: 8,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}