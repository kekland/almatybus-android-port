import 'package:almaty_bus/api/bus_stop.dart';
import 'package:almaty_bus/api/route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusRouteData {
  BusRoute route;
  List<BusStop> stops;
  List<LatLng> points;
  Color predefinedColor;
  Color predefinedStopColor;
  Polyline attachedPolyline;

  BusRouteData.empty({this.route, this.predefinedColor, this.predefinedStopColor});
  BusRouteData.loaded({this.route, this.stops, this.points, this.predefinedColor, this.predefinedStopColor});
  BusRouteData.loadedFromEmpty({BusRouteData data, this.points, this.stops}) {
    this.predefinedColor = data.predefinedColor;
    this.predefinedStopColor = data.predefinedStopColor;
    this.route = data.route;
  }
  BusRouteData.withNewColor({BusRouteData data, this.predefinedColor, this.predefinedStopColor}) {
    this.route = data.route;
    this.stops = data.stops;
    this.points = data.points;
    this.attachedPolyline = data.attachedPolyline;
  }

  void createPolyline() {
    attachedPolyline = Polyline(
      polylineId: PolylineId(route.id.toString()),
      color: predefinedColor,
      points: points,
      width: 8,
    );
  }

  operator ==(Object other) => (other is BusRouteData && other.route.id == this.route.id);

  @override
  int get hashCode => route.hashCode;
}
