import 'package:shared_preferences/shared_preferences.dart';

enum TemperatureUnit { kelvin, celsius }

class SharedPreferencesHelper {
  static final String _kTempatureUnit = "tempatureUnit";

  static Future<TemperatureUnit> getTemperatureUnit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int unitIndex = prefs.getInt(_kTempatureUnit);
    return TemperatureUnit.values[unitIndex];
  }

  static Future<bool> setTemperatureUnit(TemperatureUnit unit) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(_kTempatureUnit, unit.index);
  }
}
