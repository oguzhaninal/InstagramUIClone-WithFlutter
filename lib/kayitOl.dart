import 'package:bloguygulamasi_insta/animasyon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class KayitOl extends StatefulWidget {
  @override
  _KayitOlState createState() => _KayitOlState();
}

class _KayitOlState extends State<KayitOl> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: FadeAnimation(
      1.2,
      Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextNew(),
            SignUpYazisi(),
            KayitFormu(),
            OldUser(),
          ],
        ),
      ),
    ));
  }
}

class KayitFormu extends StatefulWidget {
  @override
  _KayitFormuState createState() => _KayitFormuState();
}

class _KayitFormuState extends State<KayitFormu> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String name;
  String email;
  String pass;

  Future<void> kayitOl() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: t2.text, password: t3.text)
        .then((kullanici) {
      FirebaseFirestore.instance.collection("Kullanicilar").doc(t2.text).set({
        "KullaniciAdi": t1.text,
        "KullaniciEposta": t2.text,
        "KullaniciSifre": t3.text
      });
    }).whenComplete(() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
          (Route<dynamic> route) => false);
    });
    t1.clear();
    t2.clear();
    t3.clear();
  }

  bool _passwordVisible;
  // ignore: must_call_super
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FadeAnimation(
            1.2,
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
              child: Container(
                child: TextFormField(
                  controller: t1,
                  decoration: InputDecoration(
                    hintText: "Kullanıcı Adı*",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  // ignore: missing_return
                  validator: (String val) {
                    if (val.isEmpty) {
                      return "Kullanıcı adı girmeniz gerekmektedir..";
                    }
                  },
                  onSaved: (String val) {
                    email = val;
                  },
                ),
              ),
            ),
          ),
          FadeAnimation(
            1.2,
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 50, right: 50),
              child: Container(
                child: TextFormField(
                  controller: t2,
                  decoration: InputDecoration(
                    hintText: "E-Posta*",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  // ignore: missing_return
                  validator: (String val) {
                    if (val.isEmpty) {
                      return "E Posta alanı boş geçilemez";
                    }
                  },
                  onSaved: (String val) {
                    email = val;
                  },
                ),
              ),
            ),
          ),
          FadeAnimation(
            1.2,
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 50, right: 50),
              child: Container(
                child: TextFormField(
                  controller: t3,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    hintText: "Şifre*",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey[400],
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        }),
                  ),
                  // ignore: missing_return
                  validator: (String val) {
                    if (val.isEmpty) {
                      return "Şifre boş bırakılamaz..";
                    } else if (val.length < 8) {
                      return " Şifre 8 karakterden az olamaz!";
                    }
                  },
                  onSaved: (String val) {
                    email = val;
                  },
                ),
              ),
            ),
          ),
          FadeAnimation(
            1.2,
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 50, right: 50),
              child: Container(
                child: FlatButton(
                  minWidth: 1000.0,
                  child: Text(
                    "Kayıt Ol",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      kayitOl();
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TextNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1.2,
      Padding(
        padding: const EdgeInsets.only(
          top: 25,
          left: 50,
          right: 50,
        ),
        child: Text(
          "Kayıt Ol",
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 50,
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}

class SignUpYazisi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1.2,
      Padding(
        padding: const EdgeInsets.only(top: 25, right: 50, left: 50),
        child: Text(
          "Kendini diğerlerinden ayırmak için hemen bir kullanıcı adı belirle!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class OldUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1.2,
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Zaten Hesabın Var mı?",
              textAlign: TextAlign.center,
              style: TextStyle(),
            ),
            FlatButton(
              child: Text(
                "Giriş Yap",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                    (Route<dynamic> route) => false);
              },
            )
          ],
        ),
      ),
    );
  }
}
