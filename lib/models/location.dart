import 'package:latlong2/latlong.dart';

class Location {
  LatLng cankaya = LatLng(39.88, 32.85);
  LatLng kizilay = LatLng(39.91, 32.85);
  LatLng keciorenSelale = LatLng(39.97, 32.86);
  LatLng sihhiye = LatLng(39.92, 32.85);
  LatLng aoc = LatLng(39.93, 32.80);

  List<LatLng> listLocation() {
    List<LatLng> list;
    return list = [cankaya, kizilay, keciorenSelale, sihhiye, aoc];
  }
}
