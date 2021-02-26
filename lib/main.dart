import 'package:Shop_app/Providers/auth.dart';
import 'package:Shop_app/screens/products_overview_screens.dart';
import 'package:flutter/material.dart';

import './screens/product_detail_screen.dart';
import 'Providers/products_provider.dart';
import 'package:provider/provider.dart';
import './Providers/cart.dart';
import './screens/cart_screen.dart';
import './Providers/orders.dart';
import './screens/Orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './Providers/auth.dart';
import './screens/splash_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
                  create: (_)=>Products("","",[]),
                  update: (ctx, auth, previousProducts) 
            => Products(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items,
              
                ),
          ),
        ChangeNotifierProvider(
          create: (ctx)=> Cart(),
          ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_)=>Orders("","",[]),
                  update: (ctx, auth, previousOrders) 
            => Orders(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders,
         ), 
        ),       
      ],
      
    
     //if creating a newinstance then use create method otherwise use value approach as in product grid 
          child: Consumer<Auth>(
            builder:
             (
               ctx, auth,_)=>
                MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Shop App",
          theme: ThemeData(
            primarySwatch: Colors.yellow,
            accentColor: Colors.pink,
          ),
          home: auth.isAuth
          ? ProductsOverviewScreen() 
          : FutureBuilder(
               future: auth.tryAutoLogin(),
              builder:(ctx,authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting ? SplashScreen() : AuthScreen(),
              ),
  
    routes: {
            ProductDetailscreen.routeName:(ctx)=> ProductDetailscreen(),
            CartScreen.routeName:(ctx)=> CartScreen(),
            OrdersScreen.routeName:(ctx)=> OrdersScreen(),
            UserProductScreen.routeName: (ctx) => UserProductScreen(),
            EditProductScreen.routeName:(ctx) => EditProductScreen(),
          },
      
    ),
  ),
);
    
  }
}


