import 'package:flutter/material.dart';
import "package:image_picker/image_picker.dart";
import "package:firebase_storage/firebase_storage.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import "dart:io";
class uploadCertifcate extends StatefulWidget {
 
  @override
  State<uploadCertifcate> createState() => _uploadCertifcateState();
}

class _uploadCertifcateState extends State<uploadCertifcate> {
   
   Stream get_Image;
   File image;
   String image_Url;
   List fileName=[];
  //const uploadCertifcate({ Key? key }) : super(key: key);
 Future getImage(ImageSource source) async {
    var img = await ImagePicker.pickImage(source: source);
    
    setState(() {
      image = img;
    });
    if (image != null) {
      String filePlace = image.path
          .replaceAll('/', ' ')
          .replaceAll("image_picker", "Collegial");
      fileName = filePlace.split(" ");
      _showMyDialog(fileName);
    }
  }

  Future<void> _showMyDialog(List fileName) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 3,
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                    ))
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('cancel'),
              onPressed: () {
                image = null;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('attach'),
              onPressed: () async {
                Navigator.of(context).pop();
                uploadToStorage(fileName, image);
              },
            ),
          ],
        );
      },
    );
  }
Widget bottomSheet(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30
      ),
      child: Column(
          children:<Widget>[
            Text(
                "Choose Profile photo",
                style: TextStyle(
                    fontSize:20.0
                )
            ),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton.icon(onPressed: (){getImage(ImageSource.camera);}, icon: Icon(Icons.camera_alt), label: Text("Camera")),
                FlatButton.icon(onPressed: (){getImage(ImageSource.gallery);}, icon: Icon(Icons.image), label: Text("Gallery")),
              ],)

          ]
      ),
    );
  }
  Future uploadToStorage(List fileName, File file) async {
    var profileImage = FirebaseStorage.instance
        .ref()
        .child('Profile')
        .child('/${fileName[fileName.length - 1]}');
    var task = profileImage.putFile(image);
    if (task.isComplete) {
      image_Url = await (await task.onComplete).ref.getDownloadURL();
    }
    if (task != null) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  StreamBuilder<StorageTaskEvent>(
                      stream: task.events,
                      builder: (context, snapshot) {
                        var event = snapshot?.data?.snapshot;

                        double progressPercentIndicator = event != null
                            ? event.bytesTransferred / event.totalByteCount
                            : 0;

                        return Column(
                          children: [
                            if (task.isComplete)
                              Text('profile photo is uploaded'),
                            LinearProgressIndicator(
                                value: progressPercentIndicator),
                            Text(
                                "${(progressPercentIndicator * 100).toStringAsFixed(2)}%")
                          ],
                        );
                      })
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('ok'),
                onPressed: () async {
                  image_Url =
                      await (await task.onComplete).ref.getDownloadURL();
                  // var userImage = await Firestore.instance
                  //     .collection("users")
                  //     .where('email', isEqualTo: widget.userProfileEmail)
                  //     .getDocuments();
                  // userImage.documents.forEach((result) {
                  //   Firestore.instance
                  //       .collection("users")
                  //       .document(result.documentID)
                  //       .updateData({"image": image_Url});
                  // });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  GestureDetector(
        onTap:(){
            showBottomSheet(context: context, builder: ((builder) => bottomSheet()));
        },
        child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                                child: Container(
                                  height: 60,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [Text(
                                          "certificate",
                                          //widget.phone_number,
                                          style: TextStyle(color: Colors.black87),
                                        ),Icon(Icons.camera_alt_outlined)
                                        ]
                                      
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      border:
                                          Border.all(width: 1.0, color: Colors.black87)),
                                ),
                              ),
      ),
      
    );
  }
  }