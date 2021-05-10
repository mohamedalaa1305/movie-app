import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Network.dart';

const List<Color> Kplatte1 = [
  Color(0xff212121),
  Color(0xff212121),
  Color(0xff181818),
  Color(0xff660708),
  Color(0xffa4161a),
  Color(0xffba181b),
  Color(0xffe5383b),
  Color(0xffb1a7a6),
  Color(0xffd3d3d3),
  Color(0xfff5f3f4)
];
const List<Color> Kplatte2 = [
  Color(0xff004c4c),
  Color(0xff2ec4b6),
  Color(0xff000000),
  Color(0xff14213d),
  Color(0xfffca311),
  Color(0xffe5e5e5),
  Color(0xffffffff),
  Color(0xff011627),
  Color(0xff042443),
  Color(0xfffdfffc),
  Color(0xffe71d36),
  Color(0xffff9f1c)
];

const String background = 'Background';
const String txt = 'Text';
const String button = 'Button';
const String subText = 'subText';
const String label = 'label';
const String fill = 'fill';
const String readMore = 'readmore';
const String backgroundinverse = 'backinv';
const Map<String, Color> DarkTheme = {
  background: Color(0xff212121),
  txt: Colors.white,
  subText: Colors.white70,
  fill: Colors.black26,
  button: Color(0xff00acc1),
  label: Colors.blue,
  readMore: Colors.cyan,
  backgroundinverse: Color(0xffdfdfdf),
};
//? 0 1 2 3 4 5 6 7 8 9 a b c d e f
//? f e d c b a 9 8 7 6 5 4 3 2 1 0
const Map<String, Color> LightTheme = {
  background: Color(0xffdfdfdf),
  txt: Colors.black,
  subText: Colors.black54,
  fill: Colors.white70,
  button: Color(0xff00acc1),
  label: Colors.blue,
  readMore: Colors.cyan,
  backgroundinverse: Color(0xff212121),
  // button: Color(0xffff533e),
  // label: Colors.red,
  // readMore: Colors.red,
};

const String logodark = 'assets/images/tmdblogo.png';
const String logolight = 'assets/images/tmdblogolight.png';
String logo = logodark;

Map<String, Color> appTheme = DarkTheme;
TextStyle kTabTextStyle = GoogleFonts.abel(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
);
TextStyle kSectionTitleTextStyle = GoogleFonts.abel().copyWith(
  fontSize: 18,
  letterSpacing: 2,
  color: appTheme[txt],
  fontWeight: FontWeight.bold,
);

const String KLandscapePlaceHolder = 'assets/images/landscape23.jpg';
const String KPortraitPlaceHolder = 'assets/images/def3.png';
const String KProfilePlaceHolder = 'assets/images/profileplaceholder.png';

String youtube = 'https://www.youtube.com/watch?v=';
String vimeo = 'https://vimeo.com/';
const Widget loading = Center(
  child: CircularProgressIndicator(),
);
final Network api = Network();
