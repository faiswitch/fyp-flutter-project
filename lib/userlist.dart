import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testapp2/addpage.dart';

import 'catdetail.dart';
import 'register_admin.dart';

class userlist extends StatefulWidget {
  const userlist({Key? key}) : super(key: key);

  @override
  State<userlist> createState() => _userliststate();
}

class _userliststate extends State<userlist> {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('User');

  Future<void> rejectJob(String jobId) {
    return FirebaseFirestore.instance.collection('jobs').doc(jobId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 252, 165, 34),
          title: Text('Active User')),
      backgroundColor: Color.fromARGB(255, 252, 165, 34),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('User').snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    return ListTile(
                      title: Text(
                        data['email'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(),
                      ),
                      subtitle: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {},
                          child: Text('delete')),
                    );
                  });
        },
      ),
    );
  }
}
