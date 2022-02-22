import 'package:flutter/material.dart';
import 'package:tinder_app_clone/widget/buildBadge.dart';

class PositionCardProvider extends ChangeNotifier {
  var _position = SwipingDirection.none;

  getCardPosition() => _position;

  setCardPosition(SwipingDirection sw) {
    _position = sw;
    notifyListeners();
  }
}
