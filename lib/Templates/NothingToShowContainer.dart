import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';

class NothingToShowContainer extends StatelessWidget {
  const NothingToShowContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Center(
        child: Text(
          'No Thing To Show',
          style: GoogleFonts.abel().copyWith(
            color: appTheme[subText],
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
