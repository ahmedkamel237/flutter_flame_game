import 'dart:async';
import 'dart:io';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:game_with_flame_flutter/actors/player.dart';
import 'package:game_with_flame_flutter/core/constants.dart';
import 'package:game_with_flame_flutter/levels/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  final int level;
  final String characterName;

  @override
  Color backgroundColor() => const Color(0xFF211F30);

  late JoystickComponent _joystick;

  late final Player _player;

  PixelAdventure({
    super.children,
    super.world,
    super.camera,
    required this.level,
    this.characterName = AppConstants.ninjaFrog,
  });

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    camera = CameraComponent.withFixedResolution(
      world: world,
      width: 640,
      height: 360,
    );

    if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      addJoystick();
    }

    _player = Player(joystick: _joystick);

    // The World that the camera is rendering.
    // Inside of this world is where most of your components should be added.
    world = Level(
      levelName: level < 10 ? 'level_0$level' : 'level_$level',
      player: _player,
      characterName: characterName,
      joystick: _joystick,
    );

    camera.viewfinder.anchor = Anchor.topLeft;



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
    _joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(images.fromCache("HUD/Knob.png")),
      ),
      background: SpriteComponent(
        sprite: Sprite(images.fromCache("HUD/Joystick.png")),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );

    // Add the joystick to the HUD layer, not the camera/world
    camera.viewport.add(_joystick);
  }

  void _updateJoystick(double dt) {
    switch (_joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.downLeft:
      case JoystickDirection.upLeft:
        _player.playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.right:
      case JoystickDirection.downRight:
      case JoystickDirection.upRight:
        _player.playerDirection = PlayerDirection.right;
        break;
      default:
        _player.playerDirection = PlayerDirection.none;
        break;
    }
  }
}
