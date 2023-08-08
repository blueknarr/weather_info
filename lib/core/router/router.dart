import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_info/data/api/weather_api_impl.dart';
import 'package:weather_info/data/repository/weather_repository_impl.dart';
import 'package:weather_info/presentation/main/main_screen.dart';
import 'package:weather_info/presentation/main/main_view_model.dart';

import '../../domain/use_case/get_weather_info_use_case.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => MainViewModel(
            GetWeatherInfoUseCase(
              WeatherRepositoryImpl(WeatherApiImpl()),
            ),
          ),
          child: const MainScreen(),
        );
      },
    ),
  ],
);
