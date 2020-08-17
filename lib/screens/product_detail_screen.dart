import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/products_provider.dart';

class ProductDetailscreen extends StatelessWidget {
  // final String title;

  // ProductDetailscreen(this.title);
  static const routeName = "/product-detail";

  @override
  Widget build(BuildContext context) {
 final productId =  ModalRoute.of(context).settings.arguments as String;
 final loadedProduct= Provider.of<Products>(context,listen: false).items.firstWhere((prod)=>prod.id==productId);

    return Scaffold(
      appBar: AppBar(
        title:Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
              child: Column(
            children: [
              Container(
        height: 300,
        width: double.infinity,
        child:Image.network(
          loadedProduct.imageUrl,
           fit: BoxFit.cover)
              ),
           SizedBox(
             height: 10,
           ),
           Text("\$${loadedProduct.price}", style:TextStyle(fontSize: 20, color: Colors.grey),
           ),
            SizedBox(
             height: 10,
           ),
           Container(
             padding: EdgeInsets.symmetric(horizontal:10),
             child: Text(
               loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true),),
            ],
          ),
      ),

    );
  }
}