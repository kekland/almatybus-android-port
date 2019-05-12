import 'package:almaty_bus/design/design.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final Widget title;

  const AppBarWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64.0,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [Shadows.slightShadow],
      ),
      alignment: Alignment.center,
      child: DefaultTextStyle.merge(
        style: ModernTextTheme.boldTitle,
        child: title,
      ),
    );
  }
}

class AppBarBottomWidget extends StatelessWidget {
  final Widget title;

  const AppBarBottomWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [Shadows.slightShadowTop],
      ),
      alignment: Alignment.center,
      child: DefaultTextStyle.merge(
        style: ModernTextTheme.boldTitle,
        child: title,
      ),
    );
  }
}