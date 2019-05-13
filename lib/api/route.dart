class BusRoute {
  int id;
  String name;
  RouteType type;

  BusRoute.bus({this.id, this.name, this.type = RouteType.bus});
  BusRoute.trolley({this.id, this.name, this.type = RouteType.trolley});
}

enum RouteType {
  bus,
  trolley,
}