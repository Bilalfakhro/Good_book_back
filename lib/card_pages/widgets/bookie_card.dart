import 'package:flutter/cupertino.dart';
import 'package:good_book_back/card_pages/data/bookie.dart';
import 'package:good_book_back/card_pages/pages/details.dart';
import '../styles.dart';

//Book Card
class BookieCard extends StatelessWidget {
  BookieCard(this.bookie, this.isPreferredCategory);

  /// Veggie to be displayed by the card.
  final Bookie bookie;

  /// Whether [bookie] falls into one of user's preferred [BookieCategory]s
  final bool isPreferredCategory;

  List<Widget> _buildStackChildren() {
    final widgets = <Widget>[];

    widgets.add(Hero(
      tag: bookie.id,
      child: Image.asset(
        bookie.imageAssetPath,
        fit: BoxFit.cover,
      ),
    ));

    widgets.add(Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bookie.accentColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                bookie.name,
                style: Styles.cardTitleText,
              ),
              Text(
                bookie.shortDescription,
                style: Styles.cardDescriptionText,
              ),
            ],
          ),
        ),
      ),
    ));

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => DetailsScreen(bookie.id),
          fullscreenDialog: true,
        ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: _buildStackChildren(),
        ),
      ),
    );
  }
}
