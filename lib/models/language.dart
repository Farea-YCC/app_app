// Language Model
class Language {
  final String language;
  final String proficiency;

  Language({
    required this.language,
    required this.proficiency,
  });

  Map<String, dynamic> toMap() {
    return {
      'language': language,
      'proficiency': proficiency,
    };
  }

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      language: map['language'],
      proficiency: map['proficiency'],
    );
  }
}
