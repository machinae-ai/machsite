import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/admin/user_details.dart';
import 'package:machsite/admin/user_list.dart';
import 'package:machsite/app_bar.dart';
import 'package:machsite/drawer.dart';
import 'package:machsite/common.dart';

import 'admin/user_details_page.dart';
import 'admin/users_page.dart';

//Accessed by clicking workaround button on login page for time being
class AdminViewWidget extends ConsumerWidget {
  const AdminViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          // Cast the arguments to the correct
          // type: ScreenArguments.

          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          // return MaterialPageRoute(
          //   builder: (context) {
          //     return PassArgumentsScreen(
          //       title: args.title,
          //       message: args.message,
          //     );
          //   },
          // );
          // print('onGenerateRoute: ${settings}');
          // if (settings.name == '/' || settings.name == 'search') {
          if (settings.name == '/' || settings.name == 'clients') {
            return PageRouteBuilder(pageBuilder: (_, __, ___) => UsersPage());
          } else if (settings.name == UserDetailsPage.routeName) {
            return PageRouteBuilder(pageBuilder: (_, __, ___) {
              //print('args: ${ModalRoute.of(context)!.settings}');
              final args = settings.arguments as PageArguments;

              // final args =
              //     ModalRoute.of(context)!.settings.arguments as ScreenArguments;
              // print('args: ${args}');
              return UserDetailsPage(args.title);
            });
          } else {
            throw 'no page to show for ${settings.name}';
          }
        },
      ));
}

class PageArguments {
  final String title;
  final String message;

  PageArguments(this.title, this.message);
}
