class Education {
  final String degree;
  final String major;
  final String university;
  final String graduationDate;

  Education({
    required this.degree,
    required this.major,
    required this.university,
    required this.graduationDate,
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'degree': degree,
      'major': major,
      'university': university,
      'graduationDate': graduationDate,
    };
  }

  // Create from Map
  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      degree: map['degree'],
      major: map['major'],
      university: map['university'],
      graduationDate: map['graduationDate'],
    );
  }
}
