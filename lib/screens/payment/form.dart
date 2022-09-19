import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quiznp/constants.dart';

import '../../firebase.dart';
import '../home/home.dart';

class FormFillup extends StatelessWidget {

  TextEditingController nameController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Name :",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black87),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'according to the NID',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Location :",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black87),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: locationController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'according to the NID',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Payment address :",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black87),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: addressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'paypal/bitcoin wallet address',
              ),
            ),
          ),

          Spacer(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if(nameController.text.toString().isNotEmpty&&locationController.text.toString().isNotEmpty&&addressController.text.toString().isNotEmpty)
                {
                  String? uid = FirebaseAuth.instance.currentUser?.uid.toString();
                  DocumentReference question = FirebaseFirestore.instance.collection('paymentrequests').doc(uid);
                  question.set(
                      {
                        "name": nameController.text.toString(),
                        "location": locationController.text.toString(),
                        "wallet": addressController.text.toString(),
                        "money": money,
                      }).then((value){
                    //print(value.id);
                  });
                  nameController.clear();
                  locationController.clear();
                  addressController.clear();

                  money = 0;
                  dollars(money);
                  Get.offAll(Home());

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Wait for 3 Business days'),
                    behavior: SnackBarBehavior.floating,
                  ));
                }
                //DocumentReference question = FirebaseFirestore.instance.collection('question').doc('1');
              },
              child: Center(child: Text('Save')),
              style: ElevatedButton.styleFrom(
                  primary: Colors.black87,
                  onPrimary: Colors.white,
                  shape: StadiumBorder()
              ),
            ),
          ),
          Spacer()
        ],
      )
    );
  }
}
