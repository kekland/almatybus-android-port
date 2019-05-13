import 'package:almaty_bus/api/api.dart' as api;
import 'package:almaty_bus/api/route.dart';
import 'package:almaty_bus/design/app_bar_widget.dart';
import 'package:almaty_bus/design/design.dart';
import 'package:almaty_bus/design/transparent_route.dart';
import 'package:almaty_bus/utils.dart';
import 'package:almaty_bus/widgets/route_chip.dart';
import 'package:almaty_bus/widgets/routes_panel.dart';
import 'package:almaty_bus/widgets/routes_selection_widget.dart';
import 'package:almaty_bus/widgets/sliding_panel_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  static List<Color> routeColors = [Colors.purple, Colors.indigo, Colors.blue, Colors.green, Colors.orange];
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController controller;
  bool isPanelMinimized = false;
  Set<Polyline> polylines = {};
  List<BusRoute> selectedRoutes;

  @override
  void initState() {
    super.initState();
  }

  void onSelectedRoutesUpdated(BuildContext context) async {
    Set<Polyline> newPolylines = {};
    List<BusRoute> routesToUpdate = [];
    List<Color> routesToUpdateCorrespondingColor = [];

    for (int i = 0; i < selectedRoutes.length; i++) {
      BusRoute selectedRoute = selectedRoutes[i];
      bool found = false;
      for (Polyline polyline in polylines) {
        if (polyline.polylineId.value == selectedRoute.id.toString()) {
          found = true;
          newPolylines.add(Polyline(
            polylineId: polyline.polylineId,
            color: HomePage.routeColors[i],
            points: polyline.points,
            width: 8,
          ));
          break;
        }
      }
      if (!found) {
        routesToUpdate.add(selectedRoute);
        routesToUpdateCorrespondingColor.add(HomePage.routeColors[i]);
      }
    }

    setState(() => polylines = newPolylines);

    if (routesToUpdate.length > 0) {
      showLoadingDialog(context: context, color: Colors.blue);

      for (int i = 0; i < routesToUpdate.length; i++) {
        BusRoute route = routesToUpdate[i];
        List<LatLng> points = await api.getRouteInfo(route);

        polylines.add(Polyline(
          polylineId: PolylineId(route.id.toString()),
          color: routesToUpdateCorrespondingColor[i],
          points: points,
          width: 8,
        ));
      }

      setState(() {});

      Navigator.of(context).pop();
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
              },
              myLocationButtonEnabled: true,
              onCameraMoveStarted: () {
                setState(() => isPanelMinimized = true);
              },
              polylines: polylines,
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
