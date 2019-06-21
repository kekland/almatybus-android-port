import 'package:almaty_bus/api/decrypt_positions.dart';
import 'package:almaty_bus/api/route.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Bus {
  int id;
  double orientation;
  LatLng position;
  BusRoute route;

  Bus({this.id, this.orientation, this.position, this.route});

  Bus.fromJson(Map json, BusRoute route) {
    this.id = (json['Id'] as num).toInt();
    this.orientation = (json['AZ'] as num).toDouble();

    double a = (json['LN'] as num).toDouble();
    double b = (json['LT'] as num).toDouble();

    this.position = DecryptPositions.decrypt(a, b);
    this.route = route;
  }
}