import 'package:almaty_bus/bus_stop.dart';
import 'package:almaty_bus/google_maps_flutter/lib/google_maps_flutter.dart';
import 'package:almaty_bus/minimal_routes_panel.dart';
import 'package:almaty_bus/routes_panel.dart';
import 'package:flutter/material.dart';
import 'package:almaty_bus/api.dart' as api;
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController controller;
  bool isPanelMinimized = false;
  String _mapStyle = null;

  Future<String> loadMapStyle() async {
    return await rootBundle.loadString('assets/maps_style.json');
  }

  @override
  void initState() {
    super.initState();
    loadMapStyle().then((style) {
      setState(() {
        this._mapStyle = style;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(43.222, 76.8512),
              zoom: 11.0,
            ),
            mapStyle: _mapStyle,
            compassEnabled: true,
            myLocationEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: false,
            onMapCreated: (controller) {
              this.controller = controller;
            },
            onCameraMoveStarted: () {
              setState(() {
                isPanelMinimized = true;
              });
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: RoutesPanel(
                minimized: isPanelMinimized,
                onPanelTap: () {
                  setState(() {
                    isPanelMinimized = !isPanelMinimized;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
