import 'package:flutter/material.dart';

import '../../data/dto/weather_dto.dart';

class DetailScreen extends StatelessWidget {
  final Forecastday forecastDay;

  const DetailScreen({super.key, required this.forecastDay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              '${forecastDay.date.substring(6, 10).replaceAll('-', '월 ')}일 날씨 예보'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ...forecastDay.hour.map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 12.0),
                  child: ListTile(
                    leading: Text(
                      e.time.substring(11, 16),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    title: Center(
                      child: Text(
                        '${e.tempC}°',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    trailing: Image.network('https:${e.condition.icon}'),
                  ),
                );
              })
            ],
          ),
        ));
  }
}
