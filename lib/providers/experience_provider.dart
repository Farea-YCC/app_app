import 'package:flutter/foundation.dart';
import 'package:learning/models/experience.dart';

class ExperienceProvider with ChangeNotifier {
  final List<Experience> _experiences = [];

  List<Experience> get experiences => _experiences;

  void addExperience(Experience experience) {
    _experiences.add(experience);
    notifyListeners();
  }

  void removeExperience(int index) {
    _experiences.removeAt(index);
    notifyListeners();
  }

  void updateExperience(int index, Experience experience) {
    _experiences[index] = experience;
    notifyListeners();
  }
}
