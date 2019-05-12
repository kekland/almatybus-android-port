import 'package:almaty_bus/api/api.dart' as api;
import 'package:almaty_bus/widgets/routes_panel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController controller;
  bool isPanelMinimized = false;
  String _mapStyle = null;
  Set<Polyline> polylines = {};

  Future<String> loadMapStyle() async {
    return await rootBundle.loadString('assets/maps_style.json');
  }

  @override
  void initState() {
    super.initState();

    api.getRouteInfo("36").then((List<LatLng> points) {
      polylines.add(Polyline(
        color: Colors.blueGrey,
        polylineId: PolylineId("137"),
        points: points,
        width: 5,
      ));
      print("got polyline ${points.length}");
      setState(() {});
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
            compassEnabled: true,
            myLocationEnabled: true,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: false,
            onMapCreated: (controller) {
              this.controller = controller;
            },
            myLocationButtonEnabled: true,
            onCameraMoveStarted: () {
              setState(() => isPanelMinimized = true);
            },

            polylines: polylines,
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
