part of 'weather_bloc.dart';

sealed class WeatherBlocState extends Equatable{
  const WeatherBlocState();

  @override
  List<Object?> get props => [];
}


final class WeatherBlocInitial extends WeatherBlocState {}
final class WeatherBlocLoading extends WeatherBlocState {}
final class WeatherBlocFailure extends WeatherBlocState {}

final class WeatherBlocSuccess extends WeatherBlocState {
  final Weather weather;
  final String greeting;
  const WeatherBlocSuccess(this.weather, this.greeting);

  @override
  List<Object?> get props => [weather, greeting];
}

