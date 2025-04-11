// import 'package:geocoding/geocoding.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/material.dart';
// import '../../core/utils/helper_fuctions/snack_bar.dart';
// import '../../providers/location_providers/location_provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class LocationService {
//   // Method to get the current location
//   static Future<String?> getCurrentLocation(BuildContext context, WidgetRef ref) async {
//     // Check for location permission
//     bool hasPermission = await _requestLocationPermission(context);
//     if (hasPermission) {
//       // Fetch the current location from the location provider
//       LatLng? currentLocation = await ref.read(locationProvider.notifier).getUserLocation();
//
//       if (currentLocation != null) {
//         // Fetch address using reverse geocoding
//         List<Placemark> placemarks = await placemarkFromCoordinates(currentLocation.latitude, currentLocation.longitude);
//         if (placemarks.isNotEmpty) {
//           Placemark placemark = placemarks.first;
//           String address = '${placemark.name}, ${placemark.locality}, ${placemark.country}';
//           return address; // Return the formatted address
//         } else {
//           SnackBarClass.errorSnackBar(context: context, message: "Address not found for the current location.");
//         }
//       } else {
//         SnackBarClass.errorSnackBar(context: context, message: "Failed to fetch current location.");
//       }
//     } else {
//       SnackBarClass.errorSnackBar(context: context, message: "Location permission is required.");
//     }
//     return null;
//   }
//
//   // Method to check and request location permission
//   static Future<bool> _requestLocationPermission(BuildContext context) async {
//     PermissionStatus status = await Permission.locationWhenInUse.request();
//     if (status.isGranted) {
//       return true;
//     } else {
//       SnackBarClass.errorSnackBar(
//         context: context,
//         message: "Location permission is required to fetch the current location.",
//       );
//       return false;
//     }
//   }
// }
