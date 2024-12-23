/// Model: Skill
class Skill {
  final String skill;
  final String level;

  Skill({
    required this.skill,
    required this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'skill': skill,
      'level': level,
    };
  }

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      skill: map['skill'],
      level: map['level'],
    );
  }
}
