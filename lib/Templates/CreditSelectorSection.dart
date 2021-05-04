import 'package:flutter/material.dart';
import 'package:movie_app/Controllers/MediaController.dart';
import 'package:provider/provider.dart';
import 'PersonSection.dart';

class CreditSelectorSection extends StatelessWidget {
  final String mediaType, sectionTitle, creditType;
  final Function loadCredit, list;
  const CreditSelectorSection({
    Key key,
    this.sectionTitle,
    this.creditType,
    this.mediaType,
    this.loadCredit,
    this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<MediaController, bool>(
        selector: (_, media) => media.getDownloadedCredits(mediaType),
        builder: (context, downloadedCredit, child) {
          if (!downloadedCredit) {
            loadCredit(mediaType);
            return Container(
              height: MediaQuery.of(context).size.height * 0.235,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return PersonSection(
            sectinoTitle: sectionTitle,
            media: list(mediaType),
            loadNext: loadCredit,
            hasData: downloadedCredit,
          );
        });
  }
}
