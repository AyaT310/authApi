import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../buisnessLogic/retailers_bloc/retailer_bloc.dart';
import '../../data/models/all_retailers_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RetailersWidget extends StatelessWidget {
  final List<AllRetailersData>? allRetailerdata;

  const RetailersWidget({
    super.key,
    required this.allRetailerdata,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 25,
            child: Text(
              AppLocalizations.of(context)!.allretailers,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800),
            ),
          ),
          Expanded(
            child: ListView.builder(
                controller: context.read<RetailerBloc>().scrollController,
                itemCount: allRetailerdata!.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.network(
                          allRetailerdata![index].logo?.path ?? "",
                          fit: BoxFit.fill,
                          height: 110,
                          width: 200,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          allRetailerdata![index].name ?? '',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        // const Divider(thickness: 1,)

                      ],
                    ),
                  );
                }),
          ),
          BlocBuilder<RetailerBloc, RetailerState>(
              builder: (context, state) {
                return state is RetailerLoadingMore ? const Center(
                  child: CircularProgressIndicator(),
                ) : SizedBox.shrink();
              }
          ),
        ],
      ),
    );
  }
}
