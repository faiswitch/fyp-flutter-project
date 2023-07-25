import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testapp2/addpage.dart';
import 'package:testapp2/savecatded.dart';

import 'LibraryPage.dart';
import 'catdetail.dart';
import 'register_admin.dart';

class catlist extends StatelessWidget {
  catlist(this.name, {Key? key}) : super(key: key) {
    _stream = _reference.snapshots();
  }

  final String name;

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection("saved cat");

  late Stream<QuerySnapshot> _stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 252, 165, 34),
          title: Text('Your cat')),
      backgroundColor: Color.fromARGB(255, 252, 165, 34),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //Check error
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          //Check if data arrived
          if (snapshot.hasData) {
            //get the data
            QuerySnapshot querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;

            //Convert the documents to Maps
            List<Map> items = documents
                .map((e) => {
                      'id': e.id,
                      'user': e['user'],
                      'nickname': e['nickname'],
                      'iurl': e['imageurl']
                    })
                .toList();
            items.sort((b, a) => (b['nickname']).compareTo(a['nickname']));

            const SizedBox(
              height: 30,
            );
            Text('Cat breed Dictionary ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold));
            //Display the list
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  //Get the item at this index
                  Map thisItem = items[index];
                  //REturn the widget for the list items
                  return ListTile(
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                        maxWidth: 64,
                        maxHeight: 64,
                      ),
                      child: Image(image: NetworkImage('${thisItem['iurl']}')),
                    ),
                    title: Text(
                      '${thisItem['nickname']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              SavedCatDetails('${thisItem['id']}')));
                    },
                  );
                });
          }

          //Show loader
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
