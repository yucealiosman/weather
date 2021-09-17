import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/weather/bloc/event.dart';
import 'package:weather/features/weather/bloc/state.dart';
import 'package:weather/features/weather/bloc/model.dart';

import 'package:weather/features/weather/data/repositories/weather.dart';
import 'package:geolocator/geolocator.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null),
        super(WeatherStateInitial());
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async* {
    if (weatherEvent is WeatherEventSearchCurrentLocation) {
      
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);
        String lat = position.latitude.toString();
        String long = position.longitude.toString();
        yield WeatherLocationLoading(lat:lat, long: long);
        final Weather weather =
            await weatherRepository.getWeatherWithLatLong(lat: lat, long: long);

        yield WeatherStateSuccess(weather: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    } else if (weatherEvent is WeatherEventSearchCity) {
      yield WeatherCityLoading(weatherEvent.city);
      try {
        final Weather weather =
            await weatherRepository.getWeather(cityName: weatherEvent.city);
        yield WeatherStateSuccess(weather: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    } else if (weatherEvent is WeatherEventRefresh) {
      try {
        final Weather weather =
            await weatherRepository.getWeather(cityName: weatherEvent.city);
        yield WeatherStateSuccess(weather: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    }
  }
}
