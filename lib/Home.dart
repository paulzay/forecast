import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weatherapp/constants.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  String? location = 'Nairobi';
  String? apiKey = 'b34fddd3dae4a2eb0ad363b62f98ba1e';
  Map weatherData = {};

  Future<void> _fetchWeatherData() async {
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey'));
    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
      });
      print(weatherData);
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                onChanged: (value) {
                  location = value;
                },
              ),
            ),
            ElevatedButton(
              onPressed: _fetchWeatherData,
              child: const Text('Get Weather'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('${weatherData['name']}'),
            const SizedBox(
              height: 20,
            ),
            Text('${weatherData['main']['temp']} °F'),
            const SizedBox(
              height: 20,
            ),
            Image.network(
                'https://openweathermap.org/img/w/${weatherData['weather'][0]['icon']}.png'),
            Text('${weatherData['weather'][0]['description']}'),
          ],
        ),
      ),
    );
  }
}
