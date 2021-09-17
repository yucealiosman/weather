import 'package:weather/features/weather/bloc/model.dart';
import 'package:weather/features/base/settings_helper.dart';


abstract class WeatherService {
  Future<Weather> getWeather(String cityName, TemperatureUnit unit);
  Future<Weather> getWeatherWithLatLong(String lat, String long, TemperatureUnit unit);
}