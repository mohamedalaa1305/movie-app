import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants.dart';

class IconText extends StatelessWidget {
  final String text;
  final IconData icon;
  const IconText({
    Key key,
    @required this.text,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: GoogleFonts.robotoSlab().copyWith(
              color: appTheme[txt],
              fontSize: 11,
            ),
          ),
          SizedBox(
            width: 2,
          ),
          Icon(icon),
        ],
      ),
      data: IconThemeData(
        color: appTheme[txt],
        size: 13,
      ),
    );
  }
}
