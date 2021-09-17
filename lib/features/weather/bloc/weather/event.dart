import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
  List<Object> get props => [];
}

class WeatherEventSearchCity extends WeatherEvent {
  final String city;
  const WeatherEventSearchCity({@required this.city}) : assert(city != null);
  @override
  List<Object> get props => [city];
}

class WeatherEventSearchCurrentLocation extends WeatherEvent {

}

class WeatherEventRefresh extends WeatherEvent {
  final String city;
  const WeatherEventRefresh({@required this.city}) : assert(city != null);
  @override
  List<Object> get props => [city];
}
