import 'package:flutter/material.dart';
import 'package:machsite/dashboard_page.dart';

class TheDrawer {
  static Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: Container(
            child: Text('Machinae'),
            // Column(children: <Widget>[
            //   Material(
            //     child: Image.asset("amlcloud-lg.png", height: 50, width: 50),
            //   )
            // ]),
          )),
          ListTile(
              leading: IconButton(
                icon: Icon(Icons.search),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return DashboardPage();
                  },
                ));
              }),
          ListTile(
              leading: IconButton(
                icon: Icon(Icons.view_list),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
              title: const Text('Other'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Text('hi');
                  },
                ));
              }),
        ],
      ),
    );
  }
}
