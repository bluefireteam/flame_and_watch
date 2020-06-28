import 'package:flame_and_watch/widgets/game_button.dart';
import 'package:flutter/material.dart';

class SideConsole extends StatelessWidget {
  final Function buttonClick;
  final String buttonLabel;
  final Widget topContent;

  SideConsole({this.buttonClick, this.buttonLabel, this.topContent});

  @override
  Widget build(_) {
    return Expanded(
      flex: 2,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            topContent != null
                ? Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xffd5dadb),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    child: topContent,
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
