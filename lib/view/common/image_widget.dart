import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/presentation/app_colors.dart';


class ImageWidget extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final File? imageFile;
  final BoxFit fit;
  const ImageWidget({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.imageFile,
    this.fit = BoxFit.fill,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: fit,
        placeholder: (context, url) => const Center(
          child: Icon(
            Icons.image,
            color: Colors.grey,
            size: 40,
          ),
        ),
        errorWidget: (context, url, error) => _buildErrorWidget(),
      );
    } else if (assetPath != null && assetPath!.isNotEmpty) {
      return Image.asset(
        assetPath!,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else if (imageFile != null) {
      return Image.file(
        imageFile!,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else {
      return _buildErrorWidget();
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      color: AppColor.secondaryColor,
      alignment: Alignment.center,
      child: const Icon(
        Icons.error_outline,
        color: AppColor.blackColor,
        size: 40,
      ),
    );
  }
}

