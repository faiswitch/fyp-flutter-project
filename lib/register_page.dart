import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testapp2/components/bacbutt.dart';
import 'package:testapp2/components/mybutt.dart';
import 'package:testapp2/components/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testapp2/home.dart';

class registerpage extends StatefulWidget {
  //final Function()? onTap;
  const registerpage({super.key});
  //required this.onTap});

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  final usernameController = TextEditingController();
  final confirmpass = TextEditingController();
  final passwordController = TextEditingController();

  void back() {}

  postDetail(String email) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference ref = FirebaseFirestore.instance.collection('User');
    ref.doc(user.uid).set({'email': usernameController.text, 'rool': 'users'});
  }

  Future useSignup() async {
    try {
      if (passwordController != confirmpass) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: usernameController.text,
              password: passwordController.text,
            )
            .then((value) => {postDetail(usernameController.text)});
        ;
      } else {
        notsamepass();
      }

      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
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

  void notsamepass() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Password is not the same',
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
              'Register Page:',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),

            const SizedBox(
              height: 5,
            ),

            const Text(
              'Welcome, may we get your info?',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),

            const SizedBox(
              height: 25,
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

            mytextfield(
              controller: confirmpass,
              hintText: 'confirm passowrd',
              obscureText: true,
            ),

            const SizedBox(
              height: 10,
            ),

            const SizedBox(
              height: 10,
            ),

            Mybutt(
              onTap: useSignup,
              text: 'Sign Up',
            ),

            const SizedBox(
              height: 20,
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
            //           'already have an account?',
            //           style: TextStyle(color: Colors.grey[200]),
            //         ),
            //         const SizedBox(
            //           width: 4,
            //         ),
            //         // GestureDetector(
            //         //   onTap: widget.onTap,
            //         //   child: const Text(
            //         //     'Login now',
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
