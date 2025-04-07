import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase/supabase.dart';
import '../../../view/common/custom_button.dart';
import '../../../view/common/custom_sizedBox.dart';
import '../../../view/common/text_widgets.dart';
import '../../constants/presentation/app_colors.dart';


class DialogHelper {

  static void showLogoutOptions({
    required BuildContext context,
    required WidgetRef ref,
    required void Function(SignOutScope scope) onLogout,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor.disableColor,
          title:  mediumText(title: 'Logout'),
          content:  lightText(title: 'Do you want to log out only from this device or from all devices?'),
          actions: [
            CustomIconButton(
              title: 'This Device',
              onTap: () {
                Navigator.pop(context);
                onLogout(SignOutScope.local);
              },
              color: AppColor.warningSecondaryColor,
              iconData: Icons.exit_to_app,
            ),
            const Sized(height: 0.02,),
            CustomIconButton(
              title: 'All Devices',
              onTap: () {
                Navigator.pop(context);
                onLogout(SignOutScope.global);
              },
              color: AppColor.errorColor,
                iconData: Icons.logout ,
            ),
          ],
        );
      },
    );
  }

  static void showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: mediumText(title: "Permission Required"),
          content: lightText(title: "This feature requires permission. Please enable it in settings."),
          actions: [
            CustomButton(title: 'Cancel', onTap: () => Navigator.pop(context),width: 0.03,),
            CustomButton(title: 'Allow', onTap: () async {
              Navigator.pop(context);
              await openAppSettings(); // Open settings
            },width: 0.03,),
          ],
        );
      },
    );
  }
}
