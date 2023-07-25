import 'package:flutter/material.dart';
import 'package:testapp2/login_page.dart';
import 'LibraryPage.dart';
import 'camnouse.dart';

class Homeguest extends StatelessWidget {
  const Homeguest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Set the number of tabs here
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                icon: Icon(Icons.person),
              )
            ]),
        bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(255, 231, 116, 1),
          child: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.book),
                text: 'Cat Scanner',
              ),
              Tab(
                icon: Icon(Icons.camera),
                text: 'Cat Dictionary',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LibraryPage(),
            CameraApp(),
          ],
        ),
      ),
    );
  }
}
