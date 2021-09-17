import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/base/settings_helper.dart';
import 'package:weather/features/weather/bloc/settings/event.dart';
import 'package:weather/features/weather/bloc/settings/state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  //initial State
  SettingsBloc()
      : super(InitialSettingsState());
  @override
  Stream<SettingsState> mapEventToState(SettingsEvent settingsEvent) async* {
      if (settingsEvent is LoadDefaultSettings) {
      
      yield LoadingDefaultSettingsState();
      TemperatureUnit temperatureUnit = await SharedPreferencesHelper.getTemperatureUnit();
      yield LoadedDefaultSettingsState(temperatureUnit: temperatureUnit);
    }

    if (settingsEvent is ChangeTemperatureUnitSettings) {
      TemperatureUnit newUnit = settingsEvent.temperatureUnit;
      yield ChangingTemperatureUnitSettingsState(temperatureUnit: newUnit);
      await SharedPreferencesHelper.setTemperatureUnit(newUnit);
      yield ChangedTemperatureUnitSettingsState(temperatureUnit: newUnit);
    }
  }
}
