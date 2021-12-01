import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_tracker/Component/rounded_button.dart';
import 'package:movie_tracker/Screen/register_screen.dart';
import 'package:movie_tracker/constant.dart';

import 'homepage_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String email, password;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo Widget
            // Hero(
            //   tag: 'logo',
            //   child: Container(
            //     child: Image.asset('images/logo.png'),
            //     height: 50.0,
            //   ),
            // ),
            // App name widget
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Binge Tracker',
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                  speed: Duration(milliseconds: 200),
                ),
              ],
              totalRepeatCount: 1,
              displayFullTextOnTap: true,
            ),
            SizedBox(
              height: 48.0,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Email', hintText: 'Enter your email'),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Password', hintText: 'Enter your password'),
            ),
            SizedBox(
              height: 30.0,
            ),
            RoundedButton(
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.pushNamed(context, HomepageScreen.id);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                } catch (e) {
                  print(e);
                }
              },
              colour: Colors.blueAccent,
              title: 'Log In',
            ),
            TextButton(
              child: Text(
                'New User? Register',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, RegisterScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
