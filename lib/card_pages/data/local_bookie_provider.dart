import 'package:flutter/cupertino.dart';
import 'bookie.dart';

class LocalBookieProvider {
  static List<Bookie> bookies = [
    Bookie(
      id: 1,
      name: 'Apples',
      imageAssetPath: 'assets/images/apple.jpg',
      category: BookieCategory.fruit,
      shortDescription: 'Green or red, they\'re generally round and tasty.',
      accentColor: Color(0x40de8c66),
      seasons: [Season.winter, Season.spring, Season.summer, Season.autumn],
    ),
    Bookie(
      id: 2,
      name: 'Artichokes',
      imageAssetPath: 'assets/images/artichoke.jpg',
      category: BookieCategory.flower,
      shortDescription: 'The armadillo of vegetables.',
      accentColor: Color(0x408ea26d),
      seasons: [Season.autumn, Season.spring],
    ),
    Bookie(
      id: 3,
      name: 'Asparagus',
      imageAssetPath: 'assets/images/asparagus.jpg',
      category: BookieCategory.fern,
      shortDescription: 'It\'s been used a food and medicine for millenia.',
      accentColor: Color(0x408cb437),
      seasons: [Season.spring],
    ),
    Bookie(
      id: 4,
      name: 'Avocado',
      imageAssetPath: 'assets/images/avocado.jpg',
      category: BookieCategory.stealthFruit,
      shortDescription: 'One of the oiliest, richest vegetables money can buy.',
      accentColor: Color(0x40b0ba59),
      seasons: [Season.winter, Season.spring, Season.summer],
    ),
    Bookie(
      id: 5,
      name: 'Blackberries',
      imageAssetPath: 'assets/images/blackberry.jpg',
      category: BookieCategory.berry,
      shortDescription: 'Find them on backroads and fences in the Northwest.',
      accentColor: Color(0x409d5adb),
      seasons: [Season.summer],
    ),
    Bookie(
      id: 6,
      name: 'Canteloupe',
      imageAssetPath: 'assets/images/canteloupe.jpg',
      category: BookieCategory.melon,
      shortDescription: 'A fruit so tasty there\'s a utensil just for it.',
      accentColor: Color(0x40f6bd56),
      seasons: [Season.summer],
    ),
    Bookie(
      id: 7,
      name: 'Cauliflower',
      imageAssetPath: 'assets/images/cauliflower.jpg',
      category: BookieCategory.cruciferous,
      shortDescription: 'Looks like white broccoli and explodes when cut.',
      accentColor: Color(0x40c891a8),
      seasons: [Season.autumn],
    ),
    Bookie(
      id: 8,
      name: 'Endive',
      imageAssetPath: 'assets/images/endive.jpg',
      category: BookieCategory.gourd,
      shortDescription: 'It\'s basically the veal of lettuce.',
      accentColor: Color(0x40c5be53),
      seasons: [Season.winter, Season.autumn, Season.spring],
    ),
    Bookie(
      id: 9,
      name: 'Figs',
      imageAssetPath: 'assets/images/fig.jpg',
      category: BookieCategory.fruit,
      shortDescription: 'Delicious when sliced and wrapped in prosciutto.',
      accentColor: Color(0x40aa6d7c),
      seasons: [Season.autumn, Season.summer],
    ),
    Bookie(
      id: 10,
      name: 'Grapes',
      imageAssetPath: 'assets/images/grape.jpg',
      category: BookieCategory.berry,
      shortDescription: 'Couldn\'t have wine without them.',
      accentColor: Color(0x40ac708a),
      seasons: [Season.autumn],
    ),
    Bookie(
      id: 11,
      name: 'Green Pepper',
      imageAssetPath: 'assets/images/green_bell_pepper.jpg',
      category: BookieCategory.stealthFruit,
      shortDescription: 'Pleasantly bitter, like a sad movie.',
      accentColor: Color(0x408eb332),
      seasons: [Season.summer],
    ),
    Bookie(
      id: 12,
      name: 'Habanero',
      imageAssetPath: 'assets/images/habanero.jpg',
      category: BookieCategory.stealthFruit,
      shortDescription: 'Delicious... in extremely small quantities.',
      accentColor: Color(0x40ff7a01),
      seasons: [Season.autumn, Season.summer],
    ),
    Bookie(
      id: 13,
      name: 'Kale',
      imageAssetPath: 'assets/images/kale.jpg',
      category: BookieCategory.cruciferous,
      shortDescription: 'The meanest vegetable. Does not want to be eaten.',
      accentColor: Color(0x40a86bd8),
      seasons: [Season.winter, Season.autumn],
    ),
    Bookie(
      id: 14,
      name: 'Kiwi',
      imageAssetPath: 'assets/images/kiwi.jpg',
      category: BookieCategory.berry,
      shortDescription: 'Also known as Chinese gooseberry.',
      accentColor: Color(0x40b47b37),
      seasons: [Season.summer],
    ),
    Bookie(
      id: 15,
      name: 'Lemons',
      imageAssetPath: 'assets/images/lemon.jpg',
      category: BookieCategory.citrus,
      shortDescription: 'Similar to limes, only yellow.',
      accentColor: Color(0x40e2a500),
      seasons: [Season.winter],
    ),
    Bookie(
      id: 16,
      name: 'Limes',
      imageAssetPath: 'assets/images/lime.jpg',
      category: BookieCategory.citrus,
      shortDescription: 'Couldn\'t have ceviche and margaritas without them.',
      accentColor: Color(0x4089b733),
      seasons: [Season.winter],
    ),
    Bookie(
      id: 17,
      name: 'Mangos',
      imageAssetPath: 'assets/images/mango.jpg',
      category: BookieCategory.tropical,
      shortDescription: 'A fun orange fruit popular with smoothie enthusiasts.',
      accentColor: Color(0x40fcc93c),
      seasons: [Season.summer, Season.autumn],
    ),
    Bookie(
      id: 18,
      name: 'Mushrooms',
      imageAssetPath: 'assets/images/mushroom.jpg',
      category: BookieCategory.fungus,
      shortDescription: 'They\'re not truffles, but they\'re still tasty.',
      accentColor: Color(0x40ba754b),
      seasons: [Season.spring, Season.autumn],
    ),
    Bookie(
      id: 19,
      name: 'Nectarines',
      imageAssetPath: 'assets/images/nectarine.jpg',
      category: BookieCategory.stoneFruit,
      shortDescription: 'Tiny, bald peaches.',
      accentColor: Color(0x40e45b3b),
      seasons: [Season.summer],
    ),
    Bookie(
      id: 20,
      name: 'Persimmons',
      imageAssetPath: 'assets/images/persimmon.jpg',
      category: BookieCategory.fruit,
      shortDescription: 'It\'s like a plum and an apple had a baby together.',
      accentColor: Color(0x40979852),
      seasons: [Season.winter, Season.autumn],
    ),
    Bookie(
      id: 21,
      name: 'Plums',
      imageAssetPath: 'assets/images/plum.jpg',
      category: BookieCategory.stoneFruit,
      shortDescription: 'Popular in fruit salads and children\'s tales.',
      accentColor: Color(0x40e48b47),
      seasons: [Season.summer],
    ),
    Bookie(
      id: 22,
      name: 'Potatoes',
      imageAssetPath: 'assets/images/potato.jpg',
      category: BookieCategory.tuber,
      shortDescription: 'King of starches and giver of french fries.',
      accentColor: Color(0x40c65c63),
      seasons: [Season.winter, Season.autumn],
    ),
    Bookie(
      id: 23,
      name: 'Radicchio',
      imageAssetPath: 'assets/images/radicchio.jpg',
      category: BookieCategory.leafy,
      shortDescription: 'It\'s that bitter taste in the salad you\'re eating.',
      accentColor: Color(0x40d75875),
      seasons: [Season.autumn, Season.spring],
    ),
    Bookie(
      id: 24,
      name: 'Radishes',
      imageAssetPath: 'assets/images/radish.jpg',
      category: BookieCategory.root,
      shortDescription: 'Try roasting them in addition to slicing them up raw.',
      accentColor: Color(0x40819e4e),
      seasons: [Season.spring, Season.autumn],
    ),
    Bookie(
      id: 25,
      name: 'Squash',
      imageAssetPath: 'assets/images/squash.jpg',
      category: BookieCategory.gourd,
      shortDescription: 'Just slather them in butter and pop \'em in the oven.',
      accentColor: Color(0x40dbb721),
      seasons: [Season.winter, Season.autumn],
    ),
    Bookie(
      id: 26,
      name: 'Strawberries',
      imageAssetPath: 'assets/images/strawberry.jpg',
      category: BookieCategory.berry,
      shortDescription:
          'A delicious fruit that keeps its seeds on the outside.',
      accentColor: Color(0x40f06a44),
      seasons: [Season.spring, Season.summer],
    ),
    Bookie(
      id: 27,
      name: 'Tangelo',
      imageAssetPath: 'assets/images/tangelo.jpg',
      category: BookieCategory.citrus,
      shortDescription: 'No one\'s sure what they are or where they came from.',
      accentColor: Color(0x40f88c06),
      seasons: [Season.winter, Season.autumn],
    ),
    Bookie(
      id: 28,
      name: 'Tomatoes',
      imageAssetPath: 'assets/images/tomato.jpg',
      category: BookieCategory.stealthFruit,
      shortDescription: 'A new world food with old world tradition.',
      accentColor: Color(0x40ea3628),
      seasons: [Season.summer],
    ),
    Bookie(
      id: 29,
      name: 'Watermelon',
      imageAssetPath: 'assets/images/watermelon.jpg',
      category: BookieCategory.melon,
      shortDescription: 'Everyone\'s favorite closing act at the picnic.',
      accentColor: Color(0x40fa8c75),
      seasons: [Season.summer],
    ),
    Bookie(
      id: 30,
      name: 'Orange Bell Pepper',
      imageAssetPath: 'assets/images/orange_bell_pepper.jpg',
      category: BookieCategory.stealthFruit,
      shortDescription: 'Like green pepper, but nicer.',
      accentColor: Color(0x40fd8e00),
      seasons: [Season.summer],
    ),
  ];
}
