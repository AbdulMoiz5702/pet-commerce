import 'package:animals/models/user_model/user_profle_model.dart';
import 'package:animals/view/screens/auth_screens/forgot_password.dart';
import 'package:animals/view/screens/auth_screens/login_screen.dart';
import 'package:animals/view/screens/auth_screens/signup_screen.dart';
import 'package:animals/view/screens/bottom_nav/bottom_nav_screen.dart';
import 'package:animals/view/screens/home_screens/Base_home_screen.dart';
import 'package:animals/view/screens/splash/splash_screen.dart';
import 'package:animals/view/screens/user_profile/update_user_details.dart';
import 'package:animals/view/screens/user_profile/update_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import '../../view/screens/Listings_screens/add_listing_screen.dart';
import '../../view/screens/auth_screens/verify_otp.dart';

class Routes {
  // ----------------- auth routes ----------------------------- //
  static const String signup = 'signup';
  static const String login = 'login';
  static const String verifyOtp = 'verifyOtp';
  static const String forgotPassword = 'forgotPassword';

  // ----------------- splash routes ----------------------------- //
  static const String splash = 'splash';

  // ----------------- bottom Nav routes ----------------------------- //
  static const String bottomNav = 'bottomNav';

  // ----------------- profile screens routes ----------------------------- //
  static const String updateUserProfile = 'updateUserProfile';
  static const String updateUserDetails = 'updateUserDetails';

  // ----------------- Listing screens routes ----------------------------- //
  static const String addListingScreen = 'addListingScreen';

  // ----------------- Home Screens routes ----------------------------- //
  static const String baseHomeScreen = 'baseHomeScreen';


  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

    // ----------------- auth routes ----------------------------- //

      case signup:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case verifyOtp:
        final args = settings.arguments as Map<String, dynamic>;
        final email = args['email'] as String;
        final otpType = args['otpType'] as OtpType;
        return MaterialPageRoute(builder: (_) => VerifyOtp(email: email, otpType: otpType),);


    // ----------------- splash routes ----------------------------- //
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());

    // ----------------- Home Screens routes ----------------------------- //
      case baseHomeScreen:
        return MaterialPageRoute(builder: (_) => BaseHomeScreen());

    // ----------------- bottom Nav routes ----------------------------- //
      case bottomNav:
        return MaterialPageRoute(builder: (_) => BottomNavScreen());

    // ----------------- profile screens routes ----------------------------- //
      case updateUserProfile:
        final args = settings.arguments as Map<String, dynamic>;
        final userModel = args['userModel'] as UserProfile;
        return MaterialPageRoute(builder: (_) => UpdateUserProfile(userModel: userModel));
      case updateUserDetails:
        final args = settings.arguments as Map<String, dynamic>;
        final userModel = args['userModel'] as UserProfile;
        return MaterialPageRoute(builder: (_) => UpdateUserDetails(userModel: userModel));

       // ----------------- Listing screens routes ----------------------------- //
      case addListingScreen:
        return MaterialPageRoute(builder: (_) => AddListingScreen());




      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
