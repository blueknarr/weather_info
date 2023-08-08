import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:weather_info/data/dto/weather_dto.dart';
import 'package:weather_info/domain/api/weather_api.dart';
import 'package:http/http.dart' as http;

@singleton
class WeatherApiImpl implements WeatherApi {
  @override
  Future<WeatherDto> getWeatherInfo(String city, int day) async {
    final uri =
        'http://api.weatherapi.com/v1/forecast.json?key=1ab7131b284542d3b1860726230208&q=$city&days=$day&aqi=no&alerts=no';
    final http.Response response = await http.get(Uri.parse(uri));
    final jsonString = jsonDecode(response.body);

    return WeatherDto.fromJson(jsonString);
  }
}
