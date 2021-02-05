import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VideoResim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ButonEkrani(),
    );
  }
}

class ButonEkrani extends StatefulWidget {
  @override
  _ButonEkraniState createState() => _ButonEkraniState();
}

class _ButonEkraniState extends State<ButonEkrani> {
  File yuklenecekDosya;
  FirebaseAuth auth = FirebaseAuth.instance;
  String profilResmiUrlsi;

  kameradanVideoYukle() async {
    var alinanDosya = await ImagePicker().getVideo(source: ImageSource.camera);
    setState(() {
      yuklenecekDosya = File(alinanDosya.path);
    });

    Reference referansYol = FirebaseStorage.instance
        .ref()
        .child("Videolar")
        .child(auth.currentUser.uid)
        .child("video" + DateTime.now().toString());

    UploadTask yuklemeGorevi = referansYol.putFile(yuklenecekDosya);
    yuklemeGorevi.then((url) async {
      setState(() async {
        profilResmiUrlsi = await url.ref.getDownloadURL();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RaisedButton(
            child: Text("Video Yükle"),
            onPressed: kameradanVideoYukle,
          )
        ],
      ),
    );
  }
}
