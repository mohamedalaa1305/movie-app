import 'package:flutter/material.dart';

class CharactersVoiceScreen extends StatefulWidget {
  CharactersVoiceScreen({Key key}) : super(key: key);

  @override
  _CharactersVoiceScreenState createState() => _CharactersVoiceScreenState();
}

class _CharactersVoiceScreenState extends State<CharactersVoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
    );
  }
}
