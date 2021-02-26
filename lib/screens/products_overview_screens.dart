import 'package:Shop_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import 'package:provider/provider.dart';
import '../Providers/cart.dart';
import '../screens/cart_screen.dart';
import '../Providers/products_provider.dart';



enum FilterOptions{
  Favourites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
 
 var _showOnlyFavourites = false;
 var _isInit = true;
 var _isLoading = false;

//  @override
//   void initState() {
//     //Provider.of<Products>(context).fetchAndSetProducts();
   
//     super.initState();
//   }

@override
  void didChangeDependencies() {
    
    if(_isInit){
     
     setState(() {
        _isLoading = true;
     });
  
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
       
       setState(() {
          _isLoading = false;
      });
      
      });
     
    }
    _isInit = false;

    super.didChangeDependencies();
  }

 
 @override
  Widget build(BuildContext context) { 

  return Scaffold(
      appBar: AppBar(
        title:Text("MyShop"),
        actions: [
         PopupMenuButton(
           onSelected: (FilterOptions selectedValue){
            setState(() {
               if(selectedValue == FilterOptions.Favourites){
                _showOnlyFavourites = true;
            }
            else{
                     _showOnlyFavourites = false;
            }
          });
            
           
           } ,
           icon: Icon(Icons.more_vert),
           itemBuilder: (_) =>[
             PopupMenuItem(child: Text("Only Favourites"), value:FilterOptions.Favourites),
            PopupMenuItem(child: Text("Show All"), value:FilterOptions.All),
           ],
           ),
          Consumer<Cart>(
            builder:(_,cart,ch)=>Badge(
             child:ch,
             value:cart.itemCount.toString(),
           
          ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
               onPressed: (){
                 Navigator.of(context).pushNamed(CartScreen.routeName);
               }
              ),
          ), 
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child:CircularProgressIndicator() ) : ProductsGrid(_showOnlyFavourites),
    );
  }
}















