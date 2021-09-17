import 'package:flutter/material.dart';
import 'package:weather/features/weather/bloc/model.dart';
import 'package:weather/features/weather/data/remote_data_sources/services.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather({String cityName});
  Future<Weather> getWeatherWithLatLong({String lat, String long});
}

class WeatherRepositoryImp implements WeatherRepository {
  final WeatherService remoteService;

  WeatherRepositoryImp({@required this.remoteService})
      : assert(remoteService != null);

  @override
  Future<Weather> getWeather({String cityName}) async {
    return await remoteService.getWeather(cityName);
  }

  @override
  Future<Weather> getWeatherWithLatLong({String lat, String long}) async {
    return await remoteService.getWeatherWithLatLong(lat, long);
  }
}
