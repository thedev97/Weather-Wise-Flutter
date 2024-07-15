import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_app/core/styles/font_styles.dart';
import 'package:flutter_weather_app/core/utilities/image_constants.dart';
import 'package:flutter_weather_app/core/utilities/neumorphic_widget.dart';
import 'package:flutter_weather_app/core/utilities/textfeild.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFf1ded0),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text('WEATHER WISE', style: FWFonts.regularFonts20),
          backgroundColor: Colors.transparent,
          elevation: 1,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 1.2 * kToolbarHeight, 20, 20),
          child: Column(
            children: [
              SearchTextField(
                controller: _searchController,
                hintText: 'ENTER CITY NAME',
                onSubmitted: (cityName) {
                  if (cityName.isNotEmpty) {
                    context
                        .read<WeatherBloc>()
                        .add(FetchWeatherByCity(cityName));
                  }
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<WeatherBloc, WeatherBlocState>(
                  builder: (context, state) {
                    if (state is WeatherBlocLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Color(0xFFf1ded0),
                          strokeWidth: 5,
                          color: Colors.amberAccent,
                        ),
                      );
                    } else if (state is WeatherBlocSuccess) {
                      return buildWeatherInfo(context, state);
                    } else if (state is WeatherBlocFailure) {
                      return Center(
                          child: Text(
                              'Failed to fetch weather data'.toUpperCase(),
                              style: FWFonts.errorMediumFonts20));
                    } else {
                      return Center(
                          child: Text(
                              'Enter a city name to fetch weather'
                                  .toUpperCase(),
                              style: FWFonts.errorMediumFonts20));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWeatherInfo(BuildContext context, WeatherBlocSuccess state) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.greeting.toUpperCase(), style: FWFonts.regularFonts12),
            const SizedBox(height: 8),
            Text('📍 ${state.weather.areaName?.toUpperCase()}',
                style: FWFonts.regularFonts16),
            const SizedBox(height: 30),
            Center(
                child: getWeatherIcon(state.weather.weatherConditionCode ?? 0)),
            const SizedBox(height: 30),
            Center(
                child: Text('${state.weather.temperature?.celsius?.round()}°C',
                    style: FWFonts.boldFonts40)),
            const SizedBox(height: 8),
            Center(
                child: Text('${state.weather.weatherMain?.toUpperCase()}',
                    style: FWFonts.semiBoldFonts22)),
            const SizedBox(height: 5),
            Center(
                child: Text(
                    DateFormat('EEEE dd •')
                        .add_jm()
                        .format(state.weather.date!),
                    style: FWFonts.regularFonts12)),
            const SizedBox(height: 30),
            buildWeatherDetails(state.weather),
          ],
        ),
      ),
    );
  }

  Widget buildWeatherDetails(Weather weather) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFf1ded0),
        boxShadow: const [
          BoxShadow(
              color: Colors.white,
              offset: Offset(-1, -1),
              blurRadius: 1,
              spreadRadius: 1),
          BoxShadow(
              color: Colors.black12,
              offset: Offset(1, 1),
              blurRadius: 1,
              spreadRadius: 1),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FEELS LIKE ${weather.tempFeelsLike?.celsius?.round()}°C',
              style: FWFonts.regularFonts16),
          const SizedBox(height: 10),
          const Divider(thickness: 1),
          const SizedBox(height: 10),
          buildSunriseSunsetRow(weather),
          const SizedBox(height: 10),
          const Divider(thickness: 1),
          const SizedBox(height: 10),
          Text('WIND: ${weather.windSpeed?.round()} km/h',
              style: FWFonts.regularFonts12),
          const SizedBox(height: 10),
          const Divider(thickness: 1),
          const SizedBox(height: 10),
          Text('PRESSURE: ${weather.pressure?.round()} hPa',
              style: FWFonts.regularFonts12),
          const SizedBox(height: 10),
          const Divider(thickness: 1),
          const SizedBox(height: 10),
          Text('HUMIDITY: ${weather.humidity?.round()}%',
              style: FWFonts.regularFonts12),
        ],
      ),
    );
  }

  Widget buildSunriseSunsetRow(Weather weather) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _weatherTimeInfo(
            scale: 3.0,
            img: FWImage.dayImg,
            title: 'SUNRISE',
            time: DateFormat().add_jm().format(weather.sunrise!)),
        _weatherTimeInfo(
            scale: 2.0,
            img: FWImage.nightImg,
            title: 'SUNSET',
            time: DateFormat().add_jm().format(weather.sunset!)),
      ],
    );
  }

  Widget _weatherTimeInfo(
      {String? img, double? scale, String? title, String? time}) {
    return Row(
      children: [
        Image.asset(img!, scale: scale),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title!, style: FWFonts.regularFonts12),
            const SizedBox(height: 5),
            Text(time!, style: FWFonts.regularFonts12),
          ],
        ),
      ],
    );
  }

  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return NeuContainer(
          child: Image.asset(
            FWImage.thunderStormImg,
            scale: 1,
          ),
        );
      case >= 300 && < 400:
        return NeuContainer(
          child: Image.asset(
            FWImage.rainyImg,
            scale: 1,
          ),
        );
      case >= 500 && < 600:
        return NeuContainer(
          child: Image.asset(
            FWImage.heavyRainyImg,
            scale: 1,
          ),
        );
      case >= 600 && < 700:
        return NeuContainer(
          child: Image.asset(
            FWImage.snowImg,
            scale: 1,
          ),
        );
      case >= 700 && < 800:
        return NeuContainer(
          child: Image.asset(
            FWImage.windyImg,
            scale: 1,
          ),
        );
      case == 800:
        return NeuContainer(
          child: Image.asset(
            FWImage.sunnyImg,
            scale: 1,
          ),
        );
      case > 800 && <= 804:
        return NeuContainer(
          child: Image.asset(
            FWImage.rainyImg,
            scale: 1,
          ),
        );
      default:
        return NeuContainer(
          child: Image.asset(
            FWImage.weatherClearImg,
            scale: 1,
          ),
        );
    }
  }

  Widget buildWeatherIcon(String imagePath) {
    return NeuContainer(
      child: Image.asset(imagePath, scale: 1),
    );
  }
}
