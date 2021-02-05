import 'dart:io';

import 'package:bloguygulamasi_insta/anaSayfa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'login.dart';

class ProfilSayfasi extends StatefulWidget {
  final String kullaniciId;
  ProfilSayfasi(this.kullaniciId);
  @override
  _ProfilSayfasiState createState() => _ProfilSayfasiState();
}

class _ProfilSayfasiState extends State<ProfilSayfasi> {
  cikisYap() {
    FirebaseAuth.instance.signOut().then(
          (kullanici) => showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actions: [
                  RaisedButton(
                      child: Text("Devam Et"),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                            (Route<dynamic> route) => false);
                      })
                ],
                title: Text("Başarılı"),
                content: Text("Kullanıcı Çıkışı Yapıldı"),
              );
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Sayfası"),
        actions: [
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnaSayfa(widget.kullaniciId),
                    ),
                    (Route<dynamic> route) => false);
              }),
          IconButton(
            tooltip: "Çıkış Yap",
            icon: Icon(Icons.logout),
            onPressed: cikisYap,
          ),
        ],
      ),
      body: ProfilTasarim(widget.kullaniciId),
    );
  }
}

class ProfilTasarim extends StatefulWidget {
  final String kullaniciId;
  ProfilTasarim(this.kullaniciId);
  @override
  _ProfilTasarimState createState() => _ProfilTasarimState();
}

class _ProfilTasarimState extends State<ProfilTasarim> {
  File yuklenecekDosya;
  FirebaseAuth auth = FirebaseAuth.instance;
  String profilResmiUrlsi;

  void initState() {
    super.initState();

    // baglantiAl();
  }

  baglantiAl() async {
    String baglanti = await FirebaseStorage.instance
        .ref()
        .child("ProfilResimleri")
        .child(auth.currentUser.uid)
        .child("profilResmi.png")
        .getDownloadURL();

    setState(() {
      profilResmiUrlsi = baglanti;
    });
  }

  kameradanYukle() async {
    var alinanDosya = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      yuklenecekDosya = File(alinanDosya.path);
    });

    Reference referansYol = FirebaseStorage.instance
        .ref()
        .child("ProfilResimleri")
        .child(auth.currentUser.uid)
        .child("profilResmi" + DateTime.now().toString());

    UploadTask yuklemeGorevi = referansYol.putFile(yuklenecekDosya);
    yuklemeGorevi.then((url) async {
      setState(() async {
        profilResmiUrlsi = await url.ref.getDownloadURL();
      });
      FirebaseFirestore.instance
          .collection("Kullanicilar")
          .doc("melikhann@aiesec.net")
          .update({
        "ProfilResmiUrl": profilResmiUrlsi,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ClipOval(
            child: profilResmiUrlsi == null
                ? Text("Profil Resmi Bulunamadı")
                : Image.network(
                    profilResmiUrlsi,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
          ),
          RaisedButton(child: Text("PP Yükle"), onPressed: kameradanYukle),
        ],
      ),
    );
  }
}
