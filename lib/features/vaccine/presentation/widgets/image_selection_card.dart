import 'package:flutter/material.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/custom_cached_image.dart';

class ImageSelectionCard extends StatelessWidget {
  final String image;
  final bool isSelected;

  const ImageSelectionCard({
    super.key,
    required this.image,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          width: isSelected ? 2 : 1,
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CustomCachedImage(
          imageUrl: image,
          height: 80,
          width: 60,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
