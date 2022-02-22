import 'package:flutter/material.dart';

enum SwipingDirection { left, right, none }

Widget buildLikeBadge(SwipingDirection sw, SwipingDirection cardPosition) {
  final isSwipingRight = sw == SwipingDirection.right;
  final color = isSwipingRight ? Colors.green : Colors.pink;
  final angle = isSwipingRight ? -0.5 : 0.5;
  return cardPosition == SwipingDirection.none
      ? Container()
      : Positioned(
          right: isSwipingRight ? null : 20,
          left: isSwipingRight ? 20 : null,
          top: 20,
          child: Transform.rotate(
            angle: angle,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 2),
              ),
              child: Text(
                isSwipingRight ? 'LIKE' : 'NOPE',
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
}
