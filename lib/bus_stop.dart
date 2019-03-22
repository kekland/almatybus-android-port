
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusStop {
  int id;
  String name;
  LatLng point;
  String additionalInfo;

  BusStop({this.id, this.name, this.point, this.additionalInfo});

  factory BusStop.fromJson(Map json) {
    return BusStop(
      id: json['Id'],
      name: json['Nm'],
      point: LatLng(json['Pt']['X'], json['Pt']['Y']),
      additionalInfo: json['Rn']
    );
  }
}