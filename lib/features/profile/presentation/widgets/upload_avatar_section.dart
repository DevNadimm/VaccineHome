import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path_provider/path_provider.dart';
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

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final imgFile = await picker.pickImage(source: ImageSource.gallery);

    if (imgFile != null) {
      final compressedImg = await _compressImage(imgFile);
      onImagePicked(File(compressedImg.path));
    }
  }

  Future<XFile> _compressImage(XFile img) async {
    final bytes = await img.readAsBytes();
    final sizeInMB = bytes.lengthInBytes / (1024 * 1024);
    debugPrint("Current size: ${sizeInMB.toStringAsFixed(2)} MB");

    final dir = await getTemporaryDirectory();
    final targetPath = "${dir.path}/compressed_image.jpeg";
    debugPrint("Target path: $targetPath");

    final compressedImg = await FlutterImageCompress.compressAndGetFile(
      img.path,
      targetPath,
      minHeight: 1080,
      minWidth: 1080,
      quality: 60,
      format: CompressFormat.jpeg,
    );

    if (compressedImg != null) {
      final compressedBytes = await compressedImg.readAsBytes();
      final compressedSizeInMB = compressedBytes.lengthInBytes / (1024 * 1024);
      debugPrint("Compressed size: ${compressedSizeInMB.toStringAsFixed(2)} MB");
    }

    return compressedImg ?? img;
  }
}
