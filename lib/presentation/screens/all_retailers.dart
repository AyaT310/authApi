import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../buisnessLogic/retailers_bloc/retailer_bloc.dart';
import '../widgets/retailers.dart';

class AllRetailersScreen extends StatefulWidget {
  const AllRetailersScreen({super.key});

  @override
  State<AllRetailersScreen> createState() => _AllRetailersScreenState();
}

class _AllRetailersScreenState extends State<AllRetailersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RetailerBloc>(context).add(FetchRetailerEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RetailerBloc, RetailerState>(
        buildWhen: (prev, current) =>
            prev != current && current is RetailerLoaded,
        builder: (context, state) {
          return state is RetailerLoaded
              ? RetailersWidget(allRetailerdata: state.mahmoud ?? [])
              : state is RetailerLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
