import 'package:flame_and_watch/widgets/game.dart';
import 'package:flame_and_watch/widgets/game_button.dart';
import 'package:flutter/material.dart';

class Console extends StatelessWidget {
  @override
  Widget build(_) {
    return Container(
      padding: EdgeInsets.only(top: 25, bottom: 50, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Color(0xffc6cacb),
        border: Border(
          top: BorderSide(width: 15, color: Color(0xFF8a3842)),
          left: BorderSide(width: 15, color: Color(0xFF7b323b)),
          right: BorderSide(width: 15, color: Color(0xFF6e2d35)),
          bottom: BorderSide(width: 15, color: Color(0xff662a31)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('LEFT'),
                  SizedBox(
                    height: 10,
                  ),
                  GameButton(
                    size: 80,
                    onClick: () {},
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffc6cacb),
                border: Border(
                  top: BorderSide(width: 20, color: Color(0xFFb2b6b8)),
                  left: BorderSide(width: 20, color: Color(0xFFbabebf)),
                  right: BorderSide(width: 20, color: Color(0xFFbabebf)),
                  bottom: BorderSide(width: 20, color: Color(0xffa6a9ab)),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffc6cacb),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color(0xff662a31),
                    width: 12,
                  ),
                ),
                child: Column(
                  children: [
                    Game(),
                  ],
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
                  Text('RIGHT'),
                  SizedBox(
                    height: 10,
                  ),
                  GameButton(
                    size: 80,
                    onClick: () {},
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
