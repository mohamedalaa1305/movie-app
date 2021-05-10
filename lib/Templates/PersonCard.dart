import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Helper.dart';
import 'package:movie_app/Models/Person..dart';
import 'package:movie_app/ui/Screens/PersonScreen.dart';

class PersonCard extends StatelessWidget {
  final Person person;
  const PersonCard({@required this.person});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.21,
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: (MediaQuery.of(context).size.width * 0.2),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(72),
                    child: CachedNetworkImage(
                      imageUrl: person.profileImgUrl,
                      placeholder: (_, __) => Image.asset(KProfilePlaceHolder),
                      errorWidget: (_, __, ___) =>
                          Image.asset(KProfilePlaceHolder),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(72),
                      onTap: () {
                        navigatePush(context, PersonScreen(id: person.id));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              person.name,
              style: GoogleFonts.abel().copyWith(
                color: appTheme[txt],
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              (person.character.isEmpty) ? person.job : person.character,
              style: GoogleFonts.abel().copyWith(
                color: appTheme[subText],
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
