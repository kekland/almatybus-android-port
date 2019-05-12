import 'package:flutter/material.dart';

class RouteChip extends StatelessWidget {
  final String routeName;
  final Color backgroundColor;

  const RouteChip({Key key, this.routeName, this.backgroundColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'route_hero_$routeName',
      child: Chip(
        label: Text(routeName, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
        backgroundColor: backgroundColor,
        elevation: 0.0,
      ),
    );
  }
}
