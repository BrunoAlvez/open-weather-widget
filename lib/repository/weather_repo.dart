import 'package:open_weather_widget/bloc/weather_provider.dart';
import 'package:open_weather_widget/models/weather_model.dart';

class WeatherRepository {
  WeatherApiProvider _apiProvider = WeatherApiProvider();

  Future<WeatherModel?> getWeather(
      {required double latitude,
      required double longitude,
      required String apiKey}) {
    return _apiProvider.getWeather(
        latitude: latitude, longitude: longitude, apiKey: apiKey);
  }
}
