import 'package:meta/meta.dart';

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

  String counterText;

  GameSprite findSprite(String id) {
    return cartridge.gameSprites.firstWhere(
        (s) => s.id == id,
        orElse: () => null,
    );
  }

  void onLeft();
  void onRight();
  void onTick();
}

class FlameWatchGameCartridge {
  String gameName;
  String background;
  Map<String, String> sprites;

  List<GameSprite> gameSprites = [];

  FlameWatchGameCartridge({
    @required this.background,
    @required this.gameName,
    @required this.sprites,
    @required this.gameSprites,
  });
}
