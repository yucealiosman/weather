import 'package:weather/features/weather/bloc/model.dart';
import 'package:meta/meta.dart';

class MetaweatherWeatherModel extends Weather {
  MetaweatherWeatherModel(
      {
      @required String cityName,
      // @required DateTime date,
      @required WeatherConditions weatherCondition,
      @required double temp,
      @required double minTemp,
      @required double maxTemp,
      double humidity
      })
      : super(cityName, weatherCondition, temp, minTemp, maxTemp,
            humidity);

  factory MetaweatherWeatherModel.fromJson(dynamic jsonObject) {
    return MetaweatherWeatherModel(
      weatherCondition: _mapWeatherCodeToWeatherCondition(
          jsonObject['weather'][0]['main']),
      minTemp: (jsonObject['main']['temp_min'] as num).toDouble(),
      temp: (jsonObject['main']['temp'] as num).toDouble(),
      maxTemp: (jsonObject['main']['temp_max'] as num).toDouble(),
      cityName: jsonObject['name'],
      humidity: (jsonObject['main']['humidity'] as num).toDouble(),
    );
  }
  static WeatherConditions _mapWeatherCodeToWeatherCondition(
      String inputString) {
    Map<String, WeatherConditions> codeToWeatherCondition = {
      'Thunderstorm': WeatherConditions.thunderstorm,
      'Drizzle': WeatherConditions.drizzle,
      'Rain': WeatherConditions.rain,
      'Snow': WeatherConditions.snow,
      'Clear': WeatherConditions.clear,
      'Clouds': WeatherConditions.cloud,
    };
    return codeToWeatherCondition[inputString] ?? WeatherConditions.unknown;
  }
}
