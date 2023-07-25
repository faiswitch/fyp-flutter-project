import 'package:flutter/material.dart';
import 'CameraPage.dart';
import 'LibraryPage.dart';
import 'firstmenu.dart';
import 'profile.dart';
import 'camtwo.dart';
import 'package:firebase_auth/firebase_auth.dart';

final user = FirebaseAuth.instance.currentUser!;

// sign user out method
void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Set the number of tabs here
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Nya Chat'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(255, 231, 116, 1),
            actions: [
              IconButton(
                onPressed: () {
                  signUserOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const firstmenu()),
                  );
                },
                icon: Icon(Icons.logout),
              )
            ]),
        bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(255, 231, 116, 1),
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.book), text: 'Cat Dictionary'),
              Tab(icon: Icon(Icons.camera), text: 'Cat Scanner'),
              Tab(icon: Icon(Icons.person), text: 'Profile Page'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LibraryPage(),
            CameraApp(),
            Profile(),
          ],
        ),
      ),
    );
  }
}
