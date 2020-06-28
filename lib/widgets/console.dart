import 'package:flame_and_watch/widgets/game_button.dart';
import 'package:flutter/material.dart';

import '../game/game.dart';
import '../game/sample_game.dart';

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
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xffd5dadb),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'FLAME',
                          style: TextStyle(
                              fontFamily: 'Firealistic',
                              fontSize: 20,
                              color: Color(0xff8a3842)),
                        ),
                        Text(
                          '&',
                          style: TextStyle(
                              fontFamily: 'Firealistic',
                              fontSize: 20,
                              color: Color(0xff8a3842)),
                        ),
                        Text(
                          'WATCH',
                          style: TextStyle(
                              fontFamily: 'Firealistic',
                              fontSize: 20,
                              color: Color(0xff8a3842)),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      GameButton(
                        size: 80,
                        onClick: () {
                          _game?.onLeft();
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '< LEFT',
                        style: TextStyle(
                          fontFamily: 'Liberation Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xffc6cacb),
                border: Border(
                  top: BorderSide(width: 10, color: Color(0xFFb2b6b8)),
                  left: BorderSide(width: 10, color: Color(0xFFbabebf)),
                  right: BorderSide(width: 10, color: Color(0xFFbabebf)),
                  bottom: BorderSide(width: 10, color: Color(0xffa6a9ab)),
                ),
              ),
              child: Container(
                padding:
                    EdgeInsets.only(right: 8, left: 8, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffc6cacb),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xff662a31),
                      width: 8,
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (ctx, constraints) {
                      final size =
                          Size(constraints.maxWidth, constraints.maxHeight);

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
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GameButton(
                    size: 80,
                    onClick: () {
                      _game?.onRight();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      'RIGHT >',
                      style: TextStyle(
                        fontFamily: 'Liberation Sans',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
