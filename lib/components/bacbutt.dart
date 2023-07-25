import 'package:flutter/material.dart';
import 'package:testapp2/firstmenu.dart';

class bacbutt extends StatelessWidget {
  final Function()? onTap;
  const bacbutt({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => firstmenu()),
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
            "Back",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
