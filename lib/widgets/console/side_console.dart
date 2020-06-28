import 'package:flame_and_watch/widgets/game_button.dart';
import 'package:flutter/material.dart';

class SideConsole extends StatelessWidget {
  final Function buttonClick;
  final String buttonLabel;
  final Widget topContentBox;

  SideConsole({this.buttonClick, this.buttonLabel, this.topContentBox});

  @override
  Widget build(_) {
    return Expanded(
      flex: 2,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            topContentBox ?? Container(),
            Column(
              children: [
                GameButton(
                  size: 80,
                  onClick: buttonClick,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  buttonLabel,
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
    );
  }
}
