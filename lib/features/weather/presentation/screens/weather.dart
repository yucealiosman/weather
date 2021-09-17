import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/base/settings_helper.dart';
import 'package:weather/features/weather/bloc/settings/bloc.dart';
import 'package:weather/features/weather/bloc/settings/state.dart';

import 'package:weather/features/weather/bloc/weather/bloc.dart';
import 'package:weather/features/weather/bloc/weather/event.dart';
import 'package:weather/features/weather/bloc/model.dart';
import 'package:weather/features/weather/bloc/weather/state.dart';
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
                    PageRouteBuilder(
                      pageBuilder: (c, a1, a2) => BlocProvider.value(
                        value: BlocProvider.of<SettingsBloc>(context),
                        child: SettingsScreen(),
                      ),
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
            child: BlocListener<SettingsBloc, SettingsState>(
                listener: (context, weatherState) {
          BlocProvider.of<WeatherBloc>(context)
              .add(WeatherEventSearchCurrentLocation());
          String message = 'Temperature of your current location will loading';
          return buildMessageContainer(message);
        }, child: BlocBuilder<WeatherBloc, WeatherState>(
          // ignore: missing_return
          builder: (context, weatherState) {
            if (weatherState is WeatherStateInitial) {
              BlocProvider.of<WeatherBloc>(context)
                  .add(WeatherEventSearchCurrentLocation());
              String message =
                  'Temperature of your current location will loading';
              return buildMessageContainer(message);
            } else if (weatherState is WeatherLocationLoading) {
              String message =
                  'Temperature of your current location is loading';
              return buildMessageContainer(message);
            } else if (weatherState is WeatherCityLoading) {
              return this.buildCityContainer(weatherState.city);
            } else if (weatherState is WeatherStateSuccess) {
              return this.buildColumn(weatherState.weather);
            } else if (weatherState is WeatherStateFailure) {
              String message = 'Error occured';
              return buildMessageContainer(message);
            }
          },
        ))));
  }

  Widget buildColumn(Weather weather) {
    return Container(
        padding: EdgeInsets.only(bottom: 150, top: 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCityContainer(weather.cityName),
            buildtemperatureContainer(weather.temp, weather.tempUnit),
            buildweatherConditionContainer(weather.weatherCondition)
          ],
        ));
  }

  Widget buildMessageContainer(String msg) {
    return Container(
        // padding: const EdgeInsets.all(8.0),
        child: Text(msg));
  }

  Widget buildCityContainer(String city) {
    return Container(
        // padding: const EdgeInsets.all(8.0),
        child: Text(
      '$city',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ));
  }

  Widget buildtemperatureContainer(double temp, TemperatureUnit tempUnit) {
    String unit = mapTempUnitToSymbol(tempUnit);
    return Container(
        // padding: const EdgeInsets.all(8.0),
        child: Text(
      '$temp $unit',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ));
  }

  Widget buildweatherConditionContainer(WeatherConditions weatherCondition) {
    String condition = describeEnum(weatherCondition).toUpperCase();
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(
        '$condition',
        textAlign: TextAlign.left,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      Icon(
        mapWeatherConditiontoIcon[weatherCondition],
        size: 50.0,
        color: Colors.purple.shade300,
      ),
    ]));
  }

  String mapTempUnitToSymbol(TemperatureUnit unit) {
    Map<TemperatureUnit, String> mapTempUnitToSymbol = {
      TemperatureUnit.celsius: '°C',
      TemperatureUnit.kelvin: '°K',
    };
    return mapTempUnitToSymbol[unit];
  }
}
