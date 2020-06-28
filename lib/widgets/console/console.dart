import 'package:flame_and_watch/widgets/option_button.dart';
import 'package:flutter/material.dart';
import 'package:flame_and_watch/widgets/console/screen_console.dart';
import 'package:flame_and_watch/widgets/console/side_console.dart';
import 'package:flame_and_watch/settings_manager.dart';
import 'package:flame_and_watch/widgets/swtich_button.dart';

import '../../game/game.dart';
import '../../game/parachute_game.dart';
import '../../game/clock_game.dart';

class Console extends StatefulWidget {
  @override
  State createState() => _ConsoleState();
}

class _ConsoleState extends State<Console> {
  FlameWatchGame _game;
  String activeGame = 'CLOCK';

  bool isParachuteGame() => activeGame == 'PARACHUTE';

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
            iconLabelLeft: Icon(
              Icons.arrow_left,
              size: 40,
            ),
            buttonLabel: 'LEFT',
            topContentBox: Column(
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
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    'Fireslime',
                    style: TextStyle(
                      fontFamily: 'Firealistic',
                      fontSize: 14,
                      color: Color(0xff6c6e70),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ScreenConsole(
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                final size = Size(constraints.maxWidth, constraints.maxHeight);

                return FutureBuilder<FlameWatchGame>(
                  future: isParachuteGame() ? loadParachuteGame(size) : loadClockGame(size),
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
            iconLabelRight: Icon(
              Icons.arrow_right,
              size: 40,
            ),
            buttonLabel: 'RIGHT',
            topContentBox: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: SwitchButton(
                    on: SettingsManager.isSoundOn(),
                    onChange: () {
                      SettingsManager.switchSound();
                    },
                    label: 'Sound',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: OptionButton(
                    onClick: () {
                      setState(() {
                        activeGame = 'PARACHUTE';
                      });
                    },
                    label: 'Game',
                    size: 35,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 15),
                  child: OptionButton(
                    onClick: () {
                      setState(() {
                        activeGame = 'CLOCK';
                      });
                    },
                    label: 'Time',
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
