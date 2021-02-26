import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/Orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../Providers/auth.dart';


class AppDrawer extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children:[
          AppBar(
            title:Text("Hello Friend"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),

            Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Orders"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
         Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage Products"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
            },
          ),
           Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(" Logout"),
            onTap: (){
                 Navigator.of(context).pop();
                 Navigator.of(context).pushReplacementNamed("/");
                 Provider.of<Auth>(context).logout();
            },
          ),
        ]
      ),
    );
  }
}