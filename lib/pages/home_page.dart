import 'package:almaty_bus/api/api.dart' as api;
import 'package:almaty_bus/design/app_bar_widget.dart';
import 'package:almaty_bus/design/design.dart';
import 'package:almaty_bus/design/transparent_route.dart';
import 'package:almaty_bus/widgets/route_chip.dart';
import 'package:almaty_bus/widgets/routes_panel.dart';
import 'package:almaty_bus/widgets/routes_selection_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
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

  Widget _buildGoogleMap() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBarWidget(title: Text('Алматы.Автобус')),
          body: GoogleMap(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      backdropEnabled: true,
      borderRadius: BorderRadius.circular(16.0),
      body: _buildGoogleMap(),
      boxShadow: [Shadows.heavyShadow],
      backdropTapClosesPanel: true,
      minHeight: 120.0,
      margin: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      panel: Material(
        type: MaterialType.transparency,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 24.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text('Автобусы', style: ModernTextTheme.boldTitle),
              Wrap(
                spacing: 8.0,
                children: [
                  RouteChip(routeName: '137', backgroundColor: Colors.green),
                  RouteChip(routeName: '124', backgroundColor: Colors.orange),
                  RouteChip(routeName: '70', backgroundColor: Colors.teal),
                  RouteChip(routeName: '15', backgroundColor: Colors.blue),
                  RouteChip(routeName: '205', backgroundColor: Colors.amber),
                ],
              ),
              DividerWidget(),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide(color: Colors.black12, width: 2.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      parallaxEnabled: false,
      parallaxOffset:
          0.125, /*body: SafeArea(
        child: Stack(
          children: [
            
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
                  openSelection: () {
                    Navigator.of(context).push(
                      TransparentRoute(
                        builder: (context) {
                          return RoutesSelectionWidget();
                        },
                        settings: RouteSettings(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),*/
    );
  }
}
