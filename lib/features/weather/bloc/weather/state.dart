import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather/features/weather/bloc/model.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object> get props => [];
}

class WeatherStateInitial extends WeatherState {}

class WeatherCityLoading extends WeatherState {
  final String city;

  WeatherCityLoading(this.city);
}

class WeatherLocationLoading extends WeatherState {
  final String lat;
  final String long;

  WeatherLocationLoading({this.lat, this.long});
}

class WeatherStateSuccess extends WeatherState {
  final Weather weather;
  const WeatherStateSuccess({@required this.weather}) : assert(weather != null);

  @override
  List<Object> get props => [weather];
}

class WeatherStateFailure extends WeatherState {}
