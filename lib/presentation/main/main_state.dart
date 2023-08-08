import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/dto/weather_dto.dart';

part 'main_state.freezed.dart';

part 'main_state.g.dart';

@freezed
class MainState with _$MainState {
  const factory MainState(
      {Location? location,
      Current? current,
      @Default([]) List<Forecastday> forecastDay,
      @Default(true) bool isLoading,
      @Default('https:') String prefixUrl}) = _MainState;

  factory MainState.fromJson(Map<String, Object?> json) =>
      _$MainStateFromJson(json);
}
