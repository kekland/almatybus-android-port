class Route {
  int id;
  String name;
  RouteType type;

  Route.bus({this.id, this.name, this.type = RouteType.bus});
  Route.trolley({this.id, this.name, this.type = RouteType.trolley});
}

enum RouteType {
  bus,
  trolley,
}