import 'package:flutter/material.dart';
import '../helpers/custom_route.dart';
import 'package:provider/provider.dart';
import '../screens/orders_screen.dart';
import '../providers/auth.dart';
import '../screens/howitworks_screen.dart';
import '../screens/service_overview_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello friend'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Services'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                CustomRoute(builder: (ctx) => ProductsOverviewScreen()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                CustomRoute(builder: (ctx) => OrdersScreen()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('How it works'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                CustomRoute(builder: (ctx) => HowItWorks()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
