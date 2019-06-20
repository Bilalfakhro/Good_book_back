
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:good_book_back/card_pages/data/app_state.dart';
import 'package:good_book_back/card_pages/data/bookie.dart';
import 'package:good_book_back/card_pages/data/preferences.dart';
import 'package:good_book_back/card_pages/widgets/bookie_card.dart';
import '../styles.dart';

class ListScreen extends StatelessWidget {
  List<Widget> _generateVeggieRows(List<Bookie> bookies, Preferences prefs) {
    final cards = new List<Widget>();

    for (Bookie bookie in bookies) {
      cards.add(Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
        child: FutureBuilder<Set<BookieCategory>>(
            future: prefs.preferredCategories,
            builder: (context, snapshot) {
              final data = snapshot.data ?? Set<BookieCategory>();
              return BookieCard(bookie, data.contains(bookie.category));
            }),
      ));
    }

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
       
        final appState =
            ScopedModel.of<AppState>(context, rebuildOnChange: true);
        final prefs =
            ScopedModel.of<Preferences>(context, rebuildOnChange: true);

        final rows = <Widget>[];

        rows.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('In season today', style: Styles.headlineText),
              ],
            ),
          ),
        );

        rows.addAll(_generateVeggieRows(appState.availableVeggies, prefs));

        return DecoratedBox(
          decoration: BoxDecoration(color: Color(0xffffffff)),
          child: ListView(
            children: rows,
          ),
        );
      },
    );
  }
}
