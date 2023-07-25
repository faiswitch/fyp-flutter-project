import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:testapp2/addfromcam.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'LibraryPage.dart';
import 'addcat.dart';
import 'catdetail.dart';
import 'classified.dart';
import 'classifier_quant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(CameraApp());
}

final user = FirebaseAuth.instance.currentUser!;

// sign user out method
void signUserOut() {
  FirebaseAuth.instance.signOut();
}

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late List<CameraDescription> deviceCameras;
  late CameraController camController;
  late Future<void> _initializeControllerFuture;

  bool _loading = true;
  List? _output;
  final picker = ImagePicker();

  late Classifier _classifier;
  File? _image;
  Image? _imageWidget;
  img.Image? fox;
  Category? category;

  bool isReady = false;

  @override
  void initState() {
    getCamera();
    loadModel();
    super.initState();
    _classifier = ClassifierQuant();
  }

  void getCamera() async {
    final deviceCameras = await availableCameras();
    camController = CameraController(deviceCameras.first, ResolutionPreset.high,
        enableAudio: false);
    _initializeControllerFuture = camController.initialize().then((value) {
      isReady = true;
      if (!mounted) {
        return;
      }

      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    camController.dispose();
    Tflite.close();

    super.dispose();
  }

  classifyImage(File image) async {
    //this function runs the model on the image

    // var output = await Tflite.runModelOnImage(
    //     path: image.path,
    //     numResults: 36, //the amout of categories our neural network can predict
    //     threshold: 0.5,
    //     imageMean: 127.5,
    //     imageStd: 127.5,
    //     asynch: true);
    print('here is smthg');

    setState(() {
      // _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    //this function loads our model
    await Tflite.loadModel(
        model: 'assets/model.tflite', labels: 'assets/labels.txt');
  }

  Future<void> pickImage(var image) async {
    //this function to grab the image from camera
    setState(() {
      _image = File(image.path);
    });
  }

  Future getImage(String imagePath) async {
    setState(() {
      _image = File(imagePath);
      _imageWidget = Image.file(_image!);

      _predict();
    });
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);
    print(pred);
    setState(() {
      this.category = pred;
    });
  }

  Future pickGalleryImage() async {
    //this function to grab the image from gallery
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    _image = File(image.path);

    setState(() {
      _imageWidget = Image.file(_image!);

      _predict();
    });
    return Image.file(_image!);
  }

  // searchdata(String catdata) async {
  //   late DocumentReference _reference;

  //   late Future<DocumentSnapshot> _futureData;
  //   late Map data;

  //   _reference =
  //       FirebaseFirestore.instance.collection('cat dictionary').doc(catdata);
  //   _futureData = _reference.get();
  //   Builder:
  //   (BuildContext context, AsyncSnapshot snapshot) {
  //     if (snapshot.hasError) {
  //       return Center(child: Text('Some error occurred ${snapshot.error}'));
  //     }

  //     if (snapshot.hasData) {
  //       //Get the data
  //       DocumentSnapshot documentSnapshot = snapshot.data;
  //       data = documentSnapshot.data() as Map;
  //       return '${data['id']}';
  //     }
  //   };
  // }

  @override
  Widget build(BuildContext context) {
    if (isReady) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color.fromARGB(205, 224, 220, 216),
                    width: 4,
                  )),
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
                child: CameraPreview(camController),
              ),
            ),
          ),
        ),
        floatingActionButton: Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(233, 255, 180, 6),
                heroTag: null,
                onPressed: () async {
                  await pickGalleryImage().then((value) async => {
                        if (value != null)
                          {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DisplayGallery(
                                  // Pass the automatically generated path to
                                  // the DisplayPictureScreen widget.
                                  image: value,
                                  output: category != null
                                      ? 'Your cat is a ${category!.label}'
                                      : 'unidentified',
                                  //id: searchdata('${category!.label}'),
                                ),
                              ),
                            )
                          }
                      });
                },
                child: Icon(Icons.collections),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(233, 255, 180, 6),
                heroTag: null,
                // Provide an onPressed callback.
                onPressed: () async {
                  // Take the Picture in a try / catch block. If anything goes wrong,
                  // catch the error.
                  try {
                    // Ensure that the camera is initialized.
                    await _initializeControllerFuture;

                    // Attempt to take a picture and get the file `image`
                    // where it was saved.
                    final image = await camController.takePicture();

                    getImage(image.path);

                    if (!mounted) return;
                    await pickImage(image).then((value) async => {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DisplayPictureScreen(
                                // Pass the automatically generated path to
                                // the DisplayPictureScreen widget.
                                imagePath: image.path,
                                output: category != null
                                    ? 'Your cat is a ${category!.label}'
                                    : 'unidentified',
                                //id: searchdata('${category!.label}'),
                              ),
                            ),
                          )
                        });

                    // If the picture was taken, display it on a new screen.
                  } catch (e) {
                    // If an error occurs, log the error to the console.
                    print(e);
                  }
                },
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ],
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String output;
  //final String id;

  const DisplayPictureScreen(
      {super.key, required this.imagePath, required this.output});
  //required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(output),
          centerTitle: true,
          backgroundColor: Color.fromARGB(205, 231, 116, 1),
        ),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Image.file(File(imagePath)),
        floatingActionButton: Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: const Color.fromARGB(233, 255, 180, 6),
                child: const Icon(Icons.home),
                heroTag: null,
              ),
            ),
          ],
        ));
  }
}

class DisplayGallery extends StatelessWidget {
  final Image image;
  final String output;
  //final String id;
  const DisplayGallery({
    super.key,
    required this.image,
    required this.output,
  }); //required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(output),
          centerTitle: true,
          backgroundColor: Color.fromARGB(205, 231, 116, 1),
        ),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Center(child: image),
        floatingActionButton: Wrap(
          direction: Axis.vertical,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: const Color.fromARGB(233, 255, 180, 6),
                child: const Icon(Icons.home),
                heroTag: null,
              ),
            ),
          ],
        ));
  }
}
