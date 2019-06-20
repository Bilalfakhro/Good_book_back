
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:good_book_back/card_pages/data/app_state.dart';
import 'package:good_book_back/card_pages/data/bookie.dart';
import 'package:good_book_back/card_pages/widgets/bookie_headline.dart';
import 'package:scoped_model/scoped_model.dart';
import '../styles.dart';

class FavoritesScreen extends StatelessWidget {
  /// Builds the "content" of the favorites screen: either a list of favorite
  /// veggies or a note that says the user hasn't favorited any yet.
  Widget _buildTabViewBody(BuildContext context) {
    final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);

    if (model.favoriteBookies.length == 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Text(
          'You haven\'t added any favorite bookies to your shelf yet.',
          style: Styles.headlineDescription,
        ),
      );
    }

    final rows = <Widget>[
      SizedBox(height: 24.0),
    ];

    for (Bookie bookie in model.favoriteBookies) {
      rows.add(
        Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 24.0),
          child: BookieHeadline(bookie),
        ),
      );
    }

    return ListView(
      children: rows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Styles.scaffoldBackground,
          ),
          child: Center(
            child: _buildTabViewBody(context),
          ),
        );
      },
    );
  }
}
