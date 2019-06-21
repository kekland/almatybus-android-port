import 'package:almaty_bus/api/bus_stop.dart';
import 'package:almaty_bus/api/route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusData {
  int id;
  String license;
  String model;

  BusData({this.id, this.license, this.model});

  BusData.fromJson(Map json) {
    this.id = (json['Id'] as num).toInt();
    this.license = json['Nm'];
    this.model = json['Md'];
  }
}

class BusRouteData {
  BusRoute route;
  List<BusStop> stops;
  List<LatLng> points;
  List<BusData> buses;
  Color predefinedColor;
  Color predefinedStopColor;
  Polyline attachedPolyline;

  BusRouteData.empty({this.route, this.predefinedColor, this.predefinedStopColor, this.buses});
  BusRouteData.loaded({this.route, this.stops, this.points, this.predefinedColor, this.predefinedStopColor, this.buses});
  BusRouteData.loadedFromEmpty({BusRouteData data, this.points, this.stops}) {
    this.predefinedColor = data.predefinedColor;
    this.predefinedStopColor = data.predefinedStopColor;
    this.route = data.route;
    this.buses = data.buses;
  }
  BusRouteData.withNewColor({BusRouteData data, this.predefinedColor, this.predefinedStopColor}) {
    this.route = data.route;
    this.stops = data.stops;
    this.points = data.points;
    this.buses = data.buses;
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
