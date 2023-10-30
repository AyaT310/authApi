import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../data/models/home_model.dart';
import '../../data/repository/api_home.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiHome _apiHome;

  HomeBloc(this._apiHome) : super(HomeDataInitial()) {
    on<FetchDataEvent>(_fetchData);
  }

  Future<void> _fetchData(HomeEvent event, Emitter<HomeState> emit) async {
    emit(DataLoading());

    try {
      final HomeData response = await _apiHome.fetchData();
      response.data?.bonus?.forEach((element) {
        print('FSSSS ${element.expirationDate} - ${element.name}');
      });

      if (response != null) {
        emit(DataLoaded(response));
      }
    } catch (e) {
      print(e);
      emit(DataError('Failed to fetch ads.'));
    }
  }
}
