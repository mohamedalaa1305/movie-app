import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoRow extends StatelessWidget {
  final txt, mxlines, icon;
  final double iconsize;
  const InfoRow({
    Key key,
    this.icon,
    this.txt,
    this.iconsize,
    this.mxlines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: iconsize,
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            txt,
            maxLines: mxlines,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.abel().copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
