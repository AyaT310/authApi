import 'package:auth_api/data/models/home_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AdsSlider extends StatefulWidget {
  final List<TopAds>? data;

  const AdsSlider({super.key,
    required this.data,
  });

  @override
  State<AdsSlider> createState() => _AdsSliderState();
}

class _AdsSliderState extends State<AdsSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Material(
          // elevation: 1,
          borderRadius: BorderRadius.circular(20),
          child: CarouselSlider(
            items: (widget.data ?? [])
                .map(
                  (item) => Container(
                padding: const EdgeInsets.all(5),
                child: Image.network(
                  item.image?.path ?? '',
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
            ).toList(),
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.5,
              viewportFraction: 1,
            ),
          ),
        ),
      ],
    );
  }
}
