import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:vaccine_home/core/constants/colors.dart';
import 'package:vaccine_home/core/utils/widgets/custom_cached_image.dart';

class FullScreenImagePage extends StatelessWidget {
  static Route route({required String imageUrl}) => MaterialPageRoute(builder: (_) => FullScreenImagePage(imageUrl: imageUrl));

  final String imageUrl;

  const FullScreenImagePage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: IconButton(
          icon: const Icon(
            HugeIcons.strokeRoundedCancel01,
            color: AppColors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Vaccine Image',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: SizedBox.expand(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Center(
            child: SizedBox.expand(
              child: CustomCachedImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
