import 'package:animals/core/utils/helper_fuctions/helper_function.dart';
import 'package:animals/models/user_model/user_profle_model.dart';
import 'package:animals/view/common/custom_textfeild.dart';
import 'package:animals/view/common/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/utils/helper_fuctions/snack_bar.dart';
import '../../../providers/location_providers/get_current_location_funciton.dart';
import '../../../providers/location_providers/location_provider.dart';
import '../../../providers/user_profile_provider/update_profile_provider.dart';
import '../../common/custom_button.dart';
import '../../common/custom_loading.dart';
import '../../common/custom_sizedBox.dart';
import '../../common/text_widgets.dart';

class UpdateUserDetails extends ConsumerStatefulWidget {
  final UserProfile userModel;
  const UpdateUserDetails({super.key, required this.userModel});

  @override
  _UpdateUserProfileState createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends ConsumerState<UpdateUserDetails> {

  @override
  void initState() {
    super.initState();
    Future.microtask((){
      var provider = ref.watch(userProfileUpdate.notifier);
      provider.description.text =  widget.userModel.description;
      provider.location.text =  widget.userModel.location;
      provider.phone.text =  widget.userModel.phone;
    });
  }
  Future<void> _getCurrentLocation() async {
    final locationNotifier = ref.read(locationProvider.notifier);
    final provider = ref.read(userProfileUpdate.notifier);

    // Set loading state
    locationNotifier.state = const AsyncLoading();
    provider.location.text = "Fetching address...";

    try {
      final userLocation = await locationNotifier.getUserLocation();
      if (userLocation == null) {
        throw Exception("Failed to get user location");
      }

      List<Placemark> placemarks = await placemarkFromCoordinates(
        userLocation.latitude, userLocation.longitude,
      ).timeout(const Duration(seconds: 5));

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        String address = "${placemark.name ?? ""}, ${placemark.locality ?? ""}, ${placemark.country ?? ""}".trim();

        provider.location.text = address;
        locationNotifier.state = AsyncData(userLocation); // ✅ Set AsyncData state
      } else {
        throw Exception("Address not found");
      }
    } catch (e, s) {
      provider.location.text = "Error fetching address";
      locationNotifier.state = AsyncError(e, s); // ✅ Set AsyncError state
      debugPrint('Reverse Geocoding Error: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    var provider = ref.watch(userProfileUpdate.notifier);
    final locationState = ref.watch(locationProvider); // Watch the location state

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: mediumText(title: 'Edit Details'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            const Sized(height: 0.05,),
            Consumer(
              builder: (context, ref, _) {
                final locationState = ref.watch(locationProvider); // Watch location state
                return Row(
                  children: [
                    CustomIconButton(
                      width: 0.4,
                      height: 0.04,
                      fontSize: 10.0,
                      title: locationState is AsyncLoading
                          ? 'Fetching Location...'
                          : locationState is AsyncError
                          ? 'Retry Location'
                          : 'Get Current Location',
                      onTap: _getCurrentLocation,
                      iconData: locationState is AsyncLoading ? Icons.sync : Icons.my_location,
                    ),
                  ],
                );
              },
            ),
            Consumer(
                builder: (context, ref, _) {
                  final locationProviderState = ref.watch(userProfileUpdate);
                return CustomTextField(
                  keyboardType: TextInputType.none,
                  controller: provider.location,
                  suffixicon: provider.location.text == "Fetching address..."
                      ? CircularProgressIndicator()
                      : Icon(Icons.location_on),


                  hintText: 'Location',
                  ontap: () async {
                    bool hasPermission = await HelperFunctions.requestPermission(
                      permission: Permission.locationWhenInUse, // Request location permission
                      context: context,
                    );
                    if (hasPermission) {
                      final String selectedLocation = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LocationPicker()),
                      );

                      if (selectedLocation != null) {

                        print('the final location in provider location is  "$selectedLocation');
                        // provider.location.text = "${selectedLocation.latitude}, ${selectedLocation.longitude}";
                        provider.location.text = selectedLocation;

                      }
                      else{
                        print('selected locatin : $selectedLocation');
                        print('no location');
                        SnackBarClass.errorSnackBar(
                          context: context,
                          message: "No location",
                        );

                      }
                    } else {
                      // ❌ Permission denied → Show error message
                      SnackBarClass.errorSnackBar(
                        context: context,
                        message: "Location permission is required to pick a location.",
                      );
                    }
                  },
                  issuffixIcon: true,

                  validate: (value) {},
                );
              }
            ),
            const Sized(height: 0.02,),
            CustomTextField(
              keyboardType: TextInputType.phone,
              controller: provider.phone,
              hintText: 'Phone',
              validate: (value) {},
            ),
            const Sized(height: 0.02,),
            CustomTextField(
              maxLine: 4,
              controller: provider.description,
              hintText: 'Description',

              validate: (value) {


              },
            ),
            const Sized(height: 0.05,),
            Consumer(builder: (context,ref,_){
              var data = ref.watch(userProfileUpdate.select((state)=> state.isSecondLoading));
              return data == true ? const CustomLoading(): CustomButton(title: 'Save', onTap: (){
                ref.read(userProfileUpdate.notifier).updateUserDetails(context: context);
              });
            })

          ],
        ),
      ),
    );
  }
}

