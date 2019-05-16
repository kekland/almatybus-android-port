
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusStop {
  int id;
  String name;
  LatLng point;

  BusStop({this.id, this.name, this.point});

  factory BusStop.fromJson(Map json) {
    return BusStop(
      id: json['Id'],
      name: json['Nm'],
      point: LatLng(json['Pt']['Y'], json['Pt']['X'])
    );
  }
}