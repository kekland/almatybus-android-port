import 'package:almaty_bus/design/design.dart';
import 'package:flutter/material.dart';

class RoutesSelectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CardWidget(
        padding: const EdgeInsets.all(16.0),
        onTap: () {},
        body: Container(
          child: Column(
            children: [
              Text('Автобусы', style: ModernTextTheme.boldTitle),
            ],

          ),
        ),
      ),
    );
  }
}
