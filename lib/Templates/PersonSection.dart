import 'package:flutter/material.dart';
import 'package:movie_app/Models/Person..dart';
import 'PersonCard.dart';

class PersonSection extends StatelessWidget {
  final List<Person> media;
  const PersonSection({Key key, @required this.media}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: media.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: PersonCard(person: media[index]),
        ),
      ),
    );
  }
}
