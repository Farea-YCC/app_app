import 'dart:io';

import 'package:flutter/foundation.dart';

class PersonalInfoProvider with ChangeNotifier {
  // Private fields
  File? _profileImage;
  String _fullName = '';
  String _professionalTitle = '';
  String _address = '';
  String _phone = '';
  String _email = '';
  String _summary = '';

  // Getters
  File? get profileImage => _profileImage;
  String get fullName => _fullName;
  String get professionalTitle => _professionalTitle;
  String get address => _address;
  String get phone => _phone;
  String get email => _email;
  String get summary => _summary;

  // Setters with notifications
  void setProfileImage(File? image) {
    _profileImage = image;
    notifyListeners();
  }

  void setFullName(String name) {
    _fullName = name;
    notifyListeners();
  }

  void setProfessionalTitle(String title) {
    _professionalTitle = title;
    notifyListeners();
  }

  void setAddress(String address) {
    _address = address;
    notifyListeners();
  }

  void setPhone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setSummary(String summary) {
    _summary = summary;
    notifyListeners();
  }

  // Reset method to clear all fields
  void reset() {
    _profileImage = null;
    _fullName = '';
    _professionalTitle = '';
    _address = '';
    _phone = '';
    _email = '';
    _summary = '';
    notifyListeners();
  }
}
