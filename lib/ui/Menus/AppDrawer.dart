import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Controllers/ThemeController.dart';
import 'package:movie_app/Helper.dart';
import 'package:movie_app/ui/Screens/HomeScreen.dart';
import 'package:movie_app/ui/Screens/SearchScreen.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';
import '../../Constants.dart';

class AppDrawer extends StatefulWidget {
  final bool state;
  final int idx;
  AppDrawer({Key key, this.state, this.idx}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int idx = 0;
  @override
  void initState() {
    if (widget.idx != null) idx = widget.idx;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tc = context.watch<ThemeController>();
    TextStyle style = GoogleFonts.abel().copyWith(
      color: appTheme[txt],
      fontSize: 20,
    );
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: appTheme[background],
        dividerColor: appTheme[subText],
      ),
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Text(
                      'Movie Box',
                      style: style.copyWith(
                        fontWeight: FontWeight.bold,
                        color: appTheme[txt],
                        fontSize: 22,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.03 + 2,
                    left: 0,
                    child: Text(
                      'Powered by',
                      style: style.copyWith(
                        fontSize: 12,
                        color: appTheme[subText],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    width: MediaQuery.of(context).size.width * 0.28,
                    height: MediaQuery.of(context).size.height * 0.03,
                    child: Image.asset(logo),
                  ),
                ],
              ),
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              selected: (idx == 0),
              selectedTileColor: appTheme[button],
              onTap: () {
                if (idx == 0) return;
                setState(() {
                  idx = 0;
                });
                Navigator.pop(context);
                navigatePush(context, Home());
              },
              title: Row(
                children: [
                  Icon(
                    Icons.home_rounded,
                    color: appTheme[txt],
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Home',
                    style: style,
                  ),
                ],
              ),
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              selected: (idx == 1),
              selectedTileColor: appTheme[button],
              onTap: () {
                if (idx == 1) return;
                setState(() {
                  idx = 1;
                });
                Navigator.pop(context);
                navigatePush(context, SearchScreen());
              },
              title: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    color: appTheme[txt],
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Search',
                    style: style,
                  ),
                ],
              ),
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              selected: (idx == 2),
              selectedTileColor: appTheme[button],
              tileColor: appTheme[background],
              onTap: () {
                if (idx == 2) return;
                setState(() {
                  idx = 2;
                });
                Navigator.pop(context);
              },
              title: Row(
                children: [
                  Icon(
                    Icons.widgets_rounded,
                    color: appTheme[txt],
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Genres',
                    style: style,
                  ),
                ],
              ),
            ),
            ListTile(
              tileColor: appTheme[background],
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.dark_mode_rounded,
                        color: appTheme[txt],
                        size: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Dark Mode',
                        style: style,
                      ),
                    ],
                  ),
                  SwitcherButton(
                    onColor: appTheme[button],
                    offColor: appTheme[subText],
                    value: widget.state,
                    size: 40,
                    onChange: (value) => tc.toggle(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
