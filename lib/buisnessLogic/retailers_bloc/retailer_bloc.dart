import 'dart:async';
import 'package:auth_api/data/models/all_retailers_model.dart';
import 'package:auth_api/data/repository/api_retailers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'retailer_event.dart';

part 'retailer_state.dart';

class RetailerBloc extends Bloc<RetailerEvent, RetailerState> {
  List<AllRetailersData> aya = [];
  int page = 1;
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  Pagination? pagination;

  final ApiRetailers _apiRetailers;

  RetailerBloc(this._apiRetailers) : super(RetailerInitial()) {
    _attachListening();
    on<FetchRetailerEvent>(_fetchData);
    on<LoadMoreEvent>(_fetchMoreData);
  }

  Future<void> _fetchData(
      RetailerEvent event, Emitter<RetailerState> emit) async {
    emit(RetailerLoading());
    // aya.clear();
    page = 1;
    print('FSSSSS Fetch Data');
    try {
      final AllRetailers response = await _apiRetailers.fetchData(page);

      if (response != null) {
        pagination = response.retailerdata?.myRetailers?.pagination;
        aya = [
          ...response.retailerdata!.myRetailers!.allRetailersdata!,
        ].toSet().toList();
        emit(RetailerLoaded(aya));
      }
    } catch (e) {
      print(e);
      emit(RetailerDataError('Failed to fetch retailers.'));
    }
  }

  Future<void> _fetchMoreData(
      RetailerEvent event, Emitter<RetailerState> emit) async {
    emit(RetailerLoadingMore());
    print('FSSSSS Fetch More Data');

    try {
      final AllRetailers response = await _apiRetailers.fetchData(page);

      print('FSSSSS Fetch More Data $page');

      if (response != null) {
        pagination = response.retailerdata?.myRetailers?.pagination;
        aya = [
          ...aya,
          ...response.retailerdata!.myRetailers!.allRetailersdata!,
        ].toSet().toList();
        emit(RetailerLoaded(aya));
      }
    } catch (e) {
      print(e);
      emit(RetailerDataError('Failed to fetch retailers.'));
    }
  }

  _attachListening() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        pagination!.currentPage = page;
        if(pagination!.currentPage! <= pagination!.totalPages!.toInt()){
          isLoadingMore = true;
          page++;

          print(page);
          add(LoadMoreEvent());
        } else {
          print("no more data");
        }
      }
    });
  }

  // void _dispose (){
  //   scrollController.removeListener(() {
  //     scrollController.dispose();
  //   });
  // }
}
