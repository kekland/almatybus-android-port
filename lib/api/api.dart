import 'package:almaty_bus/api/bus_stop.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String baseUrl = 'https://www.citybus.kz/almaty';

int getMicroseconds() {
  var dateTime = new DateTime.now();
  return dateTime.microsecondsSinceEpoch;
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
    '$baseUrl/Monitoring/GetStops/?_=$getMicroseconds()',
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

Future<List<LatLng>> getRouteInfo(String route) async {
  var response = await http.get(
    '$baseUrl/Monitoring/GetRouteInfo/$route?_=$getMicroseconds()',
    headers: _getHeaders(),
  );

  var body = json.decode(response.body);
  List pointsJson = body['Sc']['Crs'][0]['Ps'];
  List stopsJson = body['Sc']['Crs'][0]['Ss'];

  List<BusStop> busStops = stopsJson.map((stop) => BusStop.fromJson(stop)).toList();
  List<LatLng> points = pointsJson.map((point) => LatLng(point['Y'], point['X'])).toList();

  return points;
}