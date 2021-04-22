import 'package:flutter/material.dart';

import '../../Constants.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            Container(
              // color: c7,
              decoration: BoxDecoration(
                color: c7,
              ),
              child: ListTile(
                selectedTileColor: c3,
                title: Text('Movies'),
                onTap: () {
                  // Update the state of the app.
                  Navigator.pop(context);
                },
              ),
            ),
            ListTile(
              title: Text('Shows'),
              tileColor: c7,
              onTap: () {
                // Update the state of the app.
                // getData();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
