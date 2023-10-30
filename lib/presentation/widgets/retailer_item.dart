import 'package:flutter/material.dart';
import '../../data/models/home_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RetailerItem extends StatelessWidget {
  final List<Retailers> retailer;
  const RetailerItem({super.key,
    required this.retailer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 25,
          child: Text(
            AppLocalizations.of(context)!.retailers,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .21,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: ListView.builder(
              // padding: EdgeInsets.symmetric(horizontal: 30),
              scrollDirection: Axis.horizontal,
              itemCount: retailer.length,
              itemBuilder: (context, index) {
                final image = retailer[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(image.logo?.path ?? "",
                      fit: BoxFit.fill,
                        height: 110,
                        width: 200,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        retailer[index].name ?? '',
                        style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                  ),
                    ],
                  ),
                );
              },
            )
          ),
        ),
      ],
    );
  }
}