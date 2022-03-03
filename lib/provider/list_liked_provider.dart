import 'package:flutter/material.dart';
import 'package:tinder_app_clone/models/user_detail.dart';

class ListLikedProvider extends ChangeNotifier {
  List<FullUserInfo> _listLiked = [];

  int count() => _listLiked.length;
  getListLikedProvider() => _listLiked;

  addUserToList(FullUserInfo userDetail) {
    _listLiked.add(userDetail);
    notifyListeners();
  }
}
