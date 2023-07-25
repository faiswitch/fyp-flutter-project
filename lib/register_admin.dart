import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testapp2/components/mybutt.dart';
import 'package:testapp2/components/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testapp2/homeadmin.dart';

class registeradmin extends StatefulWidget {
  //final Function()? onTap;
  const registeradmin({super.key});
  //required this.onTap});

  @override
  State<registeradmin> createState() => _registeradminState();
}

class _registeradminState extends State<registeradmin> {
  final usernameController = TextEditingController();
  final confirmpass = TextEditingController();
  final passwordController = TextEditingController();

  void back() {}

  postDetail(String email) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference ref = FirebaseFirestore.instance.collection('User');
    ref.doc(user.uid).set({'email': usernameController.text, 'role': 'admins'});
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
      } else {
        notsamepass();
      }

      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.deepPurple,
                title: Center(
                  child: Text(
                    'new Admin Added',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Homeadmin()),
                        );
                      },
                      child: Text('home'))
                ],
              );
            });
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
              'Please fill in the new admin info',
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
              text: 'Add User',
            ),

            const SizedBox(
              height: 20,
            ),

            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 252, 165, 34),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        )))));
  }
}
