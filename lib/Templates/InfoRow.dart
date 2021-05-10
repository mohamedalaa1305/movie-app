import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants.dart';

class InfoRow extends StatelessWidget {
  final info, mxlines, icon;
  final double iconsize;
  const InfoRow({
    Key key,
    this.icon,
    this.info,
    this.iconsize,
    this.mxlines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: appTheme[txt],
          size: iconsize,
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Text(
            info,
            maxLines: mxlines,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.abel().copyWith(
              color: appTheme[txt],
            ),
          ),
        ),
      ],
    );
  }
}
