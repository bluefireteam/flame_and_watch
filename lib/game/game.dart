import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flame/position.dart';
import 'package:flame/time.dart';

import 'dart:ui';
import 'dart:math';

import './cartridge.dart';
import './layer.dart';
import './processors.dart';

class FlameWatchGame extends Game {

  static Paint _backgroundPaint = Paint()..color = const Color(0xFF8D9E8C);
  static const GAME_RESOLUTION = const Size(128, 96);
  static Rect gameRect = Rect.fromLTWH(0, 0, GAME_RESOLUTION.width, GAME_RESOLUTION.height);

  FlameWatchGameController _controller;
  Timer _ticker;

  _BackgroundLayer _backgroundLayer;
  _GameLayer _gameLayer;
  Map<String, Sprite> _loadedSprites = {};

  double _gameScale;
  double _offset;

  Rect _screenRect;

  FlameWatchGame() {
    _ticker = Timer(0.5, repeat: true, callback: _tick)..start();
  }

  static Future<FlameWatchGame> load(
      Size gameSize,
      FlameWatchGameCartridge gameCartridge,
      FlameWatchGameController controller,
    ) async {
    final game = FlameWatchGame()
        .._screenRect = Rect.fromLTWH(0, 0, gameSize.width, gameSize.height)
        .._controller = controller;

    final spriteLoading = gameCartridge.sprites.entries.map((entry) {
      return Flame.images.fromBase64(entry.key, entry.value)
          .then((image) {
            game._loadedSprites[entry.key] = Sprite.fromImage(image);
          });
    }).toList();
    await Future.wait(spriteLoading);

    game._gameLayer = _GameLayer(game._loadedSprites, gameCartridge);

    final _backgroundImage = await Flame.images.fromBase64(
        '${gameCartridge.gameName}-background-image',
        gameCartridge.background,
    );
    game._backgroundLayer = _BackgroundLayer(Sprite.fromImage(_backgroundImage));

    final scaleRaw = min(
        gameSize.height / GAME_RESOLUTION.height,
        gameSize.width / GAME_RESOLUTION.width,
    );

    game._gameScale = scaleRaw - scaleRaw % 0.02; 
    game._offset = (gameSize.width - GAME_RESOLUTION.width * game._gameScale) / 2;

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
    canvas.drawRect(_screenRect, _backgroundPaint);
    canvas.translate(_offset, 0);
    canvas.scale(_gameScale, _gameScale);
    
    canvas.clipRect(gameRect);
    _backgroundLayer.render(canvas);
    _gameLayer.render(canvas);
    canvas.restore();
  }

  void onLeft() {
    _controller.onLeft();
  }

  void onRight() {
    _controller.onRight();
  }
}

class _BackgroundLayer extends PreRenderedLayer {
  Sprite background;

  _BackgroundLayer(this.background) {
    preProcessors.add(
        ShadowProcessor(
            offset: Offset(1, 1),
            color: const Color(0xFFFFFFFF),
            opacity: 0.2,
        ),
    );
  }

  @override
  void drawLayer() {
    background.renderPosition(canvas, Position(0, 0));
  }
}

class _GameLayer extends DynamicLayer {
  Map<String, Sprite> sprites;
  FlameWatchGameCartridge cartridge;

  _GameLayer(this.sprites, this.cartridge) {
    preProcessors.add(
        ShadowProcessor(
            offset: Offset(2, 2),
            opacity: 0.2,
        ),
    );
  }

  @override
  void drawLayer() {
    cartridge.gameSprites.forEach((gameSprite) {
      if (gameSprite.active) {
        final pos = Position(gameSprite.x, gameSprite.y);
        sprites[gameSprite.spriteName].renderPosition(
            canvas,
            pos,
        );
      }
    });
  }
}
