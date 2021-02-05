import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnaSayfa extends StatefulWidget {
  final String kullaniciId;
  AnaSayfa(this.kullaniciId);
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                "Instagram",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontFamily: "Lobster",
                ),
              ),
              actions: [
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.plusSquare,
                      color: Colors.black,
                    ),
                    onPressed: null),
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.heart,
                      color: Colors.black,
                    ),
                    onPressed: null),
                IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.facebookMessenger,
                      color: Colors.black,
                    ),
                    onPressed: null),
              ],
            ),
          ),
          body: Container(
            child: Column(
              children: [
                InstaStories(),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InstaStories extends StatelessWidget {
  final stories = Expanded(
    child: Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/pp.jpg"),
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("isim"),
                    ],
                  ),
                ),
              ],
            ),
            index == 0
                ? Positioned(
                    right: 10.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      radius: 10.0,
                      child: Icon(
                        Icons.add,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .12,
      margin: const EdgeInsets.only(
        top: 1.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          stories,
        ],
      ),
    );
  }
}

class InstaCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Widget hikaye(
//   String resim,
//   String isim,
// ) {
//   return Column(
//     children: [
//       InkWell(
//         onTap: () {},
//         child: Container(
//           width: 80,
//           height: 80,
//           decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(80),
//               border: Border.all(width: 4, color: Colors.red[700]),
//               image: DecorationImage(image: NetworkImage(resim))),
//         ),
//       ),
//       SizedBox(height: 2),
//       Text(
//         isim,
//         style: TextStyle(color: Colors.black, fontSize: 16),
//       )
//     ],
//   );
// }
