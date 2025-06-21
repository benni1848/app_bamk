import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _username;

  String? get username => _username;

  void login(String name) {
    _username = name;
    notifyListeners();
  }

  void logout() {
    _username = null;
    notifyListeners();
  }

  bool get isLoggedIn => _username != null;
}
