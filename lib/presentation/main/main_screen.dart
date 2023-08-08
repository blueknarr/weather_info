import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_info/presentation/main/main_ui_event.dart';
import 'package:weather_info/presentation/main/main_view_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<MainViewModel>().getWeatherInfo();
      context.read<MainViewModel>().eventStream.listen((event) {
        switch (event) {
          case ShowSnackBar(:final message):
            final snackBar = SnackBar(content: Text(message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          case EndLoading():
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();
    final state = viewModel.state;

    double cardWidth = MediaQuery.of(context).size.width * 0.9; // 화면 너비의 80%
    double cardHeight = MediaQuery.of(context).size.height * 0.67; // 화면 높이의 20%

    return Scaffold(
        body: Column(
      children: [
        state.isLoading
            ? const CircularProgressIndicator()
            : Center(
                child: SizedBox(
                  width: cardWidth,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: cardWidth,
                        height: cardHeight,
                        decoration: BoxDecoration(
                            color: const Color(0xffc4e1ff),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Color(0xff24609d),
                                      ),
                                      Text(
                                        state.location!.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Color(0xff24609d),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${state.location!.localtime} 기준',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff24609d),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                '${state.current!.tempC}°',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 64,
                                  color: Color(0xff24609d),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text(
                                state.current!.condition.text,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff24609d),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.solar_power_outlined,
                                          color: Color(0xff24609d)),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        '${state.current!.uv}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff24609d),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.water_drop_outlined,
                                        color: Color(0xff24609d),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        '${state.current!.humidity}%',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff24609d),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.air_outlined,
                                        color: Color(0xff24609d),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        '${state.current!.windMph}mph',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff24609d),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Image.network(
                              scale: 0.4,
                              '${state.prefixUrl}${state.current!.condition.icon}',
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 24, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '날씨 예보',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ...state.forecastDay.map((e) {
                            return GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: [
                                  Text(e.date
                                      .substring(6, 10)
                                      .replaceAll('-', '.')),
                                  Image.network(
                                      '${state.prefixUrl}${e.day.condition.icon}'),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '${e.day.mintempC}° / ${e.day.maxtempC}°',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ],
    ));
  }
}
