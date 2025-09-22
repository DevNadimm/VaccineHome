import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vaccine_home/core/utils/widgets/custom_cached_image.dart';

class AdvertisementCarouselSlider extends StatelessWidget {
  final List<String> imageUrls;

  const AdvertisementCarouselSlider({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    final bool singleImage = imageUrls.length <= 1;

    return CarouselSlider(
      options: CarouselOptions(
        height: 220,
        autoPlay: !singleImage,
        enableInfiniteScroll: !singleImage,
        viewportFraction: 0.92,
        enlargeCenterPage: !singleImage,
        aspectRatio: 16 / 9,
        autoPlayInterval: const Duration(seconds: 6),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        scrollPhysics: singleImage ? const NeverScrollableScrollPhysics() : null,
      ),
      items: imageUrls.map((url) {
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
