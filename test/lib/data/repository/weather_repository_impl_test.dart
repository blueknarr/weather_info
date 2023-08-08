import 'package:flutter_test/flutter_test.dart';
import 'package:weather_info/data/api/weather_api_impl.dart';
import 'package:weather_info/data/repository/weather_repository_impl.dart';

void main() {
  test('weather repository', () async {
    final repository = WeatherRepositoryImpl(WeatherApiImpl());
    final weatherInfo = await repository.getWeatherInfo('seoul', 1);

    expect(weatherInfo.location.name, 'Seoul');
  });
}
