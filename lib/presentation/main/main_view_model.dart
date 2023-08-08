import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../core/result/result.dart';
import '../../domain/use_case/get_weather_info_use_case.dart';
import 'main_state.dart';
import 'main_ui_event.dart';

@injectable
class MainViewModel with ChangeNotifier {
  final GetWeatherInfoUseCase _getWeatherInfoUseCase;

  final _eventController = StreamController<MainUiEvent>();

  Stream<MainUiEvent> get eventStream => _eventController.stream;

  MainViewModel(this._getWeatherInfoUseCase);

  MainState _state = const MainState();

  MainState get state => _state;

  Future<void> getWeatherInfo({String city = '', int day = 3}) async {
    // _state = state.copyWith(
    //   isLoading: true,
    // );
    // notifyListeners();

    final result = await _getWeatherInfoUseCase.execute(city, day);

    switch (result) {
      case Success(:final data):
        _state = state.copyWith(
          location: data.location,
          current: data.current,
          forecastDay: data.forecastDay,
          isLoading: false,
        );
        notifyListeners();

        _eventController.add(const EndLoading());
      case Error(:final e):
        _eventController.add(ShowSnackBar(e));
        _state = state.copyWith(
          isLoading: false,
        );
        notifyListeners();
    }
  }
}
