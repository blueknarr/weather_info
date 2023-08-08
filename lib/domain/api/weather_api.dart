import '../../data/dto/weather_dto.dart';

abstract interface class WeatherApi {
  Future<WeatherDto> getWeatherInfo(String city, int day);
}
