import 'package:flutter/material.dart';
import 'package:tinder_app_clone/models/user_detail.dart';

class ListLikedProvider extends ChangeNotifier {
  List<UserDetail> _listLiked = [];

  int count() => _listLiked.length;
  getListLikedProvider() => _listLiked;

  addUserToList(UserDetail userDetail) {
    _listLiked.add(userDetail);
    notifyListeners();
  }
}
