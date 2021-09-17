import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:weather/features/base/settings_helper.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadDefaultSettings extends SettingsEvent {
  LoadDefaultSettings();
  @override
  List<Object> get props => [];
}

class ChangeTemperatureUnitSettings extends SettingsEvent {
  final TemperatureUnit temperatureUnit;

  ChangeTemperatureUnitSettings({@required this.temperatureUnit})
      : assert(temperatureUnit != null);
  @override
  List<Object> get props => [temperatureUnit];
}
