import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:pcstore/services/auth_service.dart';


class UserProvider with ChangeNotifier {
  Map<String, dynamic> _user = {};
  bool _isLoggedIn = false;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final AuthService _authService = AuthService();

  Map<String, dynamic> get user => _user;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> setUser(Map<String, dynamic> userData) async {
    _user = userData;
    _isLoggedIn = true;
    notifyListeners();
    await _saveUserData(userData);
    print('User data set: $_user'); // Debug log
  }

  Future<void> logout() async {
    _user = {};
    _isLoggedIn = false;
    notifyListeners();
    await _clearUserData();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('user_data');
    if (userDataString != null) {
      _user = json.decode(userDataString);
      _isLoggedIn = true;
      notifyListeners();
      print('Loaded user data: $_user'); // Debug log
      await refreshUserDetails();
    }
  }

  Future<void> refreshUserDetails() async {
    if (_user.containsKey('_id') && _user.containsKey('token')) {
      final userId = _user['_id'];
      final token = _user['token'];
      print('Refreshing user details for ID: $userId'); // Debug log
      final userDetails = await _authService.getUserDetails(userId, token);
      if (!userDetails.containsKey('error')) {
        _user = {..._user, ...userDetails};
        await _saveUserData(_user);
        notifyListeners();
        print('Updated user details: $_user'); // Debug log
      } else {
        print(
            'Error refreshing user details: ${userDetails['error']}'); // Debug log
      }
    } else {
      print(
          'Unable to refresh user details: missing _id or token'); // Debug log
    }
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', json.encode(userData));
    await _storage.write(key: 'token', value: userData['token']);
    print('Saved user data: $userData'); // Debug log
  }

  Future<void> _clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
    await _storage.delete(key: 'token');
    print('Cleared user data'); // Debug log
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }
}