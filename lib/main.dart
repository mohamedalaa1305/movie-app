import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/DataController.dart';
import 'package:movie_app/ui/Splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie Box',
        home: Splash(),
        theme: ThemeData(
          // textTheme: GoogleFonts.robotoSlabTextTheme(Theme.of(context).textTheme),
          textTheme: GoogleFonts.abelTextTheme(Theme.of(context).textTheme),
        ),
      ),
    );
  }
}
