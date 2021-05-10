import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:path/path.dart';

import 'package:ediot/model/room.dart';

import 'firebase_api.dart';

class CreateRoom extends StatefulWidget {
  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final desController = TextEditingController();

  File? file;
  UploadTask? task;
  String? urlDownload;

  Widget showImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: file == null
          ? Container(
              width: 200,
              height: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text("Image Room"),
            )
          : Image.file(file!),
    );
  }

  Widget photoButton() {
    return IconButton(
        onPressed: getImage,
        icon: Icon(
          Icons.add_photo_alternate,
          size: 30,
        ));
  }

  Future<void> getImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() => file = File(path));
  }

  Future<void> uploadimg() async {
    if (file == null) return;

    final fileName = 'subject1';
    final destination = 'Subject/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);
            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "Create Room",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: ListView(
            shrinkWrap: true,
            children: [
              showImage(context),
              photoButton(),
              task != null ? buildUploadStatus(task!) : Container(),
              TextFormField(
                controller: nameController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter a valid room name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Name",
                  prefixIcon: Icon(Icons.people),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: desController,
                decoration: InputDecoration(
                  labelText: "Description (ไม่บังคับ)",
                  prefixIcon: Icon(Icons.description),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                    24,
                  )),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                height: 30,
              ),
              SafeArea(
                child: Container(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: [
                      FlatButton(
                        height: 50,
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        color: Colors.greenAccent[700],
                        child: Text("Create"),
                        textColor: Colors.white,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            var room_name = nameController.text;
                            var description = desController.text;
                            String uid = auth.currentUser!.uid;
                            Room room = Room(
                                name: room_name,
                                description: description,
                                uid: uid);
                            Map<String, dynamic> data = room.toMap();
                            await FirebaseFirestore.instance
                                .collection('Subject')
                                .doc(room_name)
                                .set(data);
                            Navigator.pop(context);
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FlatButton(
                        height: 50,
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        color: Colors.redAccent[700],
                        child: Text("Cancel"),
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
