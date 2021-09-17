import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weather/features/base/settings_helper.dart';

enum WeatherConditions {
  snow,
  rain,
  drizzle,
  cloud,
  clear,
  thunderstorm,
  unknown,
}

class Weather extends Equatable {
  @required
  final String cityName;
  @required
  final WeatherConditions weatherCondition;
  @required
  final TemperatureUnit tempUnit;
  @required
  final double temp;
  @required
  final double minTemp;
  @required
  final double maxTemp;
  final double humidity;

  Weather({
    this.cityName,
    this.weatherCondition,
    this.tempUnit,
    this.temp,
    this.minTemp,
    this.maxTemp,
    this.humidity,
  });

  Weather copyWith({
    String cityname,
    WeatherConditions weatherCondition,
    TemperatureUnit tempUnit,
    double temp,
    double minTemp,
    double maxTemp,
    double humidity,
  }) {
    return Weather(
      cityName: cityname ?? this.cityName,
      weatherCondition: weatherCondition ?? this.weatherCondition,
      tempUnit: tempUnit ?? this.tempUnit,
      temp: temp ?? this.temp,
      minTemp: minTemp ?? this.minTemp,
      maxTemp: maxTemp ?? this.maxTemp,
      humidity: humidity ?? this.humidity,
    );
  }

  @override
  List<Object> get props => [
        cityName,
      ];
}
