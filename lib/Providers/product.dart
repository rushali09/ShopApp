import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

 //product model or blueprint

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl; //image stored on server not on asset
  bool isFavourite;


  Product({
    @required this.description,
    @required this.id,
    @required this.imageUrl,
    @required this.price,
    @required this.title,
    this.isFavourite = false, 
  });

  void _setFavValue(bool newValue){
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void>toggleFavouriteStatus(String token, String userId) async {
    
    final oldStatus = isFavourite;

    isFavourite=!isFavourite;
    notifyListeners();
    
     final url  = "https://shop-app-f98e3.firebaseio.com/userFavourites/$userId/$id.json?auth=$token";
     
     try{
     
     final response = await http.put(url , body: json.encode(isFavourite,
     ));
     
    if(response.statusCode >= 400){
      _setFavValue(oldStatus);
    }
     
} catch(error){
   _setFavValue(oldStatus);
}
  }  
  
}

