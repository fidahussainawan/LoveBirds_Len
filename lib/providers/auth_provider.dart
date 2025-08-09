import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isSignedIn = false;
  String _userName = '';
  String _userEmail = '';

  bool get isSignedIn => _isSignedIn;
  String get userName => _userName;
  String get userEmail => _userEmail;

  AuthProvider() {
    _loadUserData();
  }

  Future<void> signIn(String name, String email) async {
    _isSignedIn = true;
    _userName = name;
    _userEmail = email;

    await _saveUserData();
    notifyListeners();
  }

  Future<void> signOut() async {
    _isSignedIn = false;
    _userName = '';
    _userEmail = '';

    await _clearUserData();
    notifyListeners();
  }

  Future<void> createAccount(String name, String email) async {
    await signIn(name, email);
  }

  Future<void> _loadUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isSignedIn = prefs.getBool('isSignedIn') ?? false;
      _userName = prefs.getString('userName') ?? '';
      _userEmail = prefs.getString('userEmail') ?? '';
      notifyListeners();
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _saveUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isSignedIn', _isSignedIn);
      await prefs.setString('userName', _userName);
      await prefs.setString('userEmail', _userEmail);
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isSignedIn');
      await prefs.remove('userName');
      await prefs.remove('userEmail');
    } catch (e) {
      // Handle error silently
    }
  }
}