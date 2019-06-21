import 'package:almaty_bus/design/design.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;

  const AppBarWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64.0,
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [Shadows.slightShadow],
      ),
      alignment: Alignment.center,
      child: DefaultTextStyle.merge(
        style: ModernTextTheme.boldTitle.copyWith(color: Colors.white),
        child: title,
      ),
    );
  }

  Size get preferredSize {
    return new Size.fromHeight(64.0);
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
