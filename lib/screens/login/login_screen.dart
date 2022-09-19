import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:quiznp/screens/home/home.dart';
import 'package:quiznp/screens/login/provider/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var loading = false;
  void facebookLogin() async{
    setState(() {
      loading = true;
    });

    try{
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential = FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } on Exception catch (e){
      print(e);

      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text('Log in with facebook failed'),
        content:  Text('An error is occuring, try google login'),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('OK'))
        ],
      ));
    }
    finally{
      setState(() {
        loading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if(snapshot.hasData) {
            return Home();
          }
          else {
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/icon.png',
                          scale: 2.3,
                        ),
                      ),
                    ),
                    SizedBox(height: 100,),
                    Column(
                      children: <Widget>[
                        Center(child: Text("Sign in", style: TextStyle(color: Colors.white, fontSize: 35,fontWeight: FontWeight.bold),)),
                        SizedBox(height: 40,),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0,right: 30),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blue
                            ),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(50.0),
                                ),
                                primary: Colors.blue
                              ),
                              onPressed: () {
                                facebookLogin();
                              },
                              icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white,),
                              label: Text('continue with facebook'),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Center(child: Text("or", style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 20,fontStyle: FontStyle.italic),)),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0,right: 30),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black
                            ),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(50.0),
                                ),
                                primary: Colors.white,
                                onPrimary: Colors.black,
                              ),
                              onPressed: () {
                                final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                                provider.googleLogin();
                              },
                              icon: FaIcon(FontAwesomeIcons.google, color: Colors.blueAccent,),
                              label: Text('continue with Google'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
