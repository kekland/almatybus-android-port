import 'package:almaty_bus/api/bus.dart';
import 'package:almaty_bus/api/bus_route_data.dart';
import 'package:almaty_bus/api/bus_stop.dart';
import 'package:almaty_bus/api/route.dart';
import 'package:almaty_bus/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String baseUrl = 'https://www.citybus.kz/almaty';

int getMilliseconds() {
  var dateTime = new DateTime.now();
  return dateTime.millisecondsSinceEpoch;
}

int getSeconds() {
  return (getMilliseconds() / 1e3).round();
}

Map<String, String> _getHeaders() {
  return {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36',
    'X-Requested-With': 'XMLHttpRequest',
    'DNT': '1'
  };
}

Future<List<BusStop>> getBusStops() async {
  var response = await http.get(
    '$baseUrl/Monitoring/GetStops/?_${getMilliseconds()}',
    headers: _getHeaders(),
  );

  var body = json.decode(response.body);
  List<BusStop> busStops = new List();

  for (Map busStopJson in body) {
    busStops.add(BusStop.fromJson(busStopJson));
  }

  print(body);

  return busStops;
}

Future<BusRouteData> getRouteInfo(BusRoute route) async {
  bool isCached =
      SharedPreferencesManager.instance.getBool("route.${route.id}.isCached") ?? false;
  List pointsJson;
  List stopsJson;

  if (isCached) {
    pointsJson = jsonDecode(SharedPreferencesManager.instance
        .getString("route.${route.id}.points"));
    stopsJson = jsonDecode(
        SharedPreferencesManager.instance.getString("route.${route.id}.stops"));
  } else {
    var response = await http.get(
      '$baseUrl/Monitoring/GetRouteInfo/${route.id}?_=${getMilliseconds()}',
      headers: _getHeaders(),
    );

    var body = json.decode(response.body);

    pointsJson = body['Sc']['Crs'][0]['Ps'];
    stopsJson = body['Sc']['Crs'][0]['Ss'];

    SharedPreferencesManager.instance
        .setBool("route.${route.id}.isCached", true);
    SharedPreferencesManager.instance
        .setString("route.${route.id}.points", jsonEncode(pointsJson));
    SharedPreferencesManager.instance
        .setString("route.${route.id}.stops", jsonEncode(stopsJson));
  }

  List<BusStop> busStops =
      stopsJson.map((stop) => BusStop.fromJson(stop)).toList();
  List<LatLng> points =
      pointsJson.map((point) => LatLng(point['Y'], point['X'])).toList();

  return BusRouteData.loaded(points: points, stops: busStops, route: route);
}

Future<List<Bus>> getBusUpdates(
    {BusRoute route, int previousUpdateTime = 0}) async {
  try {
    var response = await http.get(
      '$baseUrl/Monitoring/GetStatusInfo/X${route.id}X/$previousUpdateTime?_=${getMilliseconds()}',
      headers: _getHeaders(),
    );

    var body = json.decode(response.body);
    var buses =
        (body as List).map((v) => Bus.fromJson(v, route)).cast<Bus>().toList();
    return buses;
  } catch (e) {
    rethrow;
  }
}
