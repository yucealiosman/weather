import 'package:flutter/material.dart';
import 'package:weather/features/weather/bloc/settings/bloc.dart';
import 'package:weather/features/weather/bloc/weather/bloc.dart';
import 'package:weather/features/weather/presentation/theme/theme.dart';
import 'package:weather/features/weather/data/repositories/weather.dart';
import 'package:weather/features/weather/data/remote_data_sources/openweather/services.dart';
import 'package:http/http.dart' as http;

import 'features/base/presentation/screens/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        theme: lighttheme(),
        darkTheme: darktheme(),
        themeMode: ThemeMode.system,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<WeatherBloc>(
              create: (BuildContext context) => WeatherBloc(
                  weatherRepository: WeatherRepositoryImp(
                      service: OpenWeatherService(client: http.Client()))),
            ),
            BlocProvider<SettingsBloc>(
                create: (BuildContext context) => SettingsBloc()),
          ],
          child: Splashscreen(),
        ));
  }
}
