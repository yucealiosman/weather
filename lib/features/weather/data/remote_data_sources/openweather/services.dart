import 'package:weather/features/weather/bloc/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:weather/features/base/exceptions.dart';
import 'package:weather/features/weather/data/remote_data_sources/services.dart';
import 'package:weather/features/weather/data/remote_data_sources/openweather/models.dart';

class OpenWeatherService implements WeatherService {
  static final String appId = getAppId();
  final http.Client client;
  final String url =
      "https://api.openweathermap.org/data/2.5/weather?appid=$appId&units=metric";
  OpenWeatherService({@required this.client});

  
  static String getAppId() {
    return '';
  }

  @override
  Future<Weather> getWeather(String cityName) async {
    String url = this.url + '&q=$cityName';
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return MetaweatherWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Weather> getWeatherWithLatLong(String lat, String long) async {
    String url = this.url + '&lat=$lat&lon=$long';
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return MetaweatherWeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
