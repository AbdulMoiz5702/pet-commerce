import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/presentation/app_colors.dart';
import '../../../../providers/user_profile_provider/update_profile_provider.dart';

class ProfilePictureUpdateBox extends StatelessWidget {
  const ProfilePictureUpdateBox({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      var file = ref.watch(userProfileUpdate.select((state) => state.image));
      var imageUrl = ref.watch(userProfileUpdate.select((state) => state.imageUrl));
      return InkWell(
        onTap: (){
          ref.read(userProfileUpdate.notifier).pickAndUploadProfileImage(context);
        },
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[300],
          child: file != null
              ? ClipOval(
                  child: Image.file(
                    file,
                    width: 150,
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                )
              : imageUrl.isNotEmpty
                  ? ClipOval(
                      child: Image.network(
                        imageUrl,
                        width: 150,
                        height: 150,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.error,
                            size: 50,
                            color: AppColor.errorColor),
                      ),
                    )
                  : const Icon(Icons.person, size: 50, color: AppColor.blackColor),
        ),
      );
    });
  }
}
