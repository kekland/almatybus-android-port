import 'package:almaty_bus/route_chip.dart';
import 'package:flutter/material.dart';

class MinimalRoutesPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16.0),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RouteChip(routeName: '137', backgroundColor: Colors.green),
              RouteChip(routeName: '124', backgroundColor: Colors.orange),
              RouteChip(routeName: '70', backgroundColor: Colors.teal),
              RouteChip(routeName: '15', backgroundColor: Colors.blue),
              RouteChip(routeName: '205', backgroundColor: Colors.amber),
            ],
          ),
        ),
      ),
    );
  }
}
