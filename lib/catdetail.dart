import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CatDetails extends StatelessWidget {
  CatDetails(this.itemId, {Key? key}) : super(key: key) {
    _reference =
        FirebaseFirestore.instance.collection('cat dictionary').doc(itemId);
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
                    '${data['name']}',
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
                    "Cat details: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '${data['description']}',
                      textAlign: TextAlign.center,
                    ),
                  )
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
