import 'package:animals/view/screens/user_profile/widgets/profile_picture_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase/supabase.dart';
import '../../../core/constants/presentation/app_colors.dart';
import '../../../core/exceptions/net_work_excptions.dart';
import '../../../core/routes/routes.dart';
import '../../../core/utils/dialogs/helper_dialogs.dart';
import '../../../providers/auth_providers/logout_provider.dart';
import '../../../providers/user_profile_provider/user_profile_provider.dart';
import '../../common/custom_button.dart';
import '../../common/custom_loading.dart';
import '../../common/custom_sizedBox.dart';
import '../../common/text_widgets.dart';



class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(getProfileProvider(context));
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: userProfile.when(
        skipLoadingOnReload: false,
        data: (data) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    color: AppColor.blackColor,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.center,
                              child: ProfilePictureBox(imageUrl: data.imageUrl)),
                          const Sized(height: 0.02,),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.updateUserProfile,
                                arguments: {
                                  'userModel':data
                                },
                              );
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: AppColor.disableColor,
                                  child: boldText(title: data.name[0], color: AppColor.blackColor),
                                ),
                                const SizedBox(width: 10),
                                mediumText(title: data.name,color: AppColor.whiteColor),
                              ],
                            ),
                          ),
                          const Sized(height: 0.02,),
                          Divider(color: AppColor.disableColor),
                          const Sized(height: 0.02,),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.updateUserDetails,
                                arguments: {
                                  'userModel':data
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.disableColor.withOpacity(0.1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  mediumText(title: "Description",color: AppColor.whiteColor),
                                  lightText(title: data.description, color: AppColor.whiteColor.withOpacity(0.7)),
                                  const SizedBox(height: 10),
                                  mediumText(title: "Phone",color: AppColor.whiteColor),
                                  lightText(title: data.phone, color: AppColor.whiteColor.withOpacity(0.7)),
                                  const SizedBox(height: 10),
                                  mediumText(title: "Location",color: AppColor.whiteColor),
                                  lightText(title: data.location, color: AppColor.whiteColor.withOpacity(0.7)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const  Sized(height: 0.03),
                  CustomButton(
                    title: 'Logout',
                    onTap: () {
                      DialogHelper.showLogoutOptions(
                        context: context,
                        ref: ref,
                        onLogout: (SignOutScope scope) {
                          ref.read(logoutProvider.notifier).logoutLocal(context: context, scope: scope);
                        },
                      );
                    },
                  ),
                  const  Sized(height: 0.03),
                  Consumer(builder: (context, ref, _) {
                    var data = ref.watch(logoutProvider.select((state)=> state.isDeleteAccount));
                    return data == true ? const CustomLoading() : CustomIconButton(
                      title: 'Delete Account',
                      onTap: () {
                        ref.read(logoutProvider.notifier).deleteUserAccount(context: context);
                      },
                      iconData: Icons.delete,
                      color: AppColor.errorColor,
                    );
                  }),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          print('error :$error');
          String errorMessage = ExceptionHandler.getMessage(error);
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 50),
                const SizedBox(height: 10),
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () =>
                      ref.invalidate(getProfileProvider), // Retry on error
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
