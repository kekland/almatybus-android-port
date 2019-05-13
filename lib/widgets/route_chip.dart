import 'package:almaty_bus/api/route.dart';
import 'package:flutter/material.dart';

class RouteChip extends StatelessWidget {
  final BusRoute route;
  final Color backgroundColor;

  const RouteChip({Key key, this.route, this.backgroundColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(route.name, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      backgroundColor: backgroundColor,
      elevation: 0.0,
    );
  }
}
