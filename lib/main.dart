import 'package:flame_and_watch/settings_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import './flame_and_watch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Flame.audio.loadAll([
      'sfxs/drown.wav',
      'sfxs/rescue.wav',
      'sfxs/gameover.wav',
    ]);
    await Flame.util.fullScreen();
    await Flame.util.setLandscape();
  }
  await SettingsManager.load();

  runApp(FlameAndWatchScreen());
}
