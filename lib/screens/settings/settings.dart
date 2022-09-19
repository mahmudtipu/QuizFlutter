import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsScreen> {

  @override
  void initState(){
    setti();
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser!;
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
        title: const Text('Settings'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [

            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.photoURL!),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(user.displayName!,style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                ),
                //Text(user.email!),
              ],
            ),
            textPrivacy(context, "Privacy policy"),
            textTerms(context, "Terms of use"),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.volume_up_outlined,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildNotificationOptionRow("Notification", true),
            SizedBox(
              height: 50,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Get.back();
                },
                child: Text("SIGN OUT",
                    style: TextStyle(
                        fontSize: 16, letterSpacing: 2.2, color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        InkWell(
          onTap: ((){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Disable from setting'),
              behavior: SnackBarBehavior.floating,
            ));
          }),
          child: Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                value: isActive,
                onChanged: (bool val) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Disable from setting'),
                    behavior: SnackBarBehavior.floating,
                  ));
                },
              )),
        )
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(user.photoURL!),
                    ),
                    Text(user.displayName!),
                    Text(user.email!),
                  ],
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector textPrivacy(BuildContext context, String title) {
    return GestureDetector(
      onTap: () async {
        var url = pri;
        if(await canLaunch(url)){
          await launch(url);
        }
        else
          {
            throw "Cannot load url";
          }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector textTerms(BuildContext context, String title) {
    return GestureDetector(
      onTap: () async {
        var url = ter;
        if(await canLaunch(url)){
          await launch(url);
        }
        else
        {
          throw "Cannot load url";
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setti() async {
    String privacy = '';
    String terms = '';
    await FirebaseFirestore.instance.collection("setting").get().then(
          (QuerySnapshot snapshot) =>
          snapshot.docs.forEach((f) {
            privacy= f.data()['privacy'];
            terms= f.data()['terms'];
          }),
    );
    setState(() {
      pri = privacy;
      ter = terms;
    });
  }
}