import 'package:flutter/material.dart';

import 'package:weather/features/weather/bloc/model.dart';
import 'package:weather/features/weather/data/remote_data_sources/services.dart';
import 'package:weather/features/base/settings_helper.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather({String cityName});
  Future<Weather> getWeatherWithLatLong({String lat, String long});
}

class WeatherRepositoryImp implements WeatherRepository {
  final WeatherService service;

  Future<TemperatureUnit> _getTemperatureUnit() async {
    return await SharedPreferencesHelper.getTemperatureUnit();
  }

  WeatherRepositoryImp({@required this.service}) : assert(service != null);

  @override
  Future<Weather> getWeather({String cityName}) async {
    TemperatureUnit unit = await _getTemperatureUnit();

    Weather weather = await service.getWeather(cityName, unit);

    weather = weather.copyWith(tempUnit: unit);
    return weather;
  }

  @override
  Future<Weather> getWeatherWithLatLong({String lat, String long}) async {
    TemperatureUnit unit = await _getTemperatureUnit();

    Weather weather = await service.getWeatherWithLatLong(lat, long, unit);

    weather = weather.copyWith(tempUnit: unit);
    return weather;
  }
}
