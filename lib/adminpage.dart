import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testapp2/addpage.dart';
import 'package:testapp2/userlist.dart';

import 'catdetail.dart';
import 'register_admin.dart';

class adminpage extends StatelessWidget {
  adminpage({Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  GlobalKey<FormState> key = GlobalKey();

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('User');

  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 116, 1),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Center(
                    child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            'lib/images/logo.png',
            height: 150,
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                const Text(
                  'click here to add cat data: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 252, 165, 34)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddPage()),
                      );
                    },
                    child: Text('new Cat')),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('click here to add new admin user: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 252, 165, 34)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => registeradmin()),
                );
              },
              child: Text('new Admin')),
          const SizedBox(
            height: 20,
          ),
          Text('Click here to see the User List',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(
            width: 20,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 252, 165, 34)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => userlist()),
                );
              },
              child: Text('User List')),
        ])))));
  }
}
