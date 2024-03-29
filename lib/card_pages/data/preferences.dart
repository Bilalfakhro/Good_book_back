import 'dart:async';
import 'bookie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';


/// A model class that mirrors the options in [SettingsScreen] and stores data
/// in shared preferences.
class Preferences extends Model {
  // Keys to use with shared preferences.
  static const _caloriesKey = 'calories';
  static const _preferredCategoriesKey = 'preferredCategories';

  // Indicates whether a call to [_loadFromSharedPrefs] is in progress;
  Future<void> _loading;

  int _desiredCalories = 2000;

  Set<BookieCategory> _preferredCategories = Set<BookieCategory>();

  Future<int> get desiredCalories async {
    await _loading;
    return _desiredCalories;
  }

  Future<Set<BookieCategory>> get preferredCategories async {
    await _loading;
    return Set.from(_preferredCategories);
  }

  void addPreferredCategory(BookieCategory category) async {
    _preferredCategories.add(category);
    await _saveToSharedPrefs();
    notifyListeners();
  }

  void removePreferredCategory(BookieCategory category) async {
    _preferredCategories.remove(category);
    await _saveToSharedPrefs();
    notifyListeners();
  }

  void setDesiredCalories(int calories) async {
    _desiredCalories = calories;
    await _saveToSharedPrefs();
    notifyListeners();
  }

  void load() {
    _loading = _loadFromSharedPrefs();
  }

  Future<void> _saveToSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_caloriesKey, _desiredCalories);

    // Store preferred categories as a comma-separated string containing their
    // indices.
    await prefs.setString(_preferredCategoriesKey,
        _preferredCategories.map((c) => c.index.toString()).join(','));
  }

  Future<void> _loadFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _desiredCalories = prefs.getInt(_caloriesKey) ?? 2000;
    _preferredCategories.clear();
    final names = prefs.getString(_preferredCategoriesKey);

    if (names != null) {
      for (final name in names.split(',')) {
        final index = int.tryParse(name) ?? -1;
        if (BookieCategory.values[index] != null) {
          _preferredCategories.add(BookieCategory.values[index]);
        }
      }
    }

    notifyListeners();
  }
}
