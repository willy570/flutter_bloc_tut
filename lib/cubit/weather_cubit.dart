import 'package:bloc/bloc.dart';
import 'package:flutter_cubit_bloc_tutorial/data/weather_repository.dart';
import 'package:meta/meta.dart';

import '../data/model/weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      emit(WeatherLoading());
      final weather = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    } on NetworkException {
      emit(WeatherError("Couldn't fecth weather. Is the device online?"));
    }
  }
}
