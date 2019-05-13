import 'package:almaty_bus/widgets/route_chip.dart';
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
              
            ],
          ),
        ),
      ),
    );
  }
}
