import 'package:auth_api/controller/home_bloc/home_bloc.dart';
import 'package:auth_api/presentation/widgets/bonus.dart';
import 'package:auth_api/presentation/widgets/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/carousel_slider.dart';
import '../widgets/offers.dart';
import '../widgets/retailer_item.dart';
import '../widgets/search_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key, Object? accesstoken});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(FetchDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return state is DataLoaded
              ? Container(
                  padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 50,
                          child: SearchBarWidget(),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        AdsSlider(
                          data: state.data.data?.topAds ?? [],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RetailerItem(retailer: state.data.data?.retailers ?? []),
                        const SizedBox(
                          height: 15,
                        ),
                        Categories(retailerCat: state.data.data?.retailersCategories ?? []),
                        const SizedBox(
                          height: 15,
                        ),
                        EarnBonus(bonus: state.data.data?.bonus ?? []),
                        const SizedBox(
                          height: 20,
                        ),
                        Offers(
                          data: state.data.data?.topAds ?? [],
                        ),
                      ],
                    ),
                  ),
                )
              : state is DataLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
