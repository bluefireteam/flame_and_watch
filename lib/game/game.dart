import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame/position.dart';
import 'package:flame/time.dart';

import 'dart:ui';
import 'dart:math';

import './cartridge.dart';

class FlameWatchGame extends Game {

  static const GAME_RESOLUTION = const Size(160, 144);

  final _opaquePaint = Paint()..color = Color(0xFFFFFFFF).withOpacity(0.1);

  Size _gameSize;
  FlameWatchGameCartridge _cartridge;
  FlameWatchGameController _controller;
  double _gameScale;
  Timer _ticker;

  Map<String, Sprite> _loadedSprites = {};

  FlameWatchGame() {
    _ticker = Timer(0.5, repeat: true, callback: _tick)..start();
  }

  static Future<FlameWatchGame> load(
      Size gameSize,
      FlameWatchGameCartridge gameCartridge,
      FlameWatchGameController controller,
    ) async {
    final game = FlameWatchGame()
        .._gameSize = gameSize
        .._cartridge = gameCartridge
        .._controller = controller;

    final spriteLoading = gameCartridge.sprites.entries.map((entry) {
      return Flame.images.fromBase64(entry.key, entry.value)
          .then((image) {
            game._loadedSprites[entry.key] = Sprite.fromImage(image);
          });
    }).toList();
    await Future.wait(spriteLoading);

    final scaleRaw = min(
        gameSize.height / GAME_RESOLUTION.height,
        gameSize.width / GAME_RESOLUTION.width,
    );

    game._gameScale = scaleRaw - scaleRaw % 0.02; 

    return game;
  }

  @override
  void update(double dt) {
    _ticker.update(dt);
  }

  void _tick() {
    _controller.onTick();
  }

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.scale(_gameScale, _gameScale);

    _cartridge.gameSprites.forEach((gameSprite) {
      final pos = Position(gameSprite.x, gameSprite.y);
      _loadedSprites[gameSprite.spriteName].renderPosition(
          canvas,
          pos,
          overridePaint: gameSprite.active ? null : _opaquePaint
      );
    });
    canvas.restore();
  }

  @override
  Color backgroundColor() => const Color(0xFF8D9E8C);
}
