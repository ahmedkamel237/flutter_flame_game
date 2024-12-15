import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_with_flame_flutter/actors/player.dart';
import 'package:game_with_flame_flutter/core/constants.dart';

class Level extends World {
  late TiledComponent level;
  String levelName;
  final Player player;
  final String characterName;
  final JoystickComponent joystick;

  Level({
    required this.player,
    required this.levelName,
    required this.joystick,
    this.characterName = AppConstants.ninjaFrog,
  });

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load("$levelName.tmx", Vector2.all(16));
    add(level);

    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>("Spawnpoints");
    for (final spawnPoint in spawnPointLayer!.objects) {
      switch (spawnPoint.class_) {
        case "Player":
          final player = Player(
            joystick: joystick,
            character: characterName,
            position: Vector2(
              spawnPoint.x,
              spawnPoint.y,
            ),
          );
          player.position = Vector2(
            spawnPoint.x,
            spawnPoint.y,
          );
          add(player);
          break;
        default:
      }
    }
    return super.onLoad();
  }
}
