import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_with_flame_flutter/breakout_game/components/brick_breaker.dart';


class PlayArea extends RectangleComponent with HasGameReference<BrickBreaker> {
  PlayArea()
      : super(
    paint: Paint()..color = const Color(0xfff2e8cf),
    children: [RectangleHitbox()],                        // Add this parameter
  );

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}