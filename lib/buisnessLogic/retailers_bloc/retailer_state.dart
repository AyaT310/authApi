part of 'retailer_bloc.dart';

abstract class RetailerState {}

class RetailerInitial extends RetailerState {}

class RetailerLoading extends RetailerState {}

class RetailerLoaded extends RetailerState {
  final List<AllRetailersData>? mahmoud;

  RetailerLoaded(this.mahmoud);
}

class RetailerLoadingMore extends RetailerState {}

class RetailerDataError extends RetailerState {
  final String errorMessage;

  RetailerDataError(this.errorMessage);
}