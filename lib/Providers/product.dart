import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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

  void toggleFavouriteStatus(){
    isFavourite=!isFavourite;
    notifyListeners();
  }
}

