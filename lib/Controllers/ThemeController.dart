import 'package:flutter/cupertino.dart';
import 'package:movie_app/Constants.dart';

class ThemeController with ChangeNotifier {
  bool state = true;
  void toggle() {
    print("toggling theme");
    appTheme = (appTheme == DarkTheme) ? LightTheme : DarkTheme;
    logo = (logo == logodark) ? logolight : logodark;
    state = !state;
    notifyListeners();
    print("listeners notified");
  }
}
