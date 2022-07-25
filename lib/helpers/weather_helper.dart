String weatherIcon(int? weatherId) {
  String iconString = 'wa-na';
  switch (weatherId) {
    case 804:
      iconString = 'assets/img/icons8-dia-parcialmente-nublado-100.png';
      break;
    case 771:
    case 801:
    case 802:
    case 803:
      iconString = 'assets/img/icons8-clima-ventoso-100.png';
      break;
    case 721:
      iconString = 'assets/img/icons8-dia-de-nevoeiro-100.png';
      break;
    case 800:
      iconString = 'assets/img/icons8-sol-100.png';
      break;
    case 731:
    case 761:
    case 762:
      iconString = 'assets/img/icons8-poeira-100.png';
      break;
    case 711:
    case 741:
      iconString = 'assets/img/icons8-fog-100.png';
      break;
    case 906:
      iconString = 'assets/img/icons8-granizo-100.png';
      break;
    case 904:
      iconString = 'assets/img/icons8-verão-100.png';
      break;
    case 902:
      iconString = 'assets/img/icons8-hurricane-100.png';
      break;
    case 210:
    case 211:
    case 212:
    case 221:
      iconString = 'assets/img/icons8-nuvem-com-raios-100.png';
      break;
    case 302:
    case 311:
    case 312:
    case 314:
    case 501:
    case 502:
    case 503:
    case 504:
      iconString = 'assets/img/icons8-chuva-100.png';
      break;
    case 310:
    case 511:
    case 611:
    case 612:
    case 615:
    case 616:
    case 620:
      iconString = 'assets/img/icons8-chuva-com-neve-100.png';
      break;
    case 313:
    case 520:
    case 521:
    case 522:
    case 701:
      iconString = 'assets/img/icons8-aguaceiro-100.png';
      break;
    case 602:
      iconString = 'assets/img/icons8-chuva-pesada-100.png';
      break;
    case 600:
    case 601:
    case 621:
    case 622:
      iconString = 'assets/img/icons8-neve-100.png';
      break;
    case 903:
      iconString = 'assets/img/icons8-inverno-100.png';
      break;
    case 300:
    case 301:
    case 321:
    case 500:
      iconString = 'assets/img/icons8-chuva-leve-100.png';
      break;
    case 531:
    case 901:
      iconString = 'assets/img/icons8-storm-with-heavy-rain-100.png';
      break;
    case 957:
      iconString = 'assets/img/icons8-vento-100.png';
      break;
    case 200:
    case 201:
    case 202:
    case 230:
    case 231:
    case 232:
      iconString = 'assets/img/icons8-tempestade-100.png';
      break;
    case 781:
    case 900:
      iconString = 'assets/img/icons8-tornado-100.png';
      break;
    case 905:
      iconString = 'assets/img/icons8-biruta-100.png';
      break;
  }

  return iconString;
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
