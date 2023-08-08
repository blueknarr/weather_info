import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/dto/weather_dto.dart';

part 'weather.freezed.dart';

part 'weather.g.dart';

@freezed
class Weather with _$Weather {
  const factory Weather({
    required Location location,
    required Current current,
    required List<Forecastday> forecastDay,
  }) = _Weather;

  factory Weather.fromJson(Map<String, Object?> json) =>
      _$WeatherFromJson(json);
}
