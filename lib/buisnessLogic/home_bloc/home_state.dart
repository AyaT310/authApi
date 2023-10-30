part of 'home_bloc.dart';

abstract class HomeState {}

class HomeDataInitial extends HomeState {}

class DataLoading extends HomeState {}

class DataLoaded extends HomeState {
  final HomeData data;

  DataLoaded(this.data);
}

class DataError extends HomeState {
  final String errorMessage;

  DataError(this.errorMessage);
}