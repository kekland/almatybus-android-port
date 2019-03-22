import 'package:almaty_bus/minimal_routes_panel.dart';
import 'package:almaty_bus/routes_panel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController controller;
  bool isPanelMinimized = false;

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
