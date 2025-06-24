import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _username ='';

  // Get userName
  String get username => _username;

  // Login
  void login(String name) {
    _username = name;
    notifyListeners();
  }

  // Logout
  void logout() {
    //_username = null;
    _username = '';
    notifyListeners();
  }

  bool get isLoggedIn => _username != null;
}
