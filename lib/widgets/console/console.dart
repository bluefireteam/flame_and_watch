import 'package:flame_and_watch/widgets/console/screen_console.dart';
import 'package:flame_and_watch/widgets/console/side_console.dart';
import 'package:flutter/material.dart';

import '../../game/game.dart';
import '../../game/sample_game.dart';

class Console extends StatefulWidget {
  @override
  State createState() => _ConsoleState();
}

class _ConsoleState extends State<Console> {
  FlameWatchGame _game;

  @override
  Widget build(_) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Color(0xffc6cacb),
        border: Border(
          top: BorderSide(width: 10, color: Color(0xFF8a3842)),
          left: BorderSide(width: 10, color: Color(0xFF7b323b)),
          right: BorderSide(width: 10, color: Color(0xFF6e2d35)),
          bottom: BorderSide(width: 10, color: Color(0xff662a31)),
        ),
      ),
      child: Row(
        children: [
          SideConsole(
            buttonClick: () {
              _game?.onLeft();
            },
            buttonLabel: '< LEFT',
            topContent: Column(
              children: [
                Text(
                  'FLAME',
                  style: TextStyle(fontFamily: 'Firealistic', fontSize: 20, color: Color(0xff8a3842)),
                ),
                Text(
                  '&',
                  style: TextStyle(fontFamily: 'Firealistic', fontSize: 20, color: Color(0xff8a3842)),
                ),
                Text(
                  'WATCH',
                  style: TextStyle(fontFamily: 'Firealistic', fontSize: 20, color: Color(0xff8a3842)),
                ),
              ],
            ),
          ),
          ScreenConsole(
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                final size = Size(constraints.maxWidth, constraints.maxHeight);

                return FutureBuilder<FlameWatchGame>(
                  future: loadSampleGame(size),
                  builder: (_, snapshot) {
                    _game = snapshot.data;
                    if (snapshot.hasData) {
                      return Container(child: _game.widget);
                    }

                    return Container();
                  },
                );
              },
            ),
          ),
          SideConsole(
            buttonClick: () {
              _game?.onRight();
            },
            buttonLabel: 'RIGHT >',
          ),
        ],
      ),
    );
  }
}