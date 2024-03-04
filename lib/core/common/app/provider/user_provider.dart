import 'package:flutter/material.dart';
import 'package:online_learning/features/auth/domain/entities/user.dart';

class UserProvider extends ChangeNotifier {
  MyUser? _user;
  MyUser? get user => _user;

  void initUser(MyUser? user) {
    if (_user != user) _user = user;
  }

  set user(MyUser? user) {
    if (user != _user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
