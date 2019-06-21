import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as Math;

class DecryptPositions {
  static double odckji = .9996;
  static double bmkpsv = 3.14159265358979;
  static double rgkntj = 6378137;
  static double ssfodl = 6356752.314;
  static double xvisbq = .00669437999013;
  static double abxuri = 43;
  static double ebshkr = 180;

  static double tdrndu(a) {
    return a / bmkpsv * ebshkr;
  }

  static double vquqbz(a) {
    var b = (rgkntj - ssfodl) / (rgkntj + ssfodl);
    a /= (rgkntj + ssfodl) / 2 * (1 + Math.pow(b, 2) / 4 + Math.pow(b, 4) / 64);
    return a +
        (3 * b / 2 + -27 * Math.pow(b, 3) / 32 + 269 * Math.pow(b, 5) / 512) *
            Math.sin(2 * a) +
        (21 * Math.pow(b, 2) / 16 + -55 * Math.pow(b, 4) / 32) *
            Math.sin(4 * a) +
        (151 * Math.pow(b, 3) / 96 + -417 * Math.pow(b, 5) / 128) *
            Math.sin(6 * a) +
        1097 * Math.pow(b, 4) / 512 * Math.sin(8 * a);
  }

  static LatLng zcscxo(a, b, c) {
    b = vquqbz(b);
    var h = (Math.pow(rgkntj, 2) - Math.pow(ssfodl, 2)) / Math.pow(ssfodl, 2);
    var k = Math.cos(b);
    var e = h * Math.pow(k, 2);
    var f = h = Math.pow(rgkntj, 2) / (ssfodl * Math.sqrt(1 + e));
    var l = Math.tan(b);
    var g = l * l;
    var m = g * g;
    var n = 1 / (f * k);
    f *= h;
    var p = l / (2 * f);
    f *= h;
    var q = 1 / (6 * f * k);
    f *= h;
    var r = l / (24 * f);
    f *= h;
    var t = 1 / (120 * f * k);
    f *= h;
    var u = l / (720 * f);
    f *= h;
    k = 1 / (5040 * f * k);
    var v = -1 - 2 * g - e;
    var w = 5 + 28 * g + 24 * m + 6 * e + 8 * g * e;
    var x = -61 - 662 * g - 1320 * m - 720 * m * g;

    return LatLng(
      tdrndu(b +
          p * (-1 - e) * a * a +
          r *
              (5 + 3 * g + 6 * e - 6 * g * e - 3 * e * e - 9 * g * e * e) *
              Math.pow(a, 4) +
          u * (-61 - 90 * g - 45 * m - 107 * e + 162 * g * e) * Math.pow(a, 6) +
          l /
              (40320 * f * h) *
              (1385 + 3633 * g + 4095 * m + 1575 * m * g) *
              Math.pow(a, 8)),
      tdrndu(c +
          n * a +
          q * v * Math.pow(a, 3) +
          t * w * Math.pow(a, 5) +
          k * x * Math.pow(a, 7)),
    );
  }

  static double qsdows(a) {
    return a / 180 * bmkpsv;
  }

  static double isaqrl(a) {
    return qsdows(-183 + 6 * a);
  }

  static LatLng decrypt(double a, double b) {
    a = (a - 5E5) / odckji;
    b /= odckji;
    var d = isaqrl(abxuri);
    return zcscxo(a, b, d);
  }
}
