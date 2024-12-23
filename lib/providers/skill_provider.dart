import 'package:flutter/foundation.dart';
import 'package:learning/models/skill.dart';

class SkillProvider with ChangeNotifier {
  final List<Skill> _skills = [];

  List<Skill> get skills => List.unmodifiable(_skills);

  void addSkill(Skill skill) {
    _skills.add(skill);
    notifyListeners();
  }

  void removeSkill(int index) {
    _skills.removeAt(index);
    notifyListeners();
  }

  void updateSkill(int index, Skill skill) {
    _skills[index] = skill;
    notifyListeners();
  }
}
