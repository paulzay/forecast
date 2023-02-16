class Weather {
  Weather({
    required this.id,
    required this.description,
    required this.name,
    required this.speed,
    required this.temp,
    required this.humidity,
  });

  int id;
  int humidity;
  String name;
  String description;
  double speed;
  double temp;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["weather"][0]["id"],
        description: json["weather"][0]["description"],
        name: json["name"],
        speed: json["wind"]["speed"],
        temp: json["main"]["temp_min"],
        humidity: json["main"]["humidity"],
      );
}
