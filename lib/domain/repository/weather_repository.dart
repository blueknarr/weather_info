import '../model/weather.dart';

abstract interface class WeatherRepository {
  Future<Weather> getWeatherInfo(String city, int day);
}
