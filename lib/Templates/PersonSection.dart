import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Models/Person..dart';
import 'PersonCard.dart';

class PersonSection extends StatelessWidget {
  final sectinoTitle, hasData;
  final List<Person> media;
  final Function loadNext;
  const PersonSection(
      {Key key,
      this.sectinoTitle,
      @required this.media,
      this.loadNext,
      this.hasData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              sectinoTitle,
              textAlign: TextAlign.start,
              style: kSectionTitleTextStyle,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.205,
            child: buildBody(hasData),
          ),
        ],
      ),
    );
  }

  Widget buildBody(hasData) {
    if (media.isEmpty)
      return Center(
        child: Text(
          'No Thing To Show',
          style: GoogleFonts.abel().copyWith(
            color: Colors.white54,
            fontSize: 24,
          ),
        ),
      );
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: media.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: PersonCard(person: media[index]),
      ),
    );
  }
}
