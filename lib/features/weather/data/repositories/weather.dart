import 'package:flutter/material.dart';

import 'package:weather/features/weather/bloc/model.dart';
import 'package:weather/features/weather/data/remote_data_sources/services.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather({String cityName});
  Future<Weather> getWeatherWithLatLong({String lat, String long});
}

class WeatherRepositoryImp implements WeatherRepository {
  final WeatherService service;

  WeatherRepositoryImp({@required this.service})
      : assert(service != null);

  @override
  Future<Weather> getWeather({String cityName}) async {
    return await service.getWeather(cityName);
  }

  @override
  Future<Weather> getWeatherWithLatLong({String lat, String long}) async {
    return await service.getWeatherWithLatLong(lat, long);
  }
}
