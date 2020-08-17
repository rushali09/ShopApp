import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../Providers/product.dart';
import '../Providers/cart.dart';

class ProductItem extends StatelessWidget {
  
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id,this.title,this.imageUrl);
  
  @override
  Widget build(BuildContext context) {
    final product= Provider.of<Product>(context,listen: false);
    final cart = Provider.of<Cart>(context,listen: false);


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
            product.toggleFavouriteStatus();
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
             },
          ),
        ) ,
      ),
    );
  }
}
