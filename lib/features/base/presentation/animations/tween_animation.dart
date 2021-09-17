import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/weather/bloc/settings/bloc.dart';
import 'package:weather/features/weather/bloc/weather/bloc.dart';

import 'package:weather/features/weather/presentation/screens/weather.dart';

class Opacityanimate extends StatelessWidget {
  static final opacityTween = Tween(begin: 0.0, end: 1.0);
  static final angleTween = Tween<double>(begin: 0, end: 2 * math.pi);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 3),
        tween: opacityTween,
        builder: (BuildContext context, double opacity, Widget child) {
          return Opacity(
            opacity: opacity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TweenAnimationBuilder(
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: size.width * 0.26,
                    ),
                    duration: const Duration(seconds: 2),
                    tween: angleTween,
                    builder:
                        (BuildContext context, double angle, Widget child) {
                      return Transform.rotate(
                        angle: angle,
                        child: child,
                      );
                    }),
                RichText(
                  text: TextSpan(
                    text: 'Weather ',
                    style: Theme.of(context).textTheme.headline4,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Forecast',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        
        onEnd: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) =>     MultiBlocProvider(
          providers: [
           BlocProvider.value(
                value: BlocProvider.of<WeatherBloc>(context),
                child: WeatherScreen(),
              ),
           BlocProvider.value(
                value: BlocProvider.of<SettingsBloc>(context),
                child: WeatherScreen(),
              ),
          ],
          child: WeatherScreen(),
        ),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 1000),
            ),
          );
        },
      ),
    );
  }
}
