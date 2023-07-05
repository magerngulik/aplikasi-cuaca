import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:perkiraan_cuaca/data/model/weather_model.dart';

class WeatherServices {
  String baseUrl = "http://api.weatherapi.com/v1";

  Future<Either<String, Weather>> getWeather() async {
    Position position = await Geolocator.getCurrentPosition();
    var latitude = position.latitude;
    var longitude = position.longitude;

    try {
      final response = await Dio().get(
          "$baseUrl/current.json?key=99177a6f35934c48b7d124924230507&q=$latitude,$longitude");

      return Right(Weather.fromJson(response.data));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
