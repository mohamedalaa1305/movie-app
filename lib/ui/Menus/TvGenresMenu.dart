import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Controllers/DiscoverController.dart';
import 'package:movie_app/Controllers/ThemeController.dart';
import 'package:provider/provider.dart';

class TvGenresMenu extends StatelessWidget {
  TvGenresMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("building tv menu");
    final ThemeController tc = context.watch<ThemeController>();
    final DiscoverController dc = context.watch<DiscoverController>();
    return Container(
        padding: EdgeInsets.only(
          bottom: 64 + kFloatingActionButtonMargin,
          // right: 16,
        ),
        decoration: BoxDecoration(
          color: appTheme[background],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Scrollbar(
          thickness: 2,
          child: ListView(
            primary: false,
            children: List.generate(
              tvGenres.length,
              (idx) => Theme(
                data: ThemeData(
                  unselectedWidgetColor: appTheme[txt],
                ),
                child: CheckboxListTile(
                  checkColor: appTheme[txt],
                  activeColor: appTheme[button],
                  controlAffinity: ListTileControlAffinity.leading,
                  value: dc.tvcbx[idx],
                  onChanged: (val) => onChanged(idx, val, dc),
                  title: Text(
                    tvGenres.keys.toList()[idx],
                    style: GoogleFonts.abel().copyWith(
                      color: (dc.tvcbx[idx]) ? appTheme[button] : appTheme[txt],
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void onChanged(int idx, bool val, DiscoverController dc) {
    print("check button changed " + "val = " + val.toString());
    if (val)
      dc.addGenre(idx, 'tv');
    else
      dc.removeGenre(idx, 'tv');
  }
}
