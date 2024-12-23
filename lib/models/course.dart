class Course {
  final String name;
  final String institution;

  Course({required this.name, required this.institution});

  Map<String, dynamic> toJson() => {
        'name': name,
        'institution': institution,
      };

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      name: json['name'],
      institution: json['institution'],
    );
  }
}
