import 'package:almaty_bus/bus_stop.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String baseUrl = 'https://www.citybus.kz/almaty';

int getMicroseconds() {
  var dateTime = new DateTime.now();
  return dateTime.microsecondsSinceEpoch;
}

Future<List<BusStop>> getBusStops() async {
  var response = await http.get(
    '$baseUrl/Monitoring/GetStops/?_=$getMicroseconds()',
    headers: {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36',
      'X-Requested-With': 'XMLHttpRequest',
      'DNT': '1'
    },
  );

  var body = json.decode(response.body);
  List<BusStop> busStops = new List();

  for (Map busStopJson in body) {
    busStops.add(BusStop.fromJson(busStopJson));
  }

  print(body);

  return busStops;
}
