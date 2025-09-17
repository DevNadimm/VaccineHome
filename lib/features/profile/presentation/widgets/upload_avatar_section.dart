import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vaccine_home/core/constants/colors.dart';

class UploadProfileImageSection extends StatelessWidget {
  final File? imageFile;
  final String? userAvatarUrl;
  final void Function(File?) onImagePicked;

  const UploadProfileImageSection({
    super.key,
    required this.imageFile,
    required this.onImagePicked,
    this.userAvatarUrl,
  });

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );

    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: AppColors.cardColorBold,
            backgroundImage: imageFile != null
                ? FileImage(imageFile!)
                : (userAvatarUrl != null && userAvatarUrl!.isNotEmpty)
                    ? CachedNetworkImageProvider('https://vcard.vaccinehomebd.com/storage/app/public/$userAvatarUrl')
                    : null,
            child: (imageFile == null && (userAvatarUrl == null || userAvatarUrl!.isEmpty))
                ? const Icon(Icons.person_rounded, size: 60, color: AppColors.white)
                : null,
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.white,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.primaryColor,
                child: Icon(
                  HugeIcons.strokeRoundedCamera02,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
