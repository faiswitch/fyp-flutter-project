import 'package:flutter/material.dart';
import 'package:testapp2/home.dart';
import 'package:testapp2/login_or_register.dart';
import 'package:testapp2/login_page.dart';

class gobut extends StatelessWidget {
  final Function()? onTap;
  const gobut({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
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
            "login",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
