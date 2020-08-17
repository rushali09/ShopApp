import 'package:flutter/material.dart';
import './screens/products_overview_screens.dart';
import './screens/product_detail_screen.dart';
import 'Providers/products_provider.dart';
import 'package:provider/provider.dart';
import './Providers/cart.dart';
import './screens/cart_screen.dart';
import './Providers/orders.dart';
import './screens/Orders_screen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx)=>Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx)=> Cart(),
          ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
          ),  
      ], 
      
    
     //if creating a newinstance then use create method otherwise use value approach as in product grid 
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Shop App",
          theme: ThemeData(
            primarySwatch: Colors.yellow,
            accentColor: Colors.pink,
          ),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailscreen.routeName:(ctx)=> ProductDetailscreen(),
            CartScreen.routeName:(ctx)=> CartScreen(),
            OrdersScreen.routeName:(ctx)=> OrdersScreen(),
          },
      
    )
  );
    
  }
}


