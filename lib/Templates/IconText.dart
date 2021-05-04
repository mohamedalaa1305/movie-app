import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class IconText extends StatelessWidget {
  final String txt;
  final IconData icon;
  const IconText({
    Key key,
    @required this.txt,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            txt,
            style: GoogleFonts.robotoSlab().copyWith(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          SizedBox(
            width: 2,
          ),
          Icon(icon),
        ],
      ),
      data: IconThemeData(
        color: Colors.white,
        size: 13,
      ),
    );
  }
}