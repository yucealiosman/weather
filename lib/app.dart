
import 'package:flutter/material.dart';
import 'package:weather/features/weather/presentation/theme/theme.dart';
import 'package:weather/features/weather/bloc/bloc.dart';
import 'package:weather/features/weather/data/repositories/weather.dart';
import 'package:weather/features/weather/data/remote_data_sources/openweather/services.dart';
import 'package:http/http.dart' as http;



import 'features/weather/presentation/screens/splash_screen.dart';
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
      home: 
      BlocProvider(
        create: (context) => WeatherBloc(weatherRepository: WeatherRepositoryImp(remoteService: OpenWeatherService(client: http.Client()))),
        child: Splashscreen(),
      ),
    );
  }
}