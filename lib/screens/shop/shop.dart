import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants.dart';
import '../../firebase.dart';
import '../home/home.dart';

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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
        title: const Text('Shop'),
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
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0,bottom: 5),
              child: Center(
                child: Text(
                    "Extra Lives!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.black87),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Center(
                child: Text(
                    "Wrong answer? Continue playing with an extra life.",
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontSize: 16.0)
                ),
              ),
            ),
            Divider(thickness: 1.5),
            Expanded(
              child: Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("shop").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(!snapshot.hasData)
                    {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      children: snapshot.data!.docs.map((document){
                        return Padding(
                          padding: const EdgeInsets.all(14),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                              gradient: LinearGradient(
                                colors: [kShopListColor, kShopListColor],
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Center(
                                child: ListTile(
                                  onTap: ((){
                                    int? val = int.tryParse(document['coinforlives']);
                                    int? val2 = int.tryParse(document['lives']);
                                    if(coin>=val!)
                                      {
                                        coin = coin-val;
                                        lives = lives+val2!;
                                        usercollection(coin);
                                        extraLives(lives);
                                        Get.offAll(Home());

                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text('Successfully purchased $val2'),
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                      }
                                    else
                                      {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text('Not enough coin'),
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                      }
                                  }),
                                  leading: new IconButton(
                                    onPressed: () {

                                      int? val = int.tryParse(document['coinforlives']);
                                      int? val2 = int.tryParse(document['lives']);
                                      if(coin>=val!)
                                      {
                                        coin = coin-val;
                                        lives = lives+val2!;
                                        usercollection(coin);
                                        extraLives(lives);
                                        Get.offAll(Home());

                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text('Successfully purchased $val2'),
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                      }
                                      else
                                      {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text('Not enough coin'),
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                      }

                                    },
                                    icon: Image.asset(
                                      'assets/images/love.png',
                                    ),
                                  ),
                                  title: Text(document['lives'],style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0, color: Colors.white)),
                                  trailing: Container(
                                      width: 100,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey, width: 1),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        gradient: LinearGradient(
                                          colors: [Colors.yellow, Colors.white],
                                          begin: Alignment.bottomRight,
                                          end: Alignment.topLeft,
                                        ),
                                      ),
                                      child: Center(
                                          child: new Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  int? val = int.tryParse(document['coinforlives']);
                                                  int? val2 = int.tryParse(document['lives']);
                                                  if(coin>=val!)
                                                  {
                                                    coin = coin-val;
                                                    lives = lives+val2!;
                                                    usercollection(coin);
                                                    extraLives(lives);
                                                    Get.offAll(Home());

                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                      content: Text('Successfully purchased $val2'),
                                                      behavior: SnackBarBehavior.floating,
                                                    ));
                                                  }
                                                  else
                                                  {
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                      content: Text('Not enough coin'),
                                                      behavior: SnackBarBehavior.floating,
                                                    ));
                                                  }
                                                },
                                                icon: Image.asset(
                                                  'assets/images/coinn.png',
                                                ),
                                              ),
                                              Text(
                                                  (document['coinforlives']),
                                                  style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
                                              ),
                                            ],
                                          )
                                      ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}