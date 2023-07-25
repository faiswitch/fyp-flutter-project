import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'catdetail.dart';

class SavedCatDetails extends StatelessWidget {
  SavedCatDetails(this.itemId, {Key? key}) : super(key: key) {
    _reference = FirebaseFirestore.instance.collection('saved cat').doc(itemId);
    _futureData = _reference.get();
  }

  String itemId;
  late DocumentReference _reference;

  //_reference.get()  --> returns Future<DocumentSnapshot>
  //_reference.snapshots() --> Stream<DocumentSnapshot>
  late Future<DocumentSnapshot> _futureData;
  late Map data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 165, 34),
      appBar: AppBar(
        title: Text('Cat details'),
        backgroundColor: Color.fromARGB(255, 231, 116, 1),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: _futureData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('Some error occurred ${snapshot.error}'));
            }

            if (snapshot.hasData) {
              //Get the data
              DocumentSnapshot documentSnapshot = snapshot.data;
              data = documentSnapshot.data() as Map;

              //display the data
              return Column(
                children: [
                  Image(image: NetworkImage('${data['imageurl']}')),
                  Text(
                    '${data['nickname']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "He's Breed: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${data['breed']}',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "More Info: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 231, 116, 1)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CatDetails('${data['breed']}')));
                      },
                      child: Text('Details'))
                ],
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
