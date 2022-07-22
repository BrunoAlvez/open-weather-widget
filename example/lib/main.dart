import 'package:flutter/material.dart';
import 'package:open_weather_widget/open_weather_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  String apiKey = "856822fd8e22db5e1ba48c0e7d69844a";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text("Weather Widget Example"),
        ),
        body: Center(
          child: OpenWeatherWidget(
            latitude: 22.550460,
            longitude: 88.347311,
            location: "Kolkata",
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
