import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/weather/bloc/bloc.dart';
import 'package:weather/features/weather/bloc/event.dart';
import 'package:weather/features/weather/bloc/model.dart';
import 'package:weather/features/weather/bloc/state.dart';
import 'package:weather/features/weather/presentation/screens/city_search.dart';
import 'package:weather/features/weather/presentation/screens/settings.dart';
import 'package:weather/features/weather/presentation/icons/weather_icons.dart';

const Map<WeatherConditions, IconData> mapWeatherConditiontoIcon = {
  WeatherConditions.snow: WeatherIcons.snow,
  WeatherConditions.rain: WeatherIcons.rain,
  WeatherConditions.drizzle: WeatherIcons.drizzle,
  WeatherConditions.cloud: WeatherIcons.cloudy,
  WeatherConditions.clear: WeatherIcons.clear,
  WeatherConditions.thunderstorm: WeatherIcons.thunderstorm,
};

class WeatherScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Weather App'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(),
                    ));
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final typedCity = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CitySearchScreen()),
                );
                if (typedCity != null) {
                  BlocProvider.of<WeatherBloc>(context)
                      .add(WeatherEventSearchCity(city: typedCity));
                }
              },
            )
          ],
        ),
        body: Center(
            child: BlocBuilder<WeatherBloc, WeatherState>(
                // ignore: missing_return
                builder: (context, weatherState) {
          if (weatherState is WeatherStateInitial) {
            BlocProvider.of<WeatherBloc>(context)
                .add(WeatherEventSearchCurrentLocation());
            String message = 'Temperature of your current location will loading';
            return buildMessageContainer(message);
          }else if (weatherState is WeatherLocationLoading){
             String message = 'Temperature of your current location is loading';
            return buildMessageContainer(message);
          }
          else if (weatherState is WeatherCityLoading) {
            return this.buildCityContainer(weatherState.city);
          } else if (weatherState is WeatherStateSuccess) {
            return this.buildColumn(weatherState.weather);
          }
          else if (weatherState is WeatherStateFailure) {
            String message = 'Error occured';
            return buildMessageContainer(message);
          }
        }, 
        // listener: (context, weatherState) {
          
          
        
        // }
        )));
  }

  Widget buildColumn(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCityContainer(weather.cityName),
        buildtemperatureContainer(weather.temp),
        buildweatherConditionContainer(weather.weatherCondition)
      ],
    );
  }

  Widget buildMessageContainer(String msg) {
    return Container(
        height: 75.0,
        padding: const EdgeInsets.all(8.0),
        child: Text(msg));
  }

  Widget buildCityContainer(String city) {
    return Container(
        height: 75.0,
        padding: const EdgeInsets.all(8.0),
        child: Text('Your current location is $city'));
  }

  Widget buildtemperatureContainer(double temp) {
    return Container(
        width: 250.0,
        height: 75.0,
        padding: const EdgeInsets.all(8.0),
        child: Text('Your current temperature is $temp'));
  }

  Widget buildweatherConditionContainer(WeatherConditions weatherCondition) {
    String condition = describeEnum(weatherCondition).toUpperCase();
    return Container(
        height: 100.0,
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text('Your current temperature is $condition'),
          Icon(
            mapWeatherConditiontoIcon[weatherCondition],
            size: 65.0,
            color: Colors.purple.shade300,
          ),
        ]));
  }
}
