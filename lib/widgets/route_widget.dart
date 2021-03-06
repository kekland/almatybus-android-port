import 'package:almaty_bus/api/route.dart';
import 'package:almaty_bus/design/design.dart';
import 'package:flutter/material.dart';

class RouteWidget extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;
  final BusRoute route;

  const RouteWidget({Key key, this.isActive, this.onTap, this.route}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: (isActive)? Colors.blue : Colors.grey.shade900,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.0),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Column(
              children: <Widget>[
                Text(
                  route.type == RouteType.bus ? "Автобус" : "Троллейбус",
                  style: ModernTextTheme.caption.copyWith(color: Colors.white54),
                ),
                Text(
                  route.name,
                  style: ModernTextTheme.primaryAccented.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
