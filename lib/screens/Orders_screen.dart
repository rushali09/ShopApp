import 'package:Shop_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/orders.dart'show Orders;
import '../widgets/order_item.dart';



class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key key}) : super(key: key);
  static const routeName = "/orders";
  @override
  Widget build(BuildContext context) {
   
  final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title:Text("Your Orders"),
      ),
      drawer: AppDrawer(),
     body: ListView.builder(
       itemBuilder:(ctx,i)=> OrderItem (
        orderData.orders[i]
       ),
       itemCount:orderData.orders.length)
    );
  }
}