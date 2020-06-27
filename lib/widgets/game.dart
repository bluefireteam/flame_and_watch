import 'package:flutter/material.dart';

import '../game/sample_game.dart';
import '../game/game.dart';

class Game extends StatelessWidget {
  @override
  Widget build(_) {
    return Expanded(
      child: Container(
          child: LayoutBuilder(
              builder: (ctx, constraints) {
                final size = Size(constraints.maxWidth, constraints.maxHeight);

                return FutureBuilder<FlameWatchGame>(
                    future: loadSampleGame(size),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return Container(child: snapshot.data.widget);
                      }

                      return Container();
                    }
                );
              }
          ),
      ),
    );
  }
}
