import 'package:flutter/material.dart';
import 'package:testapp2/adminpage.dart';
import 'package:testapp2/firstmenu.dart';
import 'CameraPage.dart';
import 'LibraryPage.dart';
import 'profile.dart';
import 'addpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

final user = FirebaseAuth.instance.currentUser!;

// sign user out method
void signUserOut() {
  FirebaseAuth.instance.signOut();
}

class Homeadmin extends StatelessWidget {
  const Homeadmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Set the number of tabs here
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Nya Admin'),
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
            labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
            tabs: [
              Tab(icon: Icon(Icons.book), text: '      Cat \nDictionary'),
              Tab(icon: Icon(Icons.camera), text: '    Cat \nScanner'),
              Tab(icon: Icon(Icons.person), text: '  Profile \n   Page'),
              Tab(icon: Icon(Icons.add_circle_outline), text: 'Admin\n Page')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LibraryPage(),
            CameraApp(),
            Profile(),
            adminpage(),
          ],
        ),
      ),
    );
  }
}
