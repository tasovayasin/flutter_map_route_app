import 'package:flutter/cupertino.dart';
import 'package:flutter_map_route_app/view/map_view.dart';
import 'package:latlong2/latlong.dart';

class MapViewController extends ChangeNotifier {
  bool clicked = false;
  LatLng point = LatLng(0, 0);

  List<LatLng> road = [];
  void clickedLocation() {
    clicked = true;
    notifyListeners();
  }

  void roadClear() {
    road.clear();
    notifyListeners();
  }

  void lastLocation() {
    if (road.isNotEmpty) {
      road = [road.last];
      notifyListeners();
    }
  }

  pointDigitConversion(LatLng point, MapViewController value) {
    for (int i = 0; i < location.listLocation().length; i++) {
      if (location.listLocation()[i].longitude.toStringAsExponential(3) ==
              point.longitude.toStringAsExponential(3) &&
          location.listLocation()[i].latitude.toStringAsExponential(3) ==
              point.latitude.toStringAsExponential(3)) {
        value.road.add(
          LatLng(
            double.parse(point.latitude.toStringAsExponential(3)),
            double.parse(point.longitude.toStringAsExponential(3)),
          ),
        );
        value.point = point;
        value.clickedLocation();
      }
    }
    notifyListeners();
  }
}
