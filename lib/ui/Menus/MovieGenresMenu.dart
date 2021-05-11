import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Controllers/DiscoverController.dart';
import 'package:movie_app/Controllers/ThemeController.dart';
import 'package:provider/provider.dart';

class MovieGenresMenu extends StatelessWidget {
  const MovieGenresMenu({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    ThemeController tc = context.watch<ThemeController>();
    DiscoverController dc = context.watch<DiscoverController>();
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
              movieGenres.length,
              (idx) => Theme(
                data: ThemeData(
                  unselectedWidgetColor: appTheme[txt],
                ),
                child: CheckboxListTile(
                  checkColor: appTheme[txt],
                  activeColor: appTheme[button],
                  controlAffinity: ListTileControlAffinity.leading,
                  value: dc.moviecbx[idx],
                  onChanged: (val) => onChanged(idx, val, dc),
                  title: Text(
                    movieGenres.keys.toList()[idx],
                    style: GoogleFonts.abel().copyWith(
                      color:
                          (dc.moviecbx[idx]) ? appTheme[button] : appTheme[txt],
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
    if (val)
      dc.addGenre(idx, 'movie');
    else
      dc.removeGenre(idx, 'movie');
  }
}
