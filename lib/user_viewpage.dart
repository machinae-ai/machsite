import 'package:flutter/material.dart';
import 'package:machsite/dashboard_page.dart';

import 'admin_viewpage.dart';

class UserViewWidget extends StatelessWidget {
  const UserViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Navigator(
          onGenerateRoute: (RouteSettings settings) {
            // print('onGenerateRoute: ${settings}');
            // if (settings.name == '/' || settings.name == 'search') {
            if (settings.name == '/' || settings.name == 'dashboard') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => DashboardPage());
            }
            if (settings.name == 'other') {
              return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => Text('other'));
            } else {
              throw 'no page to show';
            }
          },
        ));
  }
}
