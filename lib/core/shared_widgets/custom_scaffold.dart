import 'package:flutter/material.dart';

import '../../features/home/views/widgets/main_drawer.dart';
import '../utils/app_assets.dart';
import 'custom_app_bar.dart';
import 'notification_drawer.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    // this.drawer,
    this.endDrawer,
    this.isHomeScreen = false,
    this.drawerSelectedIndex,
    this.showDrawer = true,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  // final Widget? drawer;
  final Widget? endDrawer;
  final bool? isHomeScreen;
  final bool? showDrawer;
  final int? drawerSelectedIndex;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: isHomeScreen! ? true : false,
        appBar: isHomeScreen! ? customAppBar(context) : appBar,
        floatingActionButton: isHomeScreen! ? floatingActionButton : null,
        bottomNavigationBar: isHomeScreen! ? bottomNavigationBar : null,
        drawer: showDrawer!
            ? MainDrawer(selectedIndex: drawerSelectedIndex ?? 0)
            : null,
        endDrawer: isHomeScreen! ? NotificationDrawer() : endDrawer,
        body: Stack(
          children: [
            Image.asset(
              AppAssets.scaffoldBackground,
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),

            // body
            body,
          ],
        ),
      ),
    );
  }
}
