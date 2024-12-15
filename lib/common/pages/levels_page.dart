import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_with_flame_flutter/breakout_game/break_app_game.dart';
import 'package:game_with_flame_flutter/core/constants.dart';
import 'package:game_with_flame_flutter/pixel_adventure.dart';

class LevelsPage extends StatelessWidget {
  static const String routeName = "/levels";

  const LevelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Levels"),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Level ${index + 1}"),
            onTap: () {
              Flame.device.setLandscape();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GameWidget(
                    game: PixelAdventure(
                      level: index + 1,
                      // need to make a choice character page
                      characterName: AppConstants.ninjaFrog,
                    ),
                  ),
                ),
              );
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => const BreakoutGameApp(),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}
