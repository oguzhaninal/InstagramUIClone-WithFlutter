import 'package:bloguygulamasi_insta/animasyon.dart';
import 'package:bloguygulamasi_insta/kayitOl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'anaSayfa.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FadeAnimation(
        1.2,
        Scaffold(
          bottomNavigationBar: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  height: 0,
                  color: Colors.black,
                ),
                NewUser(),
              ],
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InstaLogo(),
              GirisFormu(),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Column(
                  children: [
                    FadeAnimation(
                      1.2,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              height: 20,
                              color: Colors.black,
                            ),
                          ),
                          Text("YA DA"),
                          Expanded(
                            child: Divider(
                              height: 25,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              FaceLogin(),
            ],
          ),
        ),
      ),
    );
  }
}

class GirisFormu extends StatefulWidget {
  @override
  _GirisFormuState createState() => _GirisFormuState();
}

class _GirisFormuState extends State<GirisFormu> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String email;
  String pass;
  bool _passwordVisible = false;

  girisYap() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: t1.text, password: t2.text)
        .whenComplete(() {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => AnaSayfa(t1.text),
          ),
          (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(s.height * 0.001),
        child: Column(
          children: [
            epostaField(),
            FadeAnimation(
              1.2,
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 50, right: 50),
                child: Container(
                  child: TextFormField(
                    controller: t2,
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
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: FlatButton(
                  minWidth: double.maxFinite,
                  color: Colors.blue,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      girisYap();
                    }
                  },
                  child: Text(
                    "Giris Yap",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            FadeAnimation(
              1.2,
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Şifrenizi mi unuttunuz? ",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "Giriş yapmak için yardım al",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.indigo[1000],
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AnaSayfa(t1.text),
                              ),
                              (Route<dynamic> route) => false);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  epostaField() {
    return FadeAnimation(
      1.2,
      Padding(
        padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
        child: Container(
          child: TextFormField(
            controller: t1,
            decoration: InputDecoration(
              hintText: "E-Postanızı Giriniz*",
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
                return "E-Posta Alanı Boş Geçilemez";
              }
            },
            onSaved: (String val) {
              email = val;
            },
          ),
        ),
      ),
    );
  }
}

class InstaLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1.2,
      Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 0, right: 50, left: 50),
          child: Text(
            "Instagram",
            style: TextStyle(fontSize: 50, fontFamily: "Lobster"),
          ),
        ),
      ),
    );
  }
}

class FaceLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1.2,
      Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 15),
        child: FlatButton(
          minWidth: 1000,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.facebook,
                color: Colors.white,
              ),
              Text(
                "  ile giriş yap",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          color: Colors.blue,
          onPressed: () {},
        ),
      ),
    );
  }
}

class NewUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1.2,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Hesabın yok mu?"),
          FlatButton(
            padding: EdgeInsets.all(0),
            child: Text(
              "Kaydol.",
              style: TextStyle(
                  color: Colors.indigo[1000],
                  decoration: TextDecoration.underline),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => KayitOl()),
                  (route) => false);
            },
          )
        ],
      ),
    );
  }
}
