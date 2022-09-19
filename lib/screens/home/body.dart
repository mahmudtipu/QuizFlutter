import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiznp/constants.dart';
import 'package:quiznp/screens/home/dailyplay/dailyplay.dart';
import 'package:quiznp/screens/home/npchallenge/npchallenge.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  TextEditingController timeinput = TextEditingController();

  @override
  void initState(){
    timeinput.text = "";
    fetch();
    dollars();
    fetchlives();
    fetchTexts();
    fetchThre();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: .5),
                      borderRadius: BorderRadius.circular(50),
                      shape: BoxShape.rectangle,
                      //borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.payment,color: Colors.orange,),
                          ),
                          Text(
                            '\$$money',
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
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: .5),
                      borderRadius: BorderRadius.circular(50),
                      shape: BoxShape.rectangle,
                      //borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/images/coinn.png',
                            ),
                          ),
                          Text(
                            '$coin',
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
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Daily Play',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 30.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(DailyPlayScreen());
                  },
                  child: Text('Continue'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      shape: StadiumBorder()
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: InkWell(
                  onTap: () {
                    TimeOfDay? pickedTime =  TimeOfDay.now();
                    timeinput.text = pickedTime.format(context);

                    if(timeinput.text.toString()==time)
                      {
                        Get.to(ChalengeScreen());
                      }
                    else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Wait for "+time),
                          behavior: SnackBarBehavior.floating,
                        ));
                      }
                    //Get.to(ChalengeScreen())
                  },
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Card(
                      color: Colors.blueGrey,
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/images/love.png',
                                  ),
                                ),
                                Text('$lives',style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0, color: Colors.white)),
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              np,
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              desc,
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            color: Colors.black54,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Share'),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        onPrimary: Colors.black,
                                        shape: StadiumBorder()
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    time + " : GMT+6",
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '\$$prize',
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
  Future<void> fetch() async {
    int a=0;
    final User user = await FirebaseAuth.instance.currentUser!;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('coin')
          .doc(user.uid)
          .get()
          .then((ds) {
        a = ds.data()!['coin'];
      }).catchError((e) {
        print(e);
      });
    }
    setState(() {
      coin = a;
    });
  }

  Future<void> dollars() async {
    int a=0;
    final User user = await FirebaseAuth.instance.currentUser!;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('dollars')
          .doc(user.uid)
          .get()
          .then((ds) {
        a = ds.data()!['dollars'];
      }).catchError((e) {
        print(e);
      });
    }
    setState(() {
      money = a;
    });
  }

  Future<void> fetchlives() async {
    int a=0;
    final User user = await FirebaseAuth.instance.currentUser!;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('lives')
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot ds) {
        a = ds.data()!['lives'];
      }).catchError((e) {
        print(e);
      });
    }
    setState(() {
      lives = a;
    });
  }

  Future<void> fetchTexts() async {
    String a ='';
    String b ='';
    int c = 0;
    String d ='';
    await FirebaseFirestore.instance.collection("texts").get().then(
          (QuerySnapshot snapshot) =>
          snapshot.docs.forEach((f) {
            a= f.data()['title'];
            b= f.data()['desc'];
            c= f.data()['prize'];
            d= f.data()['time'];
          }),
    );
    setState(() {
      np = a;
      desc = b;
      prize = c;
      time = d;
    });
  }

  Future<void> fetchThre() async {
    int c = 0;
    await FirebaseFirestore.instance.collection("payment").get().then(
          (QuerySnapshot snapshot) =>
          snapshot.docs.forEach((f) {
            c= f.data()['threshold'];
          }),
    );
    setState(() {
      thre = c;
    });
  }


}