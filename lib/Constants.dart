import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Network.dart';

const String menubackground = 'mb';
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
  label: Color(0xff00acc1),
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
  label: Color(0xff00acc1),
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
Map<String, String> movieGenres = {}, tvGenres = {};
