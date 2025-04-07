import 'package:flutter/material.dart';
import '../../../../core/constants/presentation/app_colors.dart';


class ProfilePictureBox extends StatelessWidget {
  final String imageUrl ;
  const ProfilePictureBox({super.key, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: MediaQuery.sizeOf(context).height *  0.25,
      width: MediaQuery.sizeOf(context).width *  0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: imageUrl.isNotEmpty ? Image.network(
        isAntiAlias: true,
        imageUrl,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 50, color: AppColor.errorColor),) : const Icon(Icons.person, size: 50, color: AppColor.whiteColor),
    );
  }
}
