import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:testapp2/components/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testapp2/login_or_register.dart';

import 'login_page.dart';

// ignore: camel_case_types
class forgotpass extends StatefulWidget {
  forgotpass({super.key});

  @override
  State<forgotpass> createState() => _forgotpassState();
}

class _forgotpassState extends State<forgotpass> {
  final passrequest = TextEditingController();

  @override
  void dispose() {
    passrequest.dispose();
    super.dispose();
  }

  Future golog() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: passrequest.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content:
                  Text('Password reset link has been sent, check your email.'),
            );
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 116, 1),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: const Text(
                'Enter your email here and we will send a password reset link',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            mytextfield(
              controller: passrequest,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(
              height: 50,
            ),
            MaterialButton(
              onPressed: golog,
              child: Text('reset password'),
              color: Color.fromARGB(255, 252, 165, 34),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Back'),
              color: Color.fromARGB(255, 252, 165, 34),
            )
          ],
        ),
      )),
    );
  }
}
