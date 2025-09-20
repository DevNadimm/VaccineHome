import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vaccine_home/core/utils/widgets/custom_cached_image.dart';

class AdvertisementCarouselSlider extends StatelessWidget {
  final List<String> imageUrls;

  const AdvertisementCarouselSlider({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 220,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.92,
        aspectRatio: 16 / 9,
        autoPlayInterval: const Duration(seconds: 6),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      items: imageUrls.map(
        (url) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: CustomCachedImage(
              imageUrl: url,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          );
        },
      ).toList(),
    );
  }
}
