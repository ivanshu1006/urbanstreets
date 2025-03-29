import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class LocationProvider extends ChangeNotifier {
  Position? position;
  MapController? mapController;
  bool isLoading = true;
  LatLng? selectedLocation;
  String currentAddress = 'Your location';
  Placemark? place;
  TextEditingController locationController = TextEditingController();

  LocationProvider() {
    initializeLocation();
  }

  @override
  void dispose() {
    mapController?.dispose();
    locationController.dispose();
    super.dispose();
  }

  void initMapController() {
    if (mapController == null) {
      mapController = MapController();
      if (selectedLocation != null) {
        mapController!.move(selectedLocation!, 15.0);
      }
      notifyListeners();
    }
  }

  Future<void> initializeLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        isLoading = false;
        notifyListeners();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          isLoading = false;
          notifyListeners();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        isLoading = false;
        notifyListeners();
        return;
      }

      position = await Geolocator.getCurrentPosition();
      selectedLocation = LatLng(position!.latitude, position!.longitude);
      isLoading = false;
      
      if (mapController != null && selectedLocation != null) {
        mapController!.move(selectedLocation!, 15.0);
      }
      
      notifyListeners();
      
      if (selectedLocation != null) {
        getAddressFromLatLng(selectedLocation!);
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        place = placemarks[0];
        currentAddress = '${place?.locality ?? ''}, ${place?.administrativeArea ?? ''}';
        locationController.text = currentAddress;
        notifyListeners();
      }
    } catch (e) {
      currentAddress = 'Unable to fetch address';
      locationController.text = currentAddress;
      notifyListeners();
    }
  }

  void onMapTapped(TapPosition tapPosition, LatLng tappedPoint) {
    selectedLocation = tappedPoint;
    notifyListeners();
    getAddressFromLatLng(tappedPoint);
  }

  void centerMap() {
    if (selectedLocation != null && mapController != null) {
      mapController!.move(selectedLocation!, 15.0);
    }
  }
}
