import 'package:flutter/material.dart';

import './cartridge.dart';
import './game.dart';

class BallGameController extends FlameWatchGameController {

  BallGameController(FlameWatchGameCartridge c): super(c);

  int i = 1;

  void onLeft() {
    findSprite('ball$i').active = false;

    i -= 1;
    if (i == 0) i = 3;
    findSprite('ball$i').active = true;
  }

  void onRight() {
    findSprite('ball$i').active = false;

    i += 1;
    if (i == 4) i =1;
    findSprite('ball$i').active = true;
  }

  void onTick() {
  }
}

Future<FlameWatchGame> loadSampleGame(Size size) async {
  final cartridge = FlameWatchGameCartridge(
      gameName: 'ball example',
      sprites: {
        'ball': 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAjElEQVRYhe2XOxLAIAgFIfe/c9JlYoIghI8FtjLsSuHwEPTnFO5R02y1WIKa+0sFVvAyhxPwgrOsmYA3fMqjBKLgJPMtEA3/cJ8CWfCBfSRDaQvIf/3NL59AuQBC3fgBYIMJtEALtEB/xeUCvQ9stZJlSbBLabTE0loeJaEKJt4SpmjmIfI7nFLHNZ5f6GATLeHRo3kAAAAASUVORK5CYII=',
      },
      gameSprites: [
        GameSprite(
            id: 'ball1',
            x: 10,
            y: 10,
            spriteName: 'ball',
            active: true 
        ),
        GameSprite(
            id: 'ball2',
            x: 60,
            y: 10,
            spriteName: 'ball',
            active: false 
        ),
        GameSprite(
            id: 'ball3',
            x: 120,
            y: 10,
            spriteName: 'ball',
            active: false 
        ),
      ]
  );

  final game = await FlameWatchGame.load(
      size, cartridge, BallGameController(cartridge),
  );

  return game;
}
