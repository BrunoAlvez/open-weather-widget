import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

IconData weatherIcon(int? weatherId) {
  String iconString = 'wa-na';
  switch (weatherId) {
    case 804:
      iconString = 'wi-cloudy';
      break;
    case 771:
    case 801:
    case 802:
    case 803:
      iconString = 'wi-cloudy-gusts';
      break;
    case 721:
      iconString = 'wi-day-haze';
      break;
    case 800:
      iconString = 'wi-day-sunny';
      break;
    case 731:
    case 761:
    case 762:
      iconString = 'wi-dust';
      break;
    case 741:
      iconString = 'wi-fog';
      break;
    case 906:
      iconString = 'wi-hail';
      break;
    case 904:
      iconString = 'wi-hot';
      break;
    case 902:
      iconString = 'wi-hurricane';
      break;
    case 210:
    case 211:
    case 212:
    case 221:
      iconString = 'wi-lightning';
      break;
    case 302:
    case 311:
    case 312:
    case 314:
    case 501:
    case 502:
    case 503:
    case 504:
      iconString = 'wi-rain';
      break;
    case 310:
    case 511:
    case 611:
    case 612:
    case 615:
    case 616:
    case 620:
      iconString = 'wi-rain-mix';
      break;
    case 313:
    case 520:
    case 521:
    case 522:
    case 701:
      iconString = 'wi-showers';
      break;
    case 602:
      iconString = 'wi-sleet';
      break;
    case 711:
      iconString = 'wi-smoke';
      break;
    case 600:
    case 601:
    case 621:
    case 622:
      iconString = 'wi-snow';
      break;
    case 903:
      iconString = 'wi-snowflake-cold';
      break;
    case 300:
    case 301:
    case 321:
    case 500:
      iconString = 'wi-sprinkle';
      break;
    case 531:
    case 901:
      iconString = 'wi-storm-showers';
      break;
    case 957:
      iconString = 'wi-strong-wind';
      break;
    case 200:
    case 201:
    case 202:
    case 230:
    case 231:
    case 232:
      iconString = 'wi-thunderstorm';
      break;
    case 781:
    case 900:
      iconString = 'wi-tornado';
      break;
    case 905:
      iconString = 'wi-windy';
      break;
  }

  return WeatherIcons.fromString(iconString, fallback: WeatherIcons.na);
}

String translateWeather(String description) {
  switch (description) {
    case 'clear sky':
      return 'céu limpo';
    case 'scattered clouds':
      return 'nuvens espalhadas';
    case 'broken clouds':
      return 'nuvens isoladas';
    case 'few clouds':
      return 'poucas nuvens';
    case 'overcast clouds':
      return 'nublado';
    case 'light rain':
      return 'chuva suave';
    case 'heavy rain':
      return 'chuva forte';
    case 'rainy':
      return 'chuvoso';
    case 'rain':
      return 'chuva';
    case 'moderate rain':
      return 'chuva moderada';
    default:
      return 'impreciso';
  }
}
