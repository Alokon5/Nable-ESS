import 'package:geolocator/geolocator.dart';

import 'package:nable_ess/app/data/models/latLongModel/latLongModel.dart';

class LocationProvider {
  Future<LatLng> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();

      return LatLng(null, null);
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);

      return LatLng(currentPosition.latitude, currentPosition.longitude);
    }
  }
}
