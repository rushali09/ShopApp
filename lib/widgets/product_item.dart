import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../Providers/product.dart';
import '../Providers/cart.dart';
import '../Providers/auth.dart';

class ProductItem extends StatelessWidget {
  
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id,this.title,this.imageUrl);
  
  @override
  Widget build(BuildContext context) {
    final product= Provider.of<Product>(context,listen: false);
    final cart = Provider.of<Cart>(context,listen: false);
    final authData = Provider.of<Auth>(context,listen: false);

      return ClipRRect(
          borderRadius:BorderRadius.circular(10),
          child: GridTile(
        child: GestureDetector(
              onTap:(){
                Navigator.of(context).pushNamed(ProductDetailscreen.routeName,arguments: product.id);
              } ,
                  
                  child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
      ),
        ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: Icon( product.isFavourite ?  Icons.favorite :Icons.favorite_border, color:Theme.of(context).accentColor),
          onPressed: (){
            product.toggleFavouriteStatus(authData.token,authData.userId);
          }
          
        ),
        title:Text(
          product.title,
          textAlign: TextAlign.center,
        ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart,color:Theme.of(context).accentColor),
             onPressed: (){
               cart.addItem(product.id, product.price, product.title);
               Scaffold.of(context).hideCurrentSnackBar();
               Scaffold.of(context).showSnackBar(
                 SnackBar(
                   action: SnackBarAction(
                     label: "UNDO",
                     onPressed: (){
                       cart.removeSingleItem(product.id);
                     }
                    ),
                   duration: Duration(seconds:2),
                   content: Text("Added Item To The Cart" , textAlign: TextAlign.start),
                ),
              );
             },
          ),
        ) ,
      ),
    );
  }
}
