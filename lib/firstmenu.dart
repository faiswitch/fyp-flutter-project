import 'package:flutter/material.dart';
import 'package:testapp2/register_page.dart';
import 'components/guest.dart';
import 'components/gobut.dart';

// ignore: camel_case_types
class firstmenu extends StatefulWidget {
  const firstmenu({super.key});

  @override
  State<firstmenu> createState() => _firstmenuState();
}

class _firstmenuState extends State<firstmenu> {
  void golog() {}

  void gogo() {}

  @override
  Widget build(BuildContext context) {
    bool showLoginPage = true;

    void togglePages() {
      setState(() {
        showLoginPage = !showLoginPage;
      });
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 116, 1),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'lib/images/logo.png',
                height: 150,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Welcome to Nya Chat',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              const Text(
                'What would you like to do?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              gobut(onTap: golog),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => registerpage(
                            // onTap: () {
                            //   togglePages();
                            // },
                            )),
                  );
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
                      "Register",
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
              Guest(onTap: gogo),
            ],
          ),
        ),
      )),
    );
  }
}
