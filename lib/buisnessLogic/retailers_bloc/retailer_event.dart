part of 'retailer_bloc.dart';

abstract class RetailerEvent {}

class FetchRetailerEvent extends RetailerEvent {}

class LoadMoreEvent extends RetailerEvent {}