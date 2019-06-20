import 'bookie.dart';
import 'local_bookie_provider.dart';
import 'package:scoped_model/scoped_model.dart';

class AppState extends Model {
  List<Bookie> _bookies;

  AppState() : _bookies = LocalBookieProvider.bookies;

  List<Bookie> get allVeggies => List<Bookie>.from(_bookies);

  Bookie getBookies(int id) => _bookies.singleWhere((v) => v.id == id);

  List<Bookie> get availableVeggies {
    Season currentSeason = _getSeasonForDate(DateTime.now());
    return _bookies.where((v) => v.seasons.contains(currentSeason)).toList();
  }
  
  List<Bookie> get favoriteBookies =>
      _bookies.where((v) => v.isFavorite).toList();

  List<Bookie> searchVeggies(String terms) => _bookies
      .where((v) => v.name.toLowerCase().contains(terms.toLowerCase()))
      .toList();

  void setFavorite(int id, bool isFavorite) {
    Bookie veggie = getBookies(id);
    veggie.isFavorite = isFavorite;
    notifyListeners();
  }

  static Season _getSeasonForDate(DateTime date) {
    // Technically the start and end dates of seasons can vary by a day or so,
    // but this is close enough for produce.
    switch (date.month) {
      case 1:
        return Season.winter;
      case 2:
        return Season.winter;
      case 3:
        return date.day < 21 ? Season.winter : Season.spring;
      case 4:
        return Season.spring;
      case 5:
        return Season.spring;
      case 6:
        return date.day < 21 ? Season.spring : Season.summer;
      case 7:
        return Season.summer;
      case 8:
        return Season.summer;
      case 9:
        return date.day < 22 ? Season.autumn : Season.winter;
      case 10:
        return Season.autumn;
      case 11:
        return Season.autumn;
      case 12:
        return date.day < 22 ? Season.autumn : Season.winter;
      default:
        throw ArgumentError('Can\'t return a season for month #${date.month}.');
    }
  }
}
