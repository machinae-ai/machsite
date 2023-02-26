import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:machsite/admin/user_details.dart';
import 'package:machsite/admin/user_list.dart';
import 'package:machsite/common.dart';
import 'package:machsite/drawer.dart';

import '../admin_app_bar.dart';
import '../admin_viewpage.dart';

class UserDetailsPage extends ConsumerWidget {
  static const routeName = '/client';

  final String uid;

  UserDetailsPage(this.uid, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print('building userDetails');
    // print(ModalRoute.of(context)!.settings);
    // final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: //AdminAppBar.getBar(context, ref),
          AppBar(
        title: Text('User Details for ${uid}'),
        actions: [ThemeIconButton(), SignOutButton()],
      ),
      drawer: (MediaQuery.of(context).size.width < WIDE_SCREEN_WIDTH)
          ? TheDrawer.buildDrawer(context)
          : null,
      body: Container(
          margin: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: UserDetails(uid))
              //Expanded(child: UserList()),
              // Expanded(child: UserDetails(ref.watch(activeUser)))
            ],
          )),
    );
  }
}
