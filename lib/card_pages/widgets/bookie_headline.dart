import 'package:flutter/cupertino.dart';
import 'package:good_book_back/card_pages/data/bookie.dart';
import 'package:good_book_back/card_pages/pages/details.dart';

import '../styles.dart';


class BookieHeadline extends StatelessWidget {
  final Bookie bookie;

  const BookieHeadline(this.bookie);

  List<Widget> _buildSeasonDots(List<Season> seasons) {
    List<Widget> widgets = <Widget>[];

    for (Season season in seasons) {
      widgets.add(SizedBox(width: 4.0));
      widgets.add(
        Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
            color: Styles.seasonColors[season],
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => DetailsScreen(bookie.id),
            fullscreenDialog: true,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                bookie.imageAssetPath,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Text(bookie.name, style: Styles.headlineName),
                  ]..addAll(_buildSeasonDots(bookie.seasons)),
                ),
                Text(bookie.shortDescription,
                    style: Styles.headlineDescription),
              ],
            ),
          )
        ],
      ),
    );
  }
}
