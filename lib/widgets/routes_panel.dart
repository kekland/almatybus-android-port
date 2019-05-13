import 'package:almaty_bus/design/design.dart';
import 'package:almaty_bus/widgets/route_chip.dart';
import 'package:flutter/material.dart';

class RoutesPanel extends StatefulWidget {
  final bool minimized;
  final Function onPanelTap;
  final VoidCallback openSelection;
  final List<Route> routes;

  const RoutesPanel({Key key, this.minimized, this.onPanelTap, this.openSelection, this.routes}) : super(key: key);
  @override
  _RoutesPanelState createState() => _RoutesPanelState();
}

class _RoutesPanelState extends State<RoutesPanel> with SingleTickerProviderStateMixin {
  bool _textVisible = true;
  bool _minimized = false;

  _close() {
    setState(() {
      _textVisible = false;
    });

    new Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _minimized = true;
      });
    });
  }

  _open() {
    setState(() {
      _minimized = false;
    });
    new Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _textVisible = true;
      });
    });
  }

  @override
  didUpdateWidget(RoutesPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.minimized && !oldWidget.minimized) {
      _close();
    } else if (!widget.minimized && oldWidget.minimized) {
      _open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16.0),
      elevation: 4.0,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: widget.onPanelTap,
        borderRadius: BorderRadius.circular(16.0),
        onLongPress: widget.openSelection,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 750),
          curve: Curves.elasticOut,
          padding: _minimized ? EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0) : EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: !_minimized,
                child: AnimatedOpacity(
                  opacity: _textVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 100),
                  curve: Curves.easeInOutCubic,
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Автобусы',
                        style: ModernTextTheme.boldTitle,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: double.infinity),
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
            ],
          ),
        ),
      ),
    );
  }
}
