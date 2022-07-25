import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_weather_widget/helpers/formater.dart';
import 'package:open_weather_widget/helpers/weather_helper.dart';
import 'package:open_weather_widget/helpers/string_utils.dart';
import 'package:open_weather_widget/models/weather_model.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({
    super.key,
    required location,
    required weatherBloc,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.alignment,
    this.locationColor,
    this.descriptionWeatherColor,
    this.color,
    this.temperatureColor,
    this.weatherTextColor,
    this.activeColor,
    this.iconColor,
    this.borderRadius,
    this.activeBorderRadius,
    this.locationTextStyle,
    this.weatherDetailsTextStyle,
    this.temperatureTextStyle,
    this.weekdayTextStyle,
    this.maxTemperatureTextStyle,
    this.minTemperatureTextStyle,
    this.temperatureScaleTextStyle,
    this.reloadTime
  }) : 
    _location = location,
    _weatherBloc = weatherBloc;

  final _location;
  final _weatherBloc;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final MainAxisAlignment? alignment;
  final Color? locationColor;
  final Color? descriptionWeatherColor;
  final Color? color;
  final Color? temperatureColor;
  final Color? weatherTextColor;
  final Color? activeColor;
  final Color? iconColor;
  final BorderRadiusGeometry? borderRadius;
  final BorderRadiusGeometry? activeBorderRadius;
  final TextStyle? locationTextStyle;
  final TextStyle? weatherDetailsTextStyle;
  final TextStyle? temperatureTextStyle;
  final TextStyle? weekdayTextStyle;
  final TextStyle? maxTemperatureTextStyle;
  final TextStyle? minTemperatureTextStyle;
  final TextStyle? temperatureScaleTextStyle;
  final Duration? reloadTime;

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late Stream<Object?> stream;
  late DateTime lastWeatherContainerRefresh;
  String? currentTemp = "25";
  String? todayTemp = "25";
  int? index = 0;

  @override
  void initState() {
    super.initState();

    stream = widget._weatherBloc.subject.stream;
    lastWeatherContainerRefresh = DateTime.now();
    if (widget.reloadTime != null) {
      Timer.periodic(widget.reloadTime!, (Timer timer) {
        refreshWeatherContainer();
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && widget._location != null) {
          WeatherModel data = snapshot.data as WeatherModel;
          todayTemp = data.current.temp.toString();
          
          return containerWeather(context, snapshot, data);
        }
        return Container();
      }
    );
  }

  /*
   * Builds the weather container
   */
  Container containerWeather(BuildContext context, AsyncSnapshot<Object?> snapshot, WeatherModel data) {
    return Container(
      height: widget.height == null || widget.height! < 240 ? 240 : widget.height,
      width: widget.width ?? MediaQuery.of(context).size.width,
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 14, vertical: 3),
      margin: widget.margin ?? EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: widget.color ?? Colors.white,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: widget.alignment ?? MainAxisAlignment.center,
        children: <Widget>[
          activeWeatherDetail(snapshot, data),
          const SizedBox(height: 10),
          weatherDayWidget(data),
          buildRefreshWeatherButton()
        ]
      )
    );
  }

  /* 
   * Shows details about the active weather 
   */
  Row activeWeatherDetail(AsyncSnapshot<Object?> snapshot, WeatherModel data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget._location,
              style: widget.locationTextStyle ?? TextStyle(
                fontSize: 23,
                color: widget.locationColor ?? Colors.grey[800]
              )
            ),
            humidityAndWind(snapshot.data, index),
          ]
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: <Widget>[
            Text(
              "${currentTemp!.substring(0, 2) == "25" ? data.current.temp.toString().substring(0, 2) : currentTemp!.substring(0, 2)}",
              style: widget.temperatureTextStyle ?? TextStyle(
                fontSize: 59,
                color: widget.temperatureColor ?? Colors.grey[700],
                fontWeight: FontWeight.w300,
                fontFamily: "Poppin",
                height: 1
              )
            ),
            Text(
              "°C",
              style: widget.temperatureScaleTextStyle ?? TextStyle(
                fontSize: 15,
                color: widget.temperatureColor ?? Colors.grey[700]
              )
            )
          ]
        )
      ]
    );
  }

  Widget humidityAndWind(data, index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "${translateWeather(data.daily[index].weather[0].description.toString()).toTitleCase()} / Humidade: ${data.daily[index].humidity.toString()}%",
          style: widget.weatherDetailsTextStyle ?? TextStyle(
            fontSize: 12,
            color: widget.descriptionWeatherColor
          )
        ),
        Text(
          "Vento: ${(data.daily[index].windSpeed * 3.6).toString().substring(0, 2)} km/h",
          style: widget.weatherDetailsTextStyle ?? TextStyle(
            fontSize: 12,
            height: 1.5,
            color: widget.descriptionWeatherColor
          )
        )
      ]
    );
  }

  Widget weatherDayWidget(WeatherModel? weather) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: weather!.daily.length,
        itemBuilder: (context, index) {
          var data = weather.daily;
          bool currentDay = DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(data[index].dt * 1000)) ==
              DateFormat('yyyy-MM-dd').format(DateTime.now());
          return _columnBuilder(
            index: index,
            day: currentDay
                ? "Hoje"
                : DateFormat('EEEE', 'pt_Br').format(DateTime.fromMillisecondsSinceEpoch(data[index].dt * 1000)).substring(0, 3),
            max: data[index].temp.max.toString().substring(0, 2),
            min: data[index].temp.min.toString().substring(0, 2),
            weatherId: data[index].weather[0].id,
            isToday: currentDay ? true : false,
            current: currentDay ? todayTemp : data[index].temp.max.toString().substring(0, 2),
          );
        },
      ),
    );
  }

  Widget _columnBuilder({int? index, String? day, String? max, String? min, int? weatherId, bool? isToday, String? current}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentTemp = current;
          this.index = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          decoration: this.index == index ? BoxDecoration(
            color: widget.activeColor ?? Colors.grey[100],
            borderRadius: widget.activeBorderRadius ?? BorderRadius.circular(5)
          ) : null,
          child: Column(
            children: [
              Text(
                day!.toUpperCase(),
                style: widget.weekdayTextStyle ?? TextStyle(
                  fontSize: 11,
                  fontFamily: "Poppins",
                  color: widget.weatherTextColor ?? Colors.black,
                )
              ),
              SizedBox(
                height: 60,
                child: Image(
                  image: AssetImage(
                    weatherIcon(weatherId), 
                    package: 'open_weather_widget',
                  )
                )
              ),
              RichText(
                overflow: TextOverflow.visible,
                  text: TextSpan(children: [
                TextSpan(
                    text: " $max° ",
                    style: widget.maxTemperatureTextStyle ??
                        TextStyle(
                          fontSize: 12,
                          color: widget.weatherTextColor ?? Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins"
                        )),
                TextSpan(
                    text: " $min° ",
                    style: widget.minTemperatureTextStyle ??
                        TextStyle(
                          fontSize: 12,
                          color: widget.weatherTextColor ?? Colors.black,
                          fontWeight: FontWeight.w300,
                          fontFamily: "Poppins"
                        ))
              ])),
            ],
          ),
        ),
      ),
    );
  }

  Column buildRefreshWeatherButton() {
    return Column(
      children: <Widget>[
        TextButton.icon(
          onPressed: refreshWeatherContainer, 
          icon: Icon(
            Icons.refresh,
            size: 10,
            color: widget.temperatureColor ?? Colors.grey,
          ),
          label: Text(
            'Recarregar',
            style: TextStyle(
              color: widget.temperatureColor ?? Colors.grey,
              fontSize: 10
            )
          )
        ),
        Text(
          'Atualizado pela última vez às ${Formater.toHourMin(lastWeatherContainerRefresh)}',
          style: TextStyle(
            color: widget.temperatureColor ?? Colors.grey,
            fontSize: 10
          )
        )
      ]
    );
  }

  void refreshWeatherContainer() {
    setState(() {
      stream = widget._weatherBloc.subject.stream;
      lastWeatherContainerRefresh = DateTime.now();
    });
  }

}