import 'package:weather/features/weather/bloc/model.dart';


abstract class WeatherService {
  Future<Weather> getWeather(String cityName);
  Future<Weather> getWeatherWithLatLong(String lat, String long);
}