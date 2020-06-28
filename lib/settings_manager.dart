import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {
  static bool _soundOn;

  static void switchSound() {
    _soundOn = !_soundOn;
    save();
  }

  static bool isSoundOn() {
    return _soundOn;
  }

  static void save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("SettingsManager.isSoundEnabled", _soundOn);
  }

  static Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _soundOn = prefs.getBool("SettingsManager.isSoundEnabled") ?? true;
  }
}
