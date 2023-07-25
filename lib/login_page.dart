import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testapp2/components/bacbutt.dart';
import 'package:testapp2/components/mybutt.dart';
import 'package:testapp2/components/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testapp2/forgotpassword.dart';
import 'package:testapp2/home.dart';
import 'package:testapp2/homeadmin.dart';

class LoginPage extends StatefulWidget {
  //final Function()? onTap;
  const LoginPage({
    super.key,
  });
  //required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  void back() {}

  // late DocumentReference _reference;
  // late Future<DocumentSnapshot> _futureData;
  // late Map data;

  // void route(String username) {
  //   _reference = FirebaseFirestore.instance
  //       .collection('User')
  //       .doc(usernameController.text);
  //   _futureData = _reference.get();

  // }

  Future useSignin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      // route(usernameController.text);
      if (context.mounted) {
        if (usernameController.text == 'faisalsbs123@gmail.com') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Homeadmin()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('print me');
        errorMessage();
      } else if (e.code == 'wrong-password') {
        debugPrint('print me');
        errorMessage();
      }
    }
  }

  // wrong email message popup
  void errorMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Email or Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 231, 116, 1),
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
                    child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),

            //logo

            Image.asset(
              'lib/images/logo.png',
              height: 150,
            ),

            const SizedBox(
              height: 10,
            ),

            //welcome text
            const Text(
              'Welcome Back! We missed you',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),

            const SizedBox(
              height: 20,
            ),

            mytextfield(
              controller: usernameController,
              hintText: 'Email',
              obscureText: false,
            ),

            const SizedBox(
              height: 10,
            ),

            mytextfield(
              controller: passwordController,
              hintText: 'password',
              obscureText: true,
            ),

            const SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => forgotpass()));
                  },
                  child: Text(
                    'Forgot password',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ]),
            ),

            const SizedBox(
              height: 10,
            ),

            Mybutt(
              onTap: useSignin,
              text: 'Sign In',
            ),

            const SizedBox(
              height: 30,
            ),

            bacbutt(onTap: back),

            const SizedBox(
              height: 30,
            ),

            // Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 25),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           'not a member?',
            //           style: TextStyle(color: Colors.grey[200]),
            //         ),
            //         const SizedBox(
            //           width: 4,
            //         ),
            //         // GestureDetector(
            //         //   onTap: widget.onTap,
            //         //   child: const Text(
            //         //     'Register now',
            //         //     style: TextStyle(
            //         //         color: Colors.cyan, fontWeight: FontWeight.bold),
            //         //   ),
            //         // )
            //       ],
            //     ))
          ],
        )))));
  }
}
