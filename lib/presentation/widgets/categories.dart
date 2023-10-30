import 'package:auth_api/config/router/app_route.dart';
import 'package:flutter/material.dart';
import '../../data/models/home_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Categories extends StatelessWidget {
  final List<RetailersCategories> retailerCat;
  const Categories({super.key, required this.retailerCat});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.categoryshop,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800),
        ),
        ListView.builder(
          itemCount: retailerCat.take(4).toList().length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: Image.network(retailerCat[index].image?.path ?? ''),
                  title: Text(retailerCat[index].name ?? "",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                      ),
                  ),
                ),
                const Divider(thickness: .5),
              ],
            );
          },
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {
                // Navigator.pushNamed(context, AppRoutes.ALLCATEGORIES);
              },
              child: const Text("See More",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 16, 98, 92))),
            ),
            const Icon(Icons.keyboard_arrow_down,
                color: Color.fromARGB(255, 16, 98, 92))
          ],
        ),
      ],
    );
  }
}
