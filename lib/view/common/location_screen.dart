import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

import '../../providers/location_providers/location_provider.dart';

class LocationPicker extends ConsumerStatefulWidget {
  @override
  _ConsumerLocationPickerState createState() => _ConsumerLocationPickerState();
}
class _ConsumerLocationPickerState extends ConsumerState<LocationPicker> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _initializeLocation(); // Call the method that modifies the provider
    });
  }

  // Async method to initialize the location and move the map
  Future<void> _initializeLocation() async {
    LatLng? userLocation = await ref.read(locationProvider.notifier).getUserLocation();
    print('the userlocation init state ${userLocation}');
    if (userLocation != null) {
      _mapController.move(userLocation, 13.0);  // Move the map to the fetched location
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(locationProvider);
    final locationNotifier = ref.read(locationProvider.notifier);
    final customLocation = ref.watch(customLocationProvider); // Get the custom location from the provider

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Save Location'),
        onPressed: () async {
          // Use the custom location if available, else get the user's location
          LatLng? locationToUse = customLocation ?? await locationNotifier.getUserLocation();

          if (locationToUse != null) {
            _mapController.move(locationToUse, 13.0); // Move map to the selected location

            List<Placemark>  placemarks = await placemarkFromCoordinates(locationToUse.latitude, locationToUse.longitude);
            if(placemarks.isNotEmpty){
              Placemark placemark = placemarks.first;
              String address = '${placemark.name}, ${placemark.locality}, ${placemark.country}';
              print('Address: ${address}');
              Navigator.pop(context, address); // Return the location

            }
            else{
              Navigator.pop(context, 'Location not found');

            }
           }
        },
        icon: Icon(Icons.location_on_sharp),
      ),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.all(8.0),
            child: TypeAheadField(

              controller: _searchController,
              builder: (context, controller, focusNode) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  // obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Search Location',
                  ),
                );
              },
              // textFieldConfiguration: TextFieldConfiguration(
              // controller: _searchController,
              //   decoration: InputDecoration(
              //     labelText: 'Search Location',
              //     suffixIcon: Icon(Icons.search),
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              suggestionsCallback: (pattern) async {
                return await locationNotifier.searchLocationSuggestions(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  leading: Icon(Icons.location_on_sharp),
                  title: Text(suggestion),
                );
              },
              decorationBuilder: (context, child) {
                return Material(
                  type: MaterialType.card,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: child,
                );
              },
              offset: Offset(0, 12),
              constraints: BoxConstraints(maxHeight: 500),
              loadingBuilder: (context) => const Text('Loading...'),
              errorBuilder: (context, error) => const Text('Error!'),
              emptyBuilder: (context) => const Text('No items found!'),
              transitionBuilder: (context, animation, child) {
                return FadeTransition(
                  opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.fastOutSlowIn
                  ),
                  child: child,
                );
              },

              onSelected: (suggestion) async {
                // Get the coordinates of the selected location and move the map
                List<Location> locations = await locationFromAddress(suggestion);
                if (locations.isNotEmpty) {
                  final firstLocation = locations.first;
                  LatLng selectedLatLng = LatLng(firstLocation.latitude, firstLocation.longitude);
                  ref.read(customLocationProvider.state).state = selectedLatLng;
                  _mapController.move(selectedLatLng, 13.0);
                }
              },
            ),
          ),
          // ElevatedButton(
          //   onPressed: () async {
          //     LatLng? userLocation = await locationNotifier.getUserLocation();
          //     if (userLocation != null) {
          //       _mapController.move(userLocation, 13.0); // Move map to user's location
          //       Navigator.pop(context, userLocation);
          //     }
          //   },
          //   child: Text('Get Current Location'),
          // ),
          Expanded(
            child: locationState.when(
              data: (selectedLocation) => FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: selectedLocation ?? LatLng(0, 0),
                  initialZoom: 13.0,
                  onTap: (tapPosition, latLng) {
                    print('Tapped on map at: $latLng');

                    // Update the custom location using Riverpod's customLocationProvider
                    ref.read(customLocationProvider.state).state = latLng;

                    locationNotifier.setSelectedLocation(latLng); // Update the selected location
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  ),
                  MarkerLayer(
                    markers: selectedLocation != null
                        ? [
                      Marker(
                        point: selectedLocation,
                        child: Icon(Icons.location_on, color: Colors.red, size: 40),
                      ),
                    ]
                        : [],
                  ),
                ],
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
