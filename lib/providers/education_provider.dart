import 'package:flutter/foundation.dart';
import 'package:learning/models/education.dart';

class EducationProvider with ChangeNotifier {
  final List<Education> _educations = [];
  List<Education> get educations => _educations;
  void addEducation(Education education) {
    _educations.add(education);
    notifyListeners();
  }

  void removeEducation(int index) {
    _educations.removeAt(index);
    notifyListeners();
  }

  void updateEducation(int index, Education education) {
    _educations[index] = education;
    notifyListeners();
  }
}
