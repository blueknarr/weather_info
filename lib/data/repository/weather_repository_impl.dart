import 'package:injectable/injectable.dart';
import 'package:weather_info/data/api/weather_api_impl.dart';
import 'package:weather_info/data/mapper/weather_mapper.dart';
import 'package:weather_info/domain/model/weather.dart';
import 'package:weather_info/domain/repository/weather_repository.dart';

@Singleton(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiImpl api;

  WeatherRepositoryImpl(this.api);

  @override
  Future<Weather> getWeatherInfo(String city, int day) async {
    final weatherDto = await api.getWeatherInfo(city, day);

    return weatherDto.toWeather();
  }
}
