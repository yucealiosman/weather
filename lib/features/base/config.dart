import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class Config {
  final String openweatherApiKey;
  Config({this.openweatherApiKey = ""});
  factory Config.fromJson(Map<String, dynamic> jsonMap) {
    return Config(openweatherApiKey: jsonMap["openweatherApiKey"]);
  }
}

class _ConfigLoader {
  final String configPath;

  _ConfigLoader({this.configPath});
  Future<Config> load() {
    return rootBundle.loadStructuredData<Config>(this.configPath,
        (jsonStr) async {
      final config = Config.fromJson(json.decode(jsonStr));
      return config;
    });
  }
}

Future<Config> loadConfig() async {
  return await _ConfigLoader(configPath: "assets/config/local.json").load();
}
