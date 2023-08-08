import 'package:flutter_test/flutter_test.dart';
import 'package:weather_info/data/api/weather_api_impl.dart';
import 'package:weather_info/data/dto/weather_dto.dart';

void main() {
  test('날씨 api 데이터', () async {
    final dto = WeatherApiImpl();
    final api = await dto.getWeatherInfo('seoul', 1);

    expect(api.location.name, 'Seoul');
  });
}
