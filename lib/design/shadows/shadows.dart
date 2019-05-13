import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Shadows {
  static BoxShadow slightShadow = BoxShadow(
    color: Colors.black.withOpacity(0.055),
    offset: Offset(0.0, 5.0),
    blurRadius: 2.0,
  );
  static BoxShadow heavyShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    offset: Offset(0.0, 5.0),
    blurRadius: 5.0,
  );
  static BoxShadow slightShadowTop = BoxShadow(
    color: Colors.black.withOpacity(0.085),
    offset: Offset(0.0, -2.0),
    blurRadius: 4.0,
  );
}
