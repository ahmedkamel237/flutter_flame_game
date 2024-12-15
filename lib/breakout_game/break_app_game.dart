import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_with_flame_flutter/breakout_game/components/brick_breaker.dart';
import 'package:game_with_flame_flutter/breakout_game/components/overlay_screen.dart';
import 'package:game_with_flame_flutter/breakout_game/components/score_card.dart';
import 'package:game_with_flame_flutter/core/constants.dart';


class BreakoutGameApp extends StatefulWidget {
  const BreakoutGameApp({super.key});

  @override
  State<BreakoutGameApp> createState() => _BreakoutGameAppState();
}

class _BreakoutGameAppState extends State<BreakoutGameApp> {
  late final BrickBreaker game;

  @override
  void initState() {
    super.initState();
    game = BrickBreaker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffa9d6e5),
              Color(0xfff2e8cf),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(                                  // Modify from here...
                children: [
                  ScoreCard(score: game.score),
                  Expanded(
                    child: FittedBox(
                      child: SizedBox(
                        width: Config.gameWidth,
                        height: Config.gameHeight,
                        child: GameWidget(
                          game: game,
                          overlayBuilderMap: {
                            PlayState.welcome.name: (context, game) =>
                            const OverlayScreen(
                              title: 'TAP TO PLAY',
                              subtitle: 'Use arrow keys or swipe',
                            ),
                            PlayState.gameOver.name: (context, game) =>
                            const OverlayScreen(
                              title: 'G A M E   O V E R',
                              subtitle: 'Tap to Play Again',
                            ),
                            PlayState.won.name: (context, game) =>
                            const OverlayScreen(
                              title: 'Y O U   W O N ! ! !',
                              subtitle: 'Tap to Play Again',
                            ),
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),                                              // To here.
            ),
          ),
        ),
      ),
    );
  }
}