///Models Experience
class Experience {
  final String title;
  final String company;
  final String dates;
  final String description;

  Experience({
    required this.title,
    required this.company,
    required this.dates,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'company': company,
      'dates': dates,
      'description': description,
    };
  }

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      title: map['title'],
      company: map['company'],
      dates: map['dates'],
      description: map['description'],
    );
  }
}
