import 'package:open_weather_widget/models/weather_model.dart';
import 'package:open_weather_widget/repository/weather_repo.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc {
  final WeatherRepository _repository = WeatherRepository();
  final BehaviorSubject<WeatherModel?> _subject =
      BehaviorSubject<WeatherModel?>();

  getWeather(
      {required double latitude,
      required double longitude,
      required String apiKey}) async {
    WeatherModel? response = await _repository.getWeather(
        latitude: latitude, longitude: longitude, apiKey: apiKey);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<WeatherModel?> get subject => _subject;
}

final weatherBloc = WeatherBloc();
