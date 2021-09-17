import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather/features/base/settings_helper.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class InitialSettingsState extends SettingsState {}

class ChangingTemperatureUnitSettingsState extends SettingsState {
  final TemperatureUnit temperatureUnit;
  const ChangingTemperatureUnitSettingsState({@required this.temperatureUnit})
      : assert(temperatureUnit != null);

  @override
  List<Object> get props => [temperatureUnit];
}

class ChangedTemperatureUnitSettingsState extends SettingsState {
  final TemperatureUnit temperatureUnit;
  const ChangedTemperatureUnitSettingsState({@required this.temperatureUnit})
      : assert(temperatureUnit != null);

  @override
  List<Object> get props => [temperatureUnit];
}

class LoadingDefaultSettingsState extends SettingsState {}

class LoadedDefaultSettingsState extends SettingsState {
  final TemperatureUnit temperatureUnit;
  const LoadedDefaultSettingsState({@required this.temperatureUnit})
      : assert(temperatureUnit != null);

  @override
  List<Object> get props => [temperatureUnit];
}
