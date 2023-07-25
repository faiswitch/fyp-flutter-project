import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testapp2/firstmenu.dart';
import 'package:testapp2/home.dart';
import 'package:testapp2/homeadmin.dart';
import 'package:testapp2/login_page.dart';
import 'package:testapp2/CameraPage.dart';
import 'package:testapp2/login_or_register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in

          if (snapshot.hasData) {
            if (snapshot.data?.email == 'faisalsbs123@gmail.com') {
              return Homeadmin();
            } else {
              return Home();
            }
          }

          // user is NOT logged in
          else {
            return firstmenu();
          }
        },
      ),
    );
  }
}
