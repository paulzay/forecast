import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

final dio = Dio();

void main() {
  runApp(
    const MaterialApp(
      title: 'GEOSEARCH',
      home: Home(),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  void getWeather() async {
    const apiKey = 'b34fddd3dae4a2eb0ad363b62f98ba1e';
    const cityName = 'London';
    const url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';
    final response = await dio.get(url);
    print(response);
  }

  void handleChange() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
        leading: const IconButton(
          icon: Icon(Icons.search),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
      ),
    );
  }
}
