import 'dart:ffi';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:testapp2/register_admin.dart';

import 'components/mytextfield.dart';
import 'register_page.dart';

// ignore: camel_case_types
class Addcat extends StatefulWidget {
  Addcat({super.key});

  @override
  State<Addcat> createState() => _AddcatState();
}

class _AddcatState extends State<Addcat> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final passrequest = TextEditingController();
  final descrip = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();

  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('saved cat');

  String imageUrl = '';

  bool ispic = false;
  void senddata(String email) {
    if (imageUrl.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please upload an image')));

      return;
    } else {
      String itemName = passrequest.text;
      String itemQuantity = descrip.text;
      //Create a Map of data
      Map<String, String> dataToSend = {
        'breed': itemQuantity,
        'nickname': itemName,
        'user': email,
        'imageurl': imageUrl,
      };

      //Add a new item
      _reference.add(dataToSend);
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Cat Has Been Added'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final email = user!.email;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 231, 116, 1),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: const Text(
                      'New Cat:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  mytextfield(
                    controller: passrequest,
                    hintText: 'Cat Nickname',
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  mytextfield(
                    controller: descrip,
                    hintText: 'Cat Breed',
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  IconButton(
                      onPressed: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        print('${file?.path}');

                        if (file == null) return;
                        //Import dart:core
                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');

                        //Create a reference for the image to be stored
                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);

                        //Handle errors/success
                        try {
                          //Store the file
                          await referenceImageToUpload.putFile(File(file.path));
                          //Success: get the download URL
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                          ispic = true;
                        } catch (error) {
                          //Some error occurred
                        }
                      },
                      icon: ispic
                          ? Icon(
                              Icons.image,
                              color: Colors.black,
                            )
                          : Icon(
                              Icons.image,
                              color: Colors.grey,
                            )),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 252, 165, 34)),
                        onPressed: () async {
                          senddata(email!);
                        },
                        child: Text('Add'),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 252, 165, 34)),
                          onPressed: () {
                            passrequest.clear();
                            descrip.clear();
                          },
                          child: Text('Clear')),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 252, 165, 34)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back'))
                ],
              ),
            )),
          ),
        ));
  }
}
