import 'package:flutter/material.dart';
import '../../data/models/home_model.dart';

class Offers extends StatelessWidget {
  final List<TopAds>? data;
  const Offers({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Special Offers",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800)),
        const SizedBox(
          height: 18,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data!.length,
            itemBuilder: (context, index) {
              return Stack(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.network(
                          data?[index].image?.path ?? '',
                          fit: BoxFit.fill,
                          width: 270,
                        height: 160,
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data?[index].name ?? "", softWrap: true,
                        // overflow: TextOverflow.ellipsis,
                        style:
                        const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Shop Now",
                            style: TextStyle(
                                fontSize: 18, color: Colors.black),
                          )),
                    ],
                  ),
                ),
              ]);
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
