import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color c0 = Color(0xff03071e);
const Color c1 = Color(0xff370617);
const Color c2 = Color(0xff6a040f);
const Color c3 = Color(0xff9d0208);
const Color c4 = Color(0xffd00000);
const Color c5 = Color(0xffdc2f02);
const Color c6 = Color(0xffe85d04);
const Color c7 = Color(0xffffba08);
const Color c8 = Color(0xfff48c06);
const Color c9 = Color(0xfffaa307);

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

TextStyle kTabTextStyle = GoogleFonts.abel(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
);
TextStyle kSectionTitleTextStyle = GoogleFonts.abel().copyWith(
  fontSize: 18,
  letterSpacing: 2,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);
const String KLandscapePlaceHolder = 'assets/images/landscape.jpg';
const String KPortraitPlaceHolder = 'assets/images/def3.png';
const String KProfilePlaceHolder = 'assets/images/profileplaceholder.png';
String youtube = 'https://www.youtube.com/watch?v=';
String vimeo = 'https://vimeo.com/';
const Widget loading = Center(
  child: CircularProgressIndicator(),
);
