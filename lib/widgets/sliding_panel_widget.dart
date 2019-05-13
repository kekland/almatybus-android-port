import 'package:almaty_bus/api/route.dart';
import 'package:almaty_bus/api/routes.dart';
import 'package:almaty_bus/design/design.dart';
import 'package:almaty_bus/pages/home_page.dart';
import 'package:almaty_bus/widgets/route_chip.dart';
import 'package:almaty_bus/widgets/route_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SlidingPanelWidget extends StatefulWidget {
  final Function(List<BusRoute> selectedRoutes) onSelectedRoutesChange;

  const SlidingPanelWidget({Key key, this.onSelectedRoutesChange}) : super(key: key);

  @override
  _SlidingPanelWidgetState createState() => _SlidingPanelWidgetState();
}

class _SlidingPanelWidgetState extends State<SlidingPanelWidget> {
  FocusNode focusNode;
  List<BusRoute> selectedRoutes;
  List<BusRoute> filteredRoutes;

  @override
  void initState() {
    focusNode = FocusNode();
    selectedRoutes = [];
    onFilterChange("");
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void onFilterChange(String filter) {
    filteredRoutes = [];
    routes.forEach((route) {
      if (route.name.toLowerCase().contains(filter.toLowerCase())) filteredRoutes.add(route);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => focusNode.unfocus()),
      child: Container(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
              children: (selectedRoutes.length > 0)
                  ? selectedRoutes
                      .map(
                        (route) => RouteChip(
                              route: route,
                              backgroundColor: HomePage.routeColors[selectedRoutes.indexOf(route)],
                            ),
                      )
                      .toList()
                  : [RouteChip(route: BusRoute.bus(id: 0, name: "Пусто"), backgroundColor: Colors.grey.shade300)],
            ),
            DividerWidget(),
            TextField(
              onChanged: onFilterChange,
              keyboardType: TextInputType.number,
              focusNode: focusNode,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide(color: Colors.black12, width: 2.0),
                ),
                prefixIcon: Icon(Icons.search),
                hintText: "Поиск",
                hintStyle: ModernTextTheme.caption,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: StaggeredGridView.countBuilder(
                itemCount: filteredRoutes.length,
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                staggeredTileBuilder: (index) => StaggeredTile.extent(1, 64.0),
                itemBuilder: (context, index) => RouteWidget(
                      route: filteredRoutes[index],
                      onTap: () {
                        BusRoute route = filteredRoutes[index];
                        if (selectedRoutes.contains(route)) {
                          selectedRoutes.remove(route);
                          widget.onSelectedRoutesChange(selectedRoutes);
                        } else if (selectedRoutes.length < 5) {
                          selectedRoutes.add(route);
                          widget.onSelectedRoutesChange(selectedRoutes);
                        }
                        setState(() {});
                      },
                      isActive: selectedRoutes.contains(filteredRoutes[index]),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
