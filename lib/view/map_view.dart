// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_route_app/models/location.dart';
import 'package:flutter_map_route_app/view/bluetooth.dart';
import 'package:flutter_map_route_app/view/map_view_controller.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

Location location = Location();

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MapViewController>(
        builder: (context, value, child) => Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: location.kizilay,
                zoom: 12,
                onTap: (tapPosition, point) {
                  value.pointDigitConversion(point, value);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: value.road,
                      strokeWidth: 3,
                      borderColor: Colors.orangeAccent,
                      color: Colors.orangeAccent,
                    )
                  ],
                ),
                MarkerLayer(
                  markers: [
                    marker(location.cankaya, value),
                    marker(location.kizilay, value),
                    marker(location.keciorenSelale, value),
                    marker(location.sihhiye, value),
                    marker(location.aoc, value),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      value.roadClear();
                    },
                    icon: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      value.lastLocation();
                    },
                    icon: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.gps_fixed_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BluetoothView()));
                    },
                    icon: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.bluetooth,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Marker marker(LatLng point, MapViewController controller) {
    return Marker(
      point: point,
      builder: (context) => DecoratedBox(
        decoration: const BoxDecoration(),
        child: DecoratedBox(
          decoration: BoxDecoration(
              image: controller.road.isEmpty
                  ? const DecorationImage(
                      image: AssetImage("assets/images/marker.png"))
                  : controller.clicked == true &&
                              controller.road.first ==
                                  LatLng(
                                    double.parse(
                                      point.latitude.toStringAsExponential(3),
                                    ),
                                    double.parse(
                                      point.longitude.toStringAsExponential(3),
                                    ),
                                  ) ||
                          controller.road.last ==
                              LatLng(
                                double.parse(
                                  point.latitude.toStringAsExponential(3),
                                ),
                                double.parse(
                                  point.longitude.toStringAsExponential(3),
                                ),
                              )
                      ? const DecorationImage(
                          image: AssetImage("assets/images/man.png"),
                        )
                      : const DecorationImage(
                          image: AssetImage("assets/images/marker.png"),
                        )),
        ),
      ),
    );
  }
}
