import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NothingToShowContainer extends StatelessWidget {
  const NothingToShowContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.235,
      child: Center(
        child: Text(
          'No Thing To Show',
          style: GoogleFonts.abel().copyWith(
            color: Colors.white54,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
