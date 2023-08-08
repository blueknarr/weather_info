import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weather_info/presentation/detail/detail_screen.dart';
import 'package:weather_info/presentation/main/main_screen.dart';
import 'package:weather_info/presentation/main/main_view_model.dart';

import '../../data/dto/weather_dto.dart';
import '../../di/di_setup.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => getIt.get<MainViewModel>(),
          child: const MainScreen(),
        );
      },
    ),
    GoRoute(
        path: '/detail',
        builder: (context, state) {
          final forecastDay = state.extra as Forecastday;
          return DetailScreen(forecastDay: forecastDay);
        }),
  ],
);
