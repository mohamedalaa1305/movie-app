import 'package:flutter/material.dart';
import 'package:movie_app/Models/Season.dart';
import 'package:movie_app/Templates/SeasonCard.dart';

class SeasonsSection extends StatelessWidget {
  final List<Season> seasons;
  final show;
  const SeasonsSection({
    Key key,
    @required this.seasons,
    this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: ListView.builder(
        itemCount: seasons.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.only(right: 8),
          child: SeasonCard(season: seasons[index], show: show),
        ),
      ),
    );
  }
}
