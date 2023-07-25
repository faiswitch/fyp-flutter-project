import 'package:flutter/material.dart';
import 'package:testapp2/CameraPage.dart';
import 'package:testapp2/home.dart';
import 'package:testapp2/homeguest.dart';

class Guest extends StatelessWidget {
  final Function()? onTap;
  const Guest({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homeguest()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 252, 165, 34),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Join as Guest",
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
