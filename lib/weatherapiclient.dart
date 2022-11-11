import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myweatherapp/weathermodel.dart';

class WeatherApiClient{
  Future<Weather>? getCurrentWeather(String? location) async{
    var endpoint = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=f024a36bd311c76750be711f1c8b0c0e");

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    print(Weather.fromJson(body).cityName);
    return Weather.fromJson(body);
  }
}