import 'package:flutter/material.dart';
import 'package:open_weather_widget/open_weather_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  String apiKey = "856822fd8e22db5e1ba48c0e7d69844a";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text("Weather Widget Example"),
        ),
        body: Center(
          child: OpenWeatherWidget(
            latitude: -27.593590057648644, 
            longitude: -48.55220481452433,
            location: "Florianópolis",
            height: 180,
            apiKey: apiKey,
            alignment: MainAxisAlignment.center,
            margin: EdgeInsets.all(5),
          ),
        ),
      ),
    );
  }
}
