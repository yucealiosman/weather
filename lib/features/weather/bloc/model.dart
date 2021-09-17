import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


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
  @required final String cityName;
  @required final WeatherConditions weatherCondition;
  @required final double temp;
  @required final double minTemp;
  @required final double maxTemp;
  final double humidity;

  Weather(
    this.cityName,
    this.weatherCondition,
    this.temp,
    this.minTemp,
    this.maxTemp,
    this.humidity, 
  );


  @override
  List<Object> get props => [
        cityName,
      ];
}
