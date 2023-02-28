import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  final TextEditingController _textFieldController = TextEditingController();

  Future<void> _fetchWeatherData() async {
    var response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey'));
    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
        print(weatherData);
      });

      _textFieldController.clear();
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Form(
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: TextFormField(
                          onChanged: (value) {
                            location = value;
                            // placeAutocomplete(value);
                          },
                          controller: _textFieldController,
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintText: 'Enter Location',
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SvgPicture.asset(
                                'assets/icons/location.svg',
                                // color: secondaryColor40LightTheme,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: _fetchWeatherData,
                      icon: const Icon(Icons.search)),
                  // ElevatedButton.icon(
                  //   onPressed: _fetchWeatherData,
                  //   icon: Icon.sea,
                  //   label: const Text('Search'),
                  // ),
                ],
              ),

              // TextField(
              //   controller: _textFieldController,
              //   onChanged: (value) {
              //     location = value;
              //   },
              //   // onSubmitted: _fetchWeatherData,
              // ),

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
      ),
    );
  }
}
