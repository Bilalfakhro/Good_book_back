import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

enum BookieCategory {
  allium,
  berry,
  citrus,
  cruciferous,
  fern,
  flower,
  fruit,
  fungus,
  gourd,
  leafy,
  legume,
  melon,
  root,
  stealthFruit,
  stoneFruit,
  tropical,
  tuber,
  vegetable,
}

enum Season {
  winter,
  spring,
  summer,
  autumn,
}

const Map<BookieCategory, String> veggieCategoryNames = {
  BookieCategory.allium: 'Allium',
  BookieCategory.berry: 'Berry',
  BookieCategory.citrus: 'Citrus',
  BookieCategory.cruciferous: 'Cruciferous',
  BookieCategory.fern: 'Technically a fern',
  BookieCategory.flower: 'Flower',
  BookieCategory.fruit: 'Fruit',
  BookieCategory.fungus: 'Fungus',
  BookieCategory.gourd: 'Gourd',
  BookieCategory.leafy: 'Leafy',
  BookieCategory.legume: 'Legume',
  BookieCategory.melon: 'Melon',
  BookieCategory.root: 'Root vegetable',
  BookieCategory.stealthFruit: 'Stealth fruit',
  BookieCategory.stoneFruit: 'Stone fruit',
  BookieCategory.tropical: 'Tropical',
  BookieCategory.tuber: 'Tuber',
  BookieCategory.vegetable: 'Vegetable',
};

class Bookie {
  Bookie({
    @required this.id,
    @required this.name,
    @required this.imageAssetPath,
    @required this.category,
    @required this.shortDescription,
    @required this.accentColor,
    @required this.seasons,
    this.isFavorite = false,
  });

  final int id;

  final String name;

  /// Each veggie has an associated image asset that's used as a background
  /// image and icon.
  final String imageAssetPath;

  final BookieCategory category;

  final String shortDescription;

  /// A color value to use when constructing UI elements to match the image
  /// found at [imageAssetPath].
  final Color accentColor;

  /// Seasons during which a veggie is harvested.
  final List<Season> seasons;

  /// Whether or not the veggie has been saved to the user's garden (i.e. marked
  /// as a favorite).
  bool isFavorite;

  String get categoryName => veggieCategoryNames[category];
}
