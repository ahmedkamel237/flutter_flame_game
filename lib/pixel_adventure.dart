import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:game_with_flame_flutter/levels/level.dart';

class PixelAdventure extends FlameGame  with HasKeyboardHandlerComponents{
  @override
  Color backgroundColor() => const Color(0xFF211F30);


  late final CameraComponent cam;
  @override
  final world = Level(levelName: "level_01");
  @override
  FutureOr<void> onLoad() async {
    /// load all images into cache
    await images.loadAllImages();
    cam = CameraComponent.withFixedResolution(width: 640, height: 360, world: world);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, world]);
    return super.onLoad();
  }
}