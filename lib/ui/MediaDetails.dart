import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/Constants.dart';
import 'package:movie_app/Controllers/MediaController.dart';
import 'package:movie_app/Templates/CreditSelectorSection.dart';
import 'package:movie_app/Templates/Images.dart';
import 'package:movie_app/Templates/CustomFlexibleSpaceBar.dart';
import 'package:movie_app/Templates/MediaSelectorSection.dart';
import 'package:movie_app/Templates/Videos.dart';
import 'package:movie_app/ui/Home.dart';
import 'package:provider/provider.dart';
import '../Helper.dart';
import 'package:readmore/readmore.dart';

class MediaDetails extends StatelessWidget {
  final String id, title, mediaType;
  MediaDetails({
    @required this.id,
    @required this.title,
    @required this.mediaType,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MediaController(),
      child: Scaffold(
        backgroundColor: Kplatte1[1],
        body: SafeArea(
          child: Consumer<MediaController>(
            builder: (_, data, __) {
              if (data.newId(mediaType, id)) {
                data.downloadInfo(mediaType, id);
                return loading;
              }
              return buildBody(data, context, mediaType);
            },
          ),
        ),
      ),
    );
  }

  Widget buildBody(
      MediaController data, BuildContext context, String mediaType) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, value) {
        return [
          SliverAppBar(
            backgroundColor: Kplatte1[1],
            pinned: true,
            actions: [
              IconButton(
                onPressed: () => navigatePushOnly(context, Home()),
                icon: Icon(Icons.home),
              ),
            ],
            brightness: Brightness.dark,
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) => CustomFlexibleSpaceBar(
                parentcontext: context,
                constraints: constraints,
                title: data?.getTitle(mediaType),
                backdropUrl: data?.getBackdropUrl(mediaType) ?? 'null',
                posterUrl: data?.getPosterUrl(mediaType) ?? 'null',
                rating: data?.getVoteAvg(mediaType) ?? 'null',
                voteCount: data?.getVoteCount(mediaType) ?? 'null',
                line1: data?.getGenres(mediaType) ?? '',
                line2: data?.getReleaseDate(mediaType) ?? 'null',
                line3: (mediaType == 'movie')
                    ? data?.getRuntime() ?? 'null'
                    : data.show?.status ?? 'null',
                trailerUrl: data.getTrailerUrl(mediaType),
              ),
            ),
          ),
        ];
      },
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
            child: ReadMoreText(
              data.getOverview(mediaType),
              trimLines: 4,
              trimMode: TrimMode.Length,
              trimCollapsedText: 'More',
              trimExpandedText: 'Less',
              moreStyle: GoogleFonts.abel().copyWith(
                color: Colors.cyan,
                fontSize: 13,
              ),
              lessStyle: GoogleFonts.abel().copyWith(
                color: Colors.cyan,
                fontSize: 13,
              ),
              style: GoogleFonts.abel().copyWith(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          CreditSelectorSection(
            sectionTitle: 'Cast',
            list: data.getCast,
            mediaType: mediaType,
            loadCredit: data.downloadCredits,
          ),
          CreditSelectorSection(
            sectionTitle: 'Crew',
            list: data.getCrew,
            mediaType: mediaType,
            loadCredit: data.downloadCredits,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.5,
            child: Images(data: data, mediaType: mediaType),
          ),
          SizedBox(height: 32),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.55,
            child: Videos(
              data: data,
              mediaType: mediaType,
            ),
          ),
          MediaSelectorSection(
            sectionTitle: 'Similar',
            mediaType: mediaType,
            watch: data.getSimilar,
            loadNext: data.downloadSimilar,
            watchx: data.getTotalSimilar,
          ),
          SizedBox(height: 16),
          MediaSelectorSection(
            sectionTitle: 'Recommended',
            mediaType: mediaType,
            watch: data.getRecommendatoins,
            loadNext: data.downloadRecommendations,
            watchx: data.getTotalRecommendations,
          ),
        ],
      ),
    );
  }
}

//? details
//? credits
//? images
//? videos
//? similar
//? recommendations
