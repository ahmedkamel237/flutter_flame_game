import 'dart:async';
import 'dart:io';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:game_with_flame_flutter/actors/player.dart';
import 'package:game_with_flame_flutter/levels/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  final int level;

  @override
  Color backgroundColor() => const Color(0xFF211F30);

  late JoystickComponent joystick;

  // late final CameraComponent cam;
  final Player _player = Player();

  PixelAdventure({
    super.children,
    super.world,
    super.camera,
    required this.level,
  }); // Final for better immutability
  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    camera = CameraComponent.withFixedResolution(
      world: world,
      width: 640,
      height: 360,
    );

    world = Level(
      levelName: level < 10 ? 'level_0$level' : 'level_$level',
      player: _player,
    );

    camera.viewfinder.anchor = Anchor.topLeft;

    if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      addJoystick();
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      _updateJoystick(dt);
    } else {
      _player.update(dt);
    }
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(images.fromCache("HUD/Knob.png")),
      ),
      background: SpriteComponent(
        sprite: Sprite(images.fromCache("HUD/Joystick.png")),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );

    // Add the joystick to the HUD layer, not the camera/world
    camera.viewport.add(joystick);
  }

  void _updateJoystick(double dt) {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.downLeft:
      case JoystickDirection.upLeft:
        _player.playerDirection = PlayerDirection.left;
        print('_player.playerDirection $dt ${_player.playerDirection}');
        break;
      case JoystickDirection.right:
      case JoystickDirection.downRight:
      case JoystickDirection.upRight:
        _player.playerDirection = PlayerDirection.right;
        print('_player.playerDirection ${_player.playerDirection}');
        break;
      default:
        _player.playerDirection = PlayerDirection.none;
        break;
    }
  }
}
