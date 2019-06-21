import 'package:almaty_bus/api/api.dart' as api;
import 'package:almaty_bus/api/bus_route_data.dart';
import 'package:almaty_bus/api/map_style.dart';
import 'package:almaty_bus/api/route.dart';
import 'package:almaty_bus/design/app_bar_widget.dart';
import 'package:almaty_bus/design/design.dart';
import 'package:almaty_bus/utils.dart';
import 'package:almaty_bus/widgets/sliding_panel_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static List<Color> routeColors = [
    Colors.purple,
    Colors.indigo,
    Colors.blue,
    Colors.green,
    Colors.orange
  ];
  static List<Color> stopColors = [
    Colors.purple.shade600,
    Colors.indigo.shade600,
    Colors.blue.shade600,
    Colors.green.shade600,
    Colors.orange.shade600
  ];

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController controller;
  List<BusRoute> selectedRoutes;
  List<BusRouteData> selectedRoutesData;

  @override
  void initState() {
    super.initState();
    selectedRoutesData = [];
    selectedRoutes = [];
  }

  Set<Polyline> getPolylines() {
    Set<Polyline> polylines = {};

    for (BusRouteData routeData in selectedRoutesData) {
      if (routeData.attachedPolyline != null) {
        polylines.add(routeData.attachedPolyline);
      }
    }

    return polylines;
  }

  Set<Circle> getCircles() {
    Set<Circle> circles = {};

    for (BusRouteData routeData in selectedRoutesData) {
      if (routeData.attachedPolyline != null) {
        circles.addAll(routeData.stops.map((stop) {
          return Circle(
            circleId: CircleId("route_${routeData.route.id}_circle_${stop.id}"),
            center: stop.point,
            fillColor: Colors.white,
            radius: 8.0,
            visible: true,
            zIndex: 100,
            strokeColor: routeData.predefinedStopColor,
            strokeWidth: 12,
          );
        }));
      }
    }

    print(circles.length);

    return circles;
  }

  void onSelectedRoutesUpdated(BuildContext context) async {
    List<BusRouteData> newSelectedRoutesData = [];

    int countToLoad = 0;
    for (int i = 0; i < selectedRoutes.length; i++) {
      BusRoute selectedRoute = selectedRoutes[i];
      BusRouteData selectedRouteData = BusRouteData.empty(
          route: selectedRoute,
          predefinedColor: HomePage.routeColors[i],
          predefinedStopColor: HomePage.stopColors[i]);
      bool found = false;

      for (BusRouteData data in selectedRoutesData) {
        if (data == selectedRouteData) {
          selectedRouteData.points = data.points;
          selectedRouteData.stops = data.stops;
          selectedRouteData.attachedPolyline = data.attachedPolyline;
          found = true;
        }
      }

      newSelectedRoutesData.add(selectedRouteData);
      if (!found) {
        countToLoad++;
      }
    }

    setState(() => selectedRoutesData = newSelectedRoutesData);

    if (countToLoad > 0) {
      showLoadingDialog(context: context, color: Colors.blue);

      int finished = 0;

      for (int i = 0; i < newSelectedRoutesData.length; i++) {
        BusRouteData routeData = newSelectedRoutesData[i];
        api.getRouteInfo(routeData.route).then((BusRouteData newData) {
          finished++;

          routeData.points = newData.points;
          routeData.stops = newData.stops;
          routeData.createPolyline();

          if (finished == countToLoad) {
            setState(() => selectedRoutesData = newSelectedRoutesData);
            Navigator.of(context).pop();
          }
        });
      }
    }
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBarWidget(title: Text('Алматы.Автобус')),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 64.0,
            child: GoogleMap(
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

                controller.setMapStyle(mapStyle);
              },
              myLocationButtonEnabled: true,
              polylines: getPolylines(),
              circles: getCircles(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      backdropEnabled: true,
      borderRadius: BorderRadius.circular(16.0),
      body: _buildGoogleMap(context),
      boxShadow: [Shadows.heavyShadow],
      backdropTapClosesPanel: true,
      minHeight: 120.0,
      margin: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      panel: Material(
        type: MaterialType.transparency,
        child: SlidingPanelWidget(
          onSelectedRoutesChange: (List<BusRoute> selectedRoutes) {
            setState(() {
              this.selectedRoutes = selectedRoutes;
            });
          },
        ),
      ),
      onPanelClosed: () => onSelectedRoutesUpdated(context),
      parallaxEnabled: false,
      parallaxOffset: 0.125,
    );
  }
}
