import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_app/core/styles/font_styles.dart';
import 'package:flutter_weather_app/core/utilities/image_constants.dart';
import 'package:flutter_weather_app/core/utilities/neumorphic_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            padding:
                const EdgeInsets.fromLTRB(20, 1.2 * kToolbarHeight, 20, 20),
            child: BlocBuilder<WeatherBloc, WeatherBlocState>(
              builder: (context, state) {
                if (state is WeatherBlocSuccess) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('📍 ${state.weather.areaName?.toUpperCase()}',
                            style: FWFonts.regularFonts16),
                        const SizedBox(height: 8),
                        Text('GOOD MORNING', style: FWFonts.mediumFonts20),
                        const SizedBox(height: 30),
                        Center(
                            child: getWeatherIcon(
                                state.weather.weatherConditionCode ?? 0)),
                        const SizedBox(height: 30),
                        Center(child: Text('32°C', style: FWFonts.boldFonts40)),
                        const SizedBox(height: 8),
                        Center(
                            child:
                                Text('SUNNY', style: FWFonts.semiBoldFonts22)),
                        const SizedBox(height: 5),
                        Center(
                            child: Text('SUNDAY 14• 09:41 AM',
                                style: FWFonts.regularFonts12)),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  FWImage.dayImg,
                                  scale: 3,
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('SUNRISE',
                                        style: FWFonts.regularFonts16),
                                    const SizedBox(height: 3),
                                    Text('04:30 AM',
                                        style: FWFonts.regularFonts12),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  FWImage.nightImg,
                                  scale: 2,
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('SUNSET',
                                        style: FWFonts.regularFonts16),
                                    const SizedBox(height: 3),
                                    Text('05:30 PM',
                                        style: FWFonts.regularFonts12),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Image.asset(
                                FWImage.hotTempImg,
                                scale: 3,
                              ),
                              const SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('TEMP MAX',
                                      style: FWFonts.regularFonts16),
                                  const SizedBox(height: 3),
                                  Text("16°C", style: FWFonts.regularFonts12),
                                ],
                              )
                            ]),
                            Row(children: [
                              Image.asset(
                                FWImage.coldTempImg,
                                scale: 3,
                              ),
                              const SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('TEMP MIN',
                                      style: FWFonts.regularFonts16),
                                  const SizedBox(height: 3),
                                  Text("8°C", style: FWFonts.regularFonts12),
                                ],
                              )
                            ])
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )),
      ),
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
}
