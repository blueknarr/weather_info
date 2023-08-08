import 'package:weather_info/data/api/weather_api_impl.dart';
import 'package:weather_info/data/mapper/weather_mapper.dart';
import 'package:weather_info/domain/model/weather.dart';
import 'package:weather_info/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiImpl _api;

  WeatherRepositoryImpl(this._api);

  @override
  Future<Weather> getWeatherInfo(String city, int day) async {
    final weatherDto = await _api.getWeatherInfo(city, day);

    return weatherDto.toWeather();
  }
}
