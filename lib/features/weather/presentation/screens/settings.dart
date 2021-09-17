import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/features/base/settings_helper.dart';
import 'package:weather/features/weather/bloc/settings/bloc.dart';
import 'package:weather/features/weather/bloc/settings/event.dart';
import 'package:weather/features/weather/bloc/settings/state.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [temperatureUnitSettingsWidget()]));
  }

  Widget temperatureUnitSettingsWidget() {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueAccent,
          ),
          // borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
        ),
        child: Column(children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 30, bottom: 10, top: 20),
              child: Text(
                'Temperature Unit Settings',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          Container(
            alignment: Alignment.center,
            child: BlocBuilder<SettingsBloc, SettingsState>(
                // ignore: missing_return
                builder: (context, settingsState) {
              if (settingsState is InitialSettingsState) {
                BlocProvider.of<SettingsBloc>(context)
                    .add(LoadDefaultSettings());
                return getLoadingSettingsWidget();
              } else if (settingsState is LoadingDefaultSettingsState) {
                return getLoadingSettingsWidget();
              } else if (settingsState is LoadedDefaultSettingsState) {
                return getRadioButtonWidget(
                    settingsState.temperatureUnit, context);
              } else if (settingsState
                  is ChangingTemperatureUnitSettingsState) {
                return getChangingSettingsWidget(settingsState.temperatureUnit);
              } else if (settingsState is ChangedTemperatureUnitSettingsState) {
                return getRadioButtonWidget(
                    settingsState.temperatureUnit, context);
              }
            }),
          ),
        ]));
  }

  Widget getLoadingSettingsWidget() {
    return Text("Loading your settings");
  }

  Widget getChangingSettingsWidget(TemperatureUnit unit) {
    return Text("Changing your temperature unit settings with $unit");
  }

  Widget getRadioButtonWidget(TemperatureUnit unit, context) {
    TemperatureUnit _unit = unit;

    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Celsius'),
          leading: Radio<TemperatureUnit>(
            value: TemperatureUnit.celsius,
            groupValue: _unit,
            onChanged: (TemperatureUnit value) {
              BlocProvider.of<SettingsBloc>(context)
                  .add(ChangeTemperatureUnitSettings(temperatureUnit: value));
            },
          ),
        ),
        ListTile(
          title: const Text('Kelvin'),
          leading: Radio<TemperatureUnit>(
            value: TemperatureUnit.kelvin,
            groupValue: _unit,
            onChanged: (TemperatureUnit value) {
              BlocProvider.of<SettingsBloc>(context)
                  .add(ChangeTemperatureUnitSettings(temperatureUnit: value));
            },
          ),
        ),
      ],
    );
  }
}
