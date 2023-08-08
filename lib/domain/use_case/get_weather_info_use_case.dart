import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';

import '../../core/result/result.dart';
import '../../data/repository/weather_repository_impl.dart';
import '../model/weather.dart';

@singleton
class GetWeatherInfoUseCase {
  final WeatherRepositoryImpl repository;

  GetWeatherInfoUseCase(this.repository);

  Future<Result<Weather>> execute(String city, int day) async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return const Result.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return const Result.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return const Result.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (city.isEmpty) {
        Position currentPosition = await Geolocator.getCurrentPosition();
        List<Placemark> placemarks = await placemarkFromCoordinates(
            currentPosition.latitude, currentPosition.longitude);

        city = placemarks.first.administrativeArea!;
      }
      final weatherInfo = await repository.getWeatherInfo(city, day);
      return Result.success(weatherInfo);
    } catch (e) {
      return const Result.error('네트워크 문제로 날씨 정보를 가져오지 못했습니다.');
    }
  }
}
