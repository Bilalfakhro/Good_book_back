
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:good_book_back/card_pages/data/app_state.dart';
import 'package:good_book_back/card_pages/data/bookie.dart';
import 'package:good_book_back/card_pages/widgets/close_button.dart';
import '../styles.dart';

class SeasonCircle extends StatelessWidget {
  const SeasonCircle(this.season, this.isHarvestTime);

  /// Season to be displayed by this widget.
  final Season season;

  /// Whether or not [season] should be presented as a valid harvest season.
  final bool isHarvestTime;

  String get _firstChars {
    return '${season.toString().substring(7, 8).toUpperCase()}'
        '${season.toString().substring(8, 9)}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isHarvestTime
              ? Styles.seasonColors[season]
              : Styles.transparentColor,
          borderRadius: BorderRadius.circular(25.0),
          border: Styles.seasonBorder,
        ),
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: Center(
            child: Text(
              _firstChars,
              style: isHarvestTime
                  ? Styles.activeSeasonText
                  : Styles.inactiveSeasonText,
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final int id;

  DetailsScreen(this.id);

  Widget _createHeader(BuildContext context, AppState model) {
    final bookie = model.getBookies(id);

    return SizedBox(
      height: 300.0,
      child: Stack(
        children: [
          Positioned(
            right: 0.0,
            left: 0.0,
            child: Hero(
              tag: bookie.id,
              child: Image.asset(
                bookie.imageAssetPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            right: 16.0,
            child: SafeArea(
              child: CloseButton(() {
                Navigator.of(context).pop();
              }),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: Styles.shadowGradient,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 16.0),
                child: Text(
                  bookie.name,
                  style: Styles.subheadText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDetails(AppState model) {
    final bookie = model.getBookies(id);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            children: Season.values.map((s) {
              return SeasonCircle(s, bookie.seasons.contains(s));
            }).toList(),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoSwitch(
                value: bookie.isFavorite,
                onChanged: (value) {
                  model.setFavorite(id, value);
                },
              ),
              SizedBox(width: 8.0),
              Text('Save to Shelf'),
            ],
          ),
          SizedBox(height: 24.0),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              veggieCategoryNames[bookie.category].toUpperCase(),
              style: Styles.minorText,
            ),
          ),
          SizedBox(width: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(bookie.shortDescription),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<AppState>(context, rebuildOnChange: true);

    return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _createHeader(context, model),
          _createDetails(model),
        ],
      ),
    );
  }
}
