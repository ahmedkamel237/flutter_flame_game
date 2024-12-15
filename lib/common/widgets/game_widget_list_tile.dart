import 'package:flutter/material.dart';
import 'package:game_with_flame_flutter/common/pages/levels_page.dart';
import 'package:game_with_flame_flutter/main.dart';

class GameWidgetListTile extends StatelessWidget {
  const GameWidgetListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LevelsPage(),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              "assets/mario.jpeg",
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            "Mario",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
