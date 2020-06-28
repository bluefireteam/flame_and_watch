import 'package:meta/meta.dart';
import 'package:flame/position.dart';
import 'package:flame/flame.dart';

import '../settings_manager.dart';

enum GameDigitalDisplaySize {
  SMALL, MEDIUM, BIG,
}

class GameDigitalDisplay {
  final Position position;
  String text;
  final GameDigitalDisplaySize size;

  GameDigitalDisplay({
      @required this.position,
      this.text = '',
      this.size = GameDigitalDisplaySize.SMALL,
  });
}

class GameSprite {
  double x;
  double y;

  String spriteName;
  String id;
  bool active;

  GameSprite({
    @required this.id,
    @required this.x,
    @required this.y,
    @required this.spriteName,
    @required this.active,
  });

  void toggle() {
    active = !active;
  }
}

abstract class FlameWatchGameController {
  final FlameWatchGameCartridge cartridge;

  FlameWatchGameController(this.cartridge);

  GameSprite findSprite(String id) {
    return cartridge.gameSprites.firstWhere(
        (s) => s.id == id,
        orElse: () => null,
    );
  }

  void setDisplayText(String id, String text) {
    cartridge.digitalDisplays[id].text = text;
  }

  void sfx(String file) {
    if (SettingsManager.isSoundOn()) {
      Flame.audio.play('sfxs/$file');
    }
  }

  void onLeft();
  void onRight();
  void onTick();
}

class FlameWatchGameCartridge {
  String gameName;
  String background;
  double tickTime;
  Map<String, String> sprites;
  Map<String, GameDigitalDisplay> digitalDisplays = {};

  List<GameSprite> gameSprites = [];

  FlameWatchGameCartridge({
    @required this.background,
    @required this.gameName,
    @required this.sprites,
    @required this.gameSprites,
    @required this.digitalDisplays,
    this.tickTime = 0.5,
  });
}
