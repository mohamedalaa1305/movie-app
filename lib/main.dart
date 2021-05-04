import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Controllers/DataController.dart';
import 'package:movie_app/ui/Splash.dart';
import 'package:movie_app/ui/TestingScreen.dart';
import 'package:provider/provider.dart';

import 'Controllers/MediaController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<MediaController>(
        //   create: (_) => MediaController(),
        // ),
        ChangeNotifierProvider<DataController>(
          create: (_) => DataController(),
        ),
      ],
      child: GetMaterialApp(
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
