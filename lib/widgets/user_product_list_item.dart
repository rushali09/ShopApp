import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../Providers/products_provider.dart';

class UserProductListItem extends StatelessWidget {
 
 final String id;
 final String title;
 final String imageUrl;

 UserProductListItem(this.id,this.title,this.imageUrl);

  @override
  Widget build(BuildContext context) {

    final scaffold = Scaffold.of(context);
    return Card(
         
          elevation: 6,
          shadowColor: Colors.yellow[400],     
          child: ListTile(
        title:Text(title),
        leading: CircleAvatar(
          backgroundImage:NetworkImage(imageUrl), //its not a widget 
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit,
                 color:Theme.of(context).primaryColor,
                 ),
                onPressed: (){
                  Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id );
                }
                ),


              IconButton(
                icon: Icon(Icons.delete,
                 color:Theme.of(context).errorColor,
                ),
                
                onPressed:() async {
                  try{
                  await  Provider.of<Products>(context,listen: false).deleteProduct(id);
                } catch (error){
                     scaffold.showSnackBar(
                       SnackBar(
                         content: Text("Deletion failed", textAlign: TextAlign.center),
                         ),
                        );
                }
              } 
                ),  
            ],
          ),
        ),
      ),
    );
  }
}