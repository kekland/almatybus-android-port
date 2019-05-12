import 'package:almaty_bus/design/design.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    @required this.builder,
    RouteSettings settings,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    final result = builder(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: SwipeDetector(
          onSwipeRight: () => Navigator.of(context).pop(),
          child: Container(
            color: Colors.black45,
            child: result,
          ),
        ),
      ),
    );
  }
}
