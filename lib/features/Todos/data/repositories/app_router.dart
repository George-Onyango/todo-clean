import 'package:flutter/material.dart';

import '../../presentation/pages/recycle_bin.dart';
import '../../presentation/pages/tabs_screen.dart';

// import '../screens/recycle_bin.dart';
// import '../screens/tabs_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBin.id:
        return MaterialPageRoute(builder: (context) {
          return const RecycleBin();
        });
      case TabsScreen.id:
        return MaterialPageRoute(builder: (context) {
          return const TabsScreen();
        });
      default:
        return null;
    }
  }
}