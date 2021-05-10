import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Controllers/PersonController.dart';
import 'package:movie_app/Models/Media.dart';
import 'package:movie_app/Models/MediaImage.dart';
import 'package:movie_app/Templates/InfoRow.dart';
import 'package:movie_app/Templates/Loading.dart';
import 'package:movie_app/Templates/MediaCard.dart';
import 'package:movie_app/Templates/NothingToShowContainer.dart';
import 'package:movie_app/Templates/OverviewContainer.dart';
import 'package:movie_app/Templates/SectionHead.dart';
import 'package:movie_app/ui/Screens/ImagePlayerScreen.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../Constants.dart';
import '../../Helper.dart';
import 'HomeScreen.dart';

class PersonScreen extends StatelessWidget {
  final String id;
  const PersonScreen({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PersonController(),
      child: Scaffold(
        backgroundColor: appTheme[background],
        body: SafeArea(
          child: Consumer<PersonController>(
            builder: (_, data, __) {
              if (data.person == null || data.person.id != id) {
                data.downloadPerson(id);
                return loading;
              }
              return buildBody(data, context);
            },
          ),
        ),
      ),
    );
  }

  Widget buildBody(PersonController data, BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, value) {
        return [
          SliverAppBar(
            backgroundColor: appTheme[background],
            pinned: true,
            actionsIconTheme: IconThemeData(color: appTheme[txt]),
            iconTheme: IconThemeData(color: appTheme[txt]),
            actions: [
              IconButton(
                onPressed: () => navigatePushOnly(context, Home()),
                icon: Icon(Icons.home),
              ),
            ],
            brightness: Brightness.dark,
            expandedHeight: MediaQuery.of(context).size.height * 0.35,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) => FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  titlePadding:
                      EdgeInsets.only(left: 60, bottom: 16, right: 60, top: 16),
                  title: (constraints.biggest.height ==
                          MediaQuery.of(context).padding.top + kToolbarHeight)
                      ? Text(
                          data.person.name,
                          style: GoogleFonts.abel().copyWith(
                            color: appTheme[txt],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        left: 32,
                        top: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3 / 0.67,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: data.person.profileImgUrl,
                            placeholder: (_, __) =>
                                Image.asset(KPortraitPlaceHolder),
                            errorWidget: (_, __, ___) =>
                                Image.asset(KPortraitPlaceHolder),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                          left: 64 + MediaQuery.of(context).size.width * 0.3,
                          top: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width -
                              (64 + MediaQuery.of(context).size.width * 0.3) -
                              32,
                          height:
                              MediaQuery.of(context).size.width * 0.3 / 0.67,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    data.person.name,
                                    style: GoogleFonts.abel().copyWith(
                                      color: appTheme[txt],
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    InfoRow(
                                      icon: Icons.work_rounded,
                                      iconsize: 12,
                                      info: data.person.knownFor,
                                      mxlines: 2,
                                    ),
                                    InfoRow(
                                      icon: Icons.cake_rounded,
                                      iconsize: 12,
                                      info: (data.person.birthday == 'null')
                                          ? 'Unknown'
                                          : data.person.birthday,
                                      mxlines: 2,
                                    ),
                                    InfoRow(
                                      icon: Icons.location_on_rounded,
                                      iconsize: 12,
                                      info: (data.person.placeOfBirth == 'null')
                                          ? 'Unknown'
                                          : data.person.placeOfBirth,
                                      mxlines: 2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ],
                  )),
            ),
          ),
        ];
      },
      body: ListView(
        children: [
          SectionHead(
            title: 'Biography',
            child: OverviewContainer(
                overview: (data.person.biography != "")
                    ? data.person.biography
                    : 'No biography found for ${data.person.name}'),
          ),
          SectionHead(
            title: 'Images',
            child: Selector<PersonController, List<MediaImage>>(
              selector: (_, data) => data.person.images,
              builder: (context, images, child) {
                if (images == null) {
                  data.downloadImages();
                  return Loading(height: 180);
                }
                if (images.isEmpty) return NothingToShowContainer();
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.width * 0.25 / 0.67,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: data.person.profileImgUrl,
                              placeholder: (_, __) =>
                                  Image.asset(KPortraitPlaceHolder),
                              errorWidget: (_, __, ___) =>
                                  Image.asset(KPortraitPlaceHolder),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 4,
                          bottom: 4,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: appTheme[background],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              data.person.images.length.toString() + ' Images',
                              style: GoogleFonts.abel().copyWith(
                                color: appTheme[txt],
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                            child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () => navigatePush(
                              context,
                              ImagePlayerScreen(
                                images: images,
                                landscape: false,
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          SectionHead(
            title: 'Movies',
            child: Selector<PersonController, List<Tuple2<Media, String>>>(
              selector: (_, data) => data.person.movies,
              builder: (context, movies, child) {
                if (movies == null) {
                  data.downloadCredits();
                  return Loading(height: 180.0);
                }
                if (movies.isEmpty) return NothingToShowContainer();
                return Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(16),
                    children: List.generate(
                        movies.length,
                        (idx) => Container(
                              margin: EdgeInsets.only(right: 10),
                              child: MediaCard(
                                media: movies[idx].item1,
                                info: movies[idx].item2,
                              ),
                            )),
                  ),
                );
              },
            ),
          ),
          SectionHead(
            title: 'Tv Shows',
            child: Selector<PersonController, List<Tuple2<Media, String>>>(
              selector: (_, data) => data.person.shows,
              builder: (context, shows, child) {
                if (shows == null) {
                  data.downloadCredits();
                  return Loading(height: 180.0);
                }
                if (shows.isEmpty) return NothingToShowContainer();
                return Container(
                  height: MediaQuery.of(context).size.height * 0.28,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(16),
                    children: List.generate(
                        shows.length,
                        (idx) => Container(
                              margin: EdgeInsets.only(right: 10),
                              child: MediaCard(
                                media: shows[idx].item1,
                                info: shows[idx].item2,
                              ),
                            )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
