import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Controllers/DataController.dart';
import 'package:movie_app/Controllers/DiscoverController.dart';
import 'package:movie_app/Controllers/ThemeController.dart';
import 'package:movie_app/ui/Screens/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'Controllers/SearchController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataController>(
          create: (_) => DataController(),
        ),
        ChangeNotifierProvider<SearchController>(
          create: (_) => SearchController(),
        ),
        ChangeNotifierProvider<ThemeController>(
          create: (_) => ThemeController(),
        ),
        ChangeNotifierProvider<DiscoverController>(
          create: (_) => DiscoverController(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie Box',
        home: SplashScreen(),
        theme: ThemeData(
          // textTheme: GoogleFonts.robotoSlabTextTheme(Theme.of(context).textTheme),
          textTheme: GoogleFonts.abelTextTheme(Theme.of(context).textTheme),
        ),
      ),
    );
  }
}
