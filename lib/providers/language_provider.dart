import 'package:flutter/foundation.dart';
import 'package:learning/models/language.dart';

class LanguageProvider with ChangeNotifier {
  final List<Language> _languages = [];

  List<Language> get languages => _languages;
  void addLanguage(Language language) {
    _languages.add(language);
    notifyListeners();
  }

  void removeLanguage(int index) {
    _languages.removeAt(index);
    notifyListeners();
  }

  void updateLanguage(int index, Language language) {
    _languages[index] = language;
    notifyListeners();
  }
}
