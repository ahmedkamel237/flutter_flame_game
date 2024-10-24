import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_with_flame_flutter/actors/player.dart';

class Level extends World {
  late TiledComponent level;
  String levelName;
  Player player;
  Level({required this.player,required this.levelName});

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load("$levelName.tmx", Vector2.all(16));
    add(level);

    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>("Spawnpoints");
    for (final spawnPoint in spawnPointLayer!.objects) {
      switch (spawnPoint.class_) {
        case "Player":
          final player = Player(
            character: "Ninja Frog",
            position: Vector2(
              spawnPoint.x,
              spawnPoint.y,
            ),
          );
          player.position =Vector2(
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
