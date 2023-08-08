import 'package:weather_info/domain/model/weather.dart';

import '../dto/weather_dto.dart';

extension ToWeather on WeatherDto {
  Weather toWeather() {
    return Weather(
      location: location,
      current: current,
      forecastDay: forecast.forecastday,
    );
  }
}
