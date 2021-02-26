import 'package:Shop_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/orders.dart'show Orders;
import '../widgets/order_item.dart';



class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key key}) : super(key: key);
  static const routeName = "/orders";

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  
   @override
   initState()  {
    //  Future.delayed (Duration.zero).then((_) async {
        
    //       _isLoading= true;
        
    //   Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) 
    //  {   setState(() {
    //     _isLoading = false;
    //   });
    //  });
    
      //  }
     
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
  //final orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title:Text("Your Orders"),
      ),
      drawer: AppDrawer(),
     body: FutureBuilder(
       future:  Provider.of<Orders>(context, listen: false).fetchAndSetOrders() , 
       builder: (ctx,dataSnapshot){
       if(  dataSnapshot.connectionState == ConnectionState.waiting){
           return Center(child: CircularProgressIndicator());
       }
       else{
           if(dataSnapshot.error != null){
               return Center(child:Text("An error occured"));
           }
           else{
               return Consumer<Orders>(
                 builder: (ctx, orderData,child)=> ListView.builder(
                      itemBuilder:(ctx,i)=> OrderItem (
                       orderData.orders[i]
                    ),
                         itemCount:orderData.orders.length)) ;
           }
       }
       },
       ),
       
      
    );
  }
}