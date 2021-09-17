import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:weather/features/base/settings_helper.dart';

import 'package:weather/features/weather/bloc/model.dart';
import 'package:weather/features/base/exceptions.dart';
import 'package:weather/features/weather/data/remote_data_sources/services.dart';
import 'package:weather/features/weather/data/remote_data_sources/openweather/models.dart';
import 'package:weather/features/base/config.dart';

class OpenWeatherService implements WeatherService {
  final http.Client client;

  OpenWeatherService({@required this.client});

  Future<String> getAppId() async {
    Config config = await loadConfig();
    return config.openweatherApiKey;
  }

  Future<String> _convertTemperatureUnit(TemperatureUnit unit) async {
    Map<TemperatureUnit, String> temperatureUnitMap = {
      TemperatureUnit.celsius: 'metric',
      TemperatureUnit.kelvin: 'standart',
    };
    return temperatureUnitMap[unit];
  }

  Future<String> getBaseUrl(TemperatureUnit unit) async {
    String appId = await getAppId();

    String tempUnit = await _convertTemperatureUnit(unit);

    String url =
        "https://api.openweathermap.org/data/2.5/weather?appid=$appId&units=$tempUnit";

    return url;
  }

  @override
  Future<Weather> getWeather(String cityName, TemperatureUnit unit) async {
    String baseUrl = await this.getBaseUrl(unit);
    String url = baseUrl + '&q=$cityName';
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return OpenweatherWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Weather> getWeatherWithLatLong(
      String lat, String long, TemperatureUnit unit) async {
    String baseUrl = await this.getBaseUrl(unit);
    String url = baseUrl + '&lat=$lat&lon=$long';

    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return OpenweatherWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
