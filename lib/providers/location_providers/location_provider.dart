import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class LocationNotifier extends StateNotifier<AsyncValue<LatLng?>> {
  LocationNotifier() : super(const AsyncValue.data(null));

  Future<List<String>> searchLocationSuggestions(String query) async {
    if (query.isEmpty) return [];

    try {
      List<Location> locations = await locationFromAddress(query);
      List<String> suggestions = [];

      for (var loc in locations) {
        // Use geocoding to get detailed information for each location
        List<Placemark> placemarks = await placemarkFromCoordinates(loc.latitude, loc.longitude);
        if (placemarks.isNotEmpty) {
          final placemark = placemarks.first;
          // Build suggestion from placemark details
          suggestions.add('${placemark.name}, ${placemark.locality}, ${placemark.country}');
        }
      }
      return suggestions;
    } catch (e) {
      return [];
    }
  }


  Future<LatLng?> getUserLocation() async {
    state = const AsyncValue.loading();

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      state = AsyncValue.error('Location services are disabled.', StackTrace.current);
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        state = AsyncValue.error('Location permissions are denied.', StackTrace.current);
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      state = AsyncValue.error('Location permissions are permanently denied.', StackTrace.current);
      return null;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      LatLng userLatLng = LatLng(position.latitude, position.longitude);
      state = AsyncValue.data(userLatLng);
      return userLatLng;
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
      return null;
    }
  }

  void setSelectedLocation(LatLng location) {
    state = AsyncValue.data(location);
  }

  Future<void> searchLocation(String query) async {
    if (query.isEmpty) return;

    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final firstLocation = locations.first;
        setSelectedLocation(LatLng(firstLocation.latitude, firstLocation.longitude));
      } else {
        state = AsyncValue.error("Location not found", StackTrace.current);
      }
    } catch (e) {
      state = AsyncValue.error("Error searching location: $e", StackTrace.current);
    }
  }
}

final customLocationProvider = StateProvider<LatLng?>((ref) => null);

final locationProvider = StateNotifierProvider<LocationNotifier, AsyncValue<LatLng?>>(
      (ref) => LocationNotifier(),
);
