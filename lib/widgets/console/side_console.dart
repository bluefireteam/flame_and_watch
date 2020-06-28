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
        padding: EdgeInsets.only(bottom: 65),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            topContentBox != null
                ? Column(
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color(0xffd5dadb),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(),
                        ),
                        child: topContentBox,
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
                  )
                : Container(),
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
