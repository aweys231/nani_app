// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:nanirecruitment/helpers/custom_route.dart';
import 'package:nanirecruitment/screens/Availabilities.dart';
import 'package:nanirecruitment/screens/add_place_screen.dart';
import 'package:nanirecruitment/screens/availability.dart';
import 'package:nanirecruitment/screens/canidate_legal_info.dart';
import 'package:nanirecruitment/widgets/file_upload.dart';
import '../providers/auth.dart';

import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Settings!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dashboard_outlined),
            title: Text('Dhashboard'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.description_outlined),
            title: Text('legal information'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CanidateLegalInfor.routeName);
              // Navigator.of(context).pushReplacement(
              //     CustomRoute(builder: (ctx) => OrdersScreen(),),);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('Availability'),
            onTap: () {
             
              // Navigator.of(context)
              //     .pushReplacementNamed(Availability.routeName);
               Navigator.of(context)
                  .pushReplacementNamed(Availability.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text('location'),
            onTap: () {
               Navigator.of(context)
                  .pushReplacementNamed(AddPlaceScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Navigator.of(context).pop();
              // Navigator.of(context).pushReplacementNamed('/');
              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
