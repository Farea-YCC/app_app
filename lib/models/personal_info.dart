///Models PersonalInfo
class PersonalInfo {
  final String fullName;
  final String title;
  final String email;
  final String phone;

  PersonalInfo({
    required this.fullName,
    required this.title,
    required this.email,
    required this.phone,
  });

  // تحويل الكائن إلى Map
  Map<String, dynamic> toMap() {
    return {
      'name': fullName,
      'title': 'title',
      'email': email,
      'phone': phone,
    };
  }

  // تحويل Map إلى كائن
  factory PersonalInfo.fromMap(Map<String, dynamic> map) {
    return PersonalInfo(
      fullName: map['name'],
      title: map['title'],
      email: map['email'],
      phone: map['phone'],
    );
  }
}
