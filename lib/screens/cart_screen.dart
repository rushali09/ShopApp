import 'package:flutter/material.dart';
import '../Providers/cart.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart' as ci;
import '../Providers/orders.dart';

class CartScreen extends StatelessWidget {
   
   static const routeName ="/cart";

  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title:Text("Your Cart"),
      ),
      body: Column(
          children: [
            Card(
             margin: EdgeInsets.all(15),
             child:Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 children: [
                    Text("Total"),
                    SizedBox(width:60),
                    Chip(label: Text("\$${cart.totalAmount.toStringAsFixed(2)}"
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                    ),
                     SizedBox(width:60),
                    FlatButton(
                      color: Colors.pink,
                      onPressed: (){
                        Provider.of<Orders>(context,listen: false).addOrder(cart.items.values.toList(),cart.totalAmount);
                        cart.clear();
                      }, 
                      child: Text("ORDER NOW"),
                      textColor: Theme.of(context).primaryColor,
                      ),
                    ],
                    ),
                    ),
                  ),

                  SizedBox(height: 10 ),
                  Expanded(child: ListView.builder(itemBuilder:(ctx,i)=>ci.CartItem(
                     cart.items.keys.toList()[i],
                    cart.items.values.toList()[i].id,
                    cart.items.values.toList()[i].price,
                    cart.items.values.toList()[i].quantity,
                    cart.items.values.toList()[i].title,
                    
                    
                    ) ,
                  
                   itemCount:cart.items.length),),
           ], 
           ),
        );
}
}