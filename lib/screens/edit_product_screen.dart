import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/product.dart';
import '../Providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
   
   static const routeName = "/edit-product";
  
  EditProductScreen({Key key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  
  final _priceFocusNode =FocusNode();
  final _descFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editProduct = Product(
    description: null,
    id: null,
    imageUrl: " ",
    price: 0,
    title: " ",
    );
    
    var _initValues = {
      "title" : "",
      "description": "",
      "price":"",
      "imageUrl" : "",
    };
    var _isInit = true;
    var _isLoading = false;
  
  final _imageUrlController = TextEditingController();
  

  @override
  void initState(){

    _imageUrlFocusNode.addListener(_updateImageUrl);
        super.initState();
  }

  @override
  void didChangeDependencies() {
     
     if (_isInit){
       
        final productId =ModalRoute.of(context).settings.arguments as String;
        if(productId != null){

            _editProduct =  Provider.of<Products>(context,listen: false).items.firstWhere((prod)=>prod.id==productId);
        _initValues={
      "title" : _editProduct.title,
      "description": _editProduct.description,
      "price":_editProduct.price.toString(),
      //"imageUrl" : _editProduct.imageUrl,
      "imageUrl":"",
        };
        _imageUrlController.text = _editProduct.imageUrl;
        }
      
     }
     _isInit = false;

    super.didChangeDependencies();
  }

  void _updateImageUrl(){
        if(!_imageUrlFocusNode.hasFocus){
          
           if(_imageUrlController.text.isEmpty ||
                (!_imageUrlController.text.startsWith("http") &&
                   !_imageUrlController.text.startsWith("https")) ||
                      (!_imageUrlController.text.endsWith(".png") &&
                       !_imageUrlController.text.endsWith(".jpg") &&
                        !_imageUrlController.text.endsWith(".jpeg"))){
                         
                        
                        return ;
                      }
          setState(() {}); 
  }
  }

  Future<void>  _saveForm()async { //basically to connect "save method" with the "form" generate a Globalkey [final _form = GlobalKey<FormState>();]in the State, then mention that key in the form[Key:_form], and finally mention it in the method to be called by  [_form.currentState.save();]
     final isValid =  _form.currentState.validate();   
     if(!isValid){
       return;
     }
     _form.currentState.save();
     setState(() {
       _isLoading =true;
     });
      if (_editProduct.id!=null){
          await  Provider.of<Products>(context, listen: false)
            .updateProduct(_editProduct.id,_editProduct);
          
      }else{

          try{
               await Provider.of<Products>(context, listen: false)
                  .addProduct(_editProduct);
          } catch(error){
              await   showDialog(
                        context: context,
                        builder:(ctx)=> AlertDialog(
                          title: Text("An error occurred"),
                          content: Text("Something Went Wrong"),
                          actions: [
                            FlatButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child: Text("Okay"))
                          ],
                        )
                      );
          }
       
              
      //           finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
                 
    }
         setState(() {
              _isLoading= false;
            });
             Navigator.of(context).pop();
       
  }

  @override
  void dispose(){
       _imageUrlFocusNode.removeListener(_updateImageUrl);
      _priceFocusNode.dispose();
      _descFocusNode.dispose();
      _imageUrlFocusNode.dispose();
      _imageUrlController.dispose();
      super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

   
    return Scaffold(
      appBar: AppBar(
        title:Text("Edit Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.save), 
            onPressed: _saveForm
          ),
        ],
      ),
      body: _isLoading
            
            ? Center(child:CircularProgressIndicator(),)
            
            : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(

          key: _form,
          

          child: ListView(
            children: [
             
             
             
              TextFormField(
                initialValue: _initValues["title"] ,
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                }, 
               
               validator: (value){
                   if(value.isEmpty){
                     return "Please provide a value";
                   }
                   return null;
               },

               onSaved: (value){
                  _editProduct = Product(
                    description: _editProduct.description,
                    id: _editProduct.id,
                    isFavourite: _editProduct.isFavourite,
                    imageUrl: _editProduct.imageUrl, 
                    price: _editProduct.price, 
                    title: value,

                    );
               },
              ),
               
            

               
               
               
               TextFormField(
                  initialValue: _initValues["price"] ,
                decoration: InputDecoration(
                  labelText: "Price",
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_){
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },

                 validator: (value) {
                     if(value.isEmpty){
                       return "Please enter a price";
                     }
                     if(double.tryParse(value)== null){
                       return "Please enter a valid number";
                     }
                     if(double.parse(value)<=0){
                       return "Please enter a number greater than Zero";
                     }
                     return null;
                 },  

                 onSaved: (value){
                  _editProduct = Product(
                    description: _editProduct.description,
                   
                    imageUrl: _editProduct.imageUrl, 
                    price: double.parse(value), 
                    title: _editProduct.title,
                      id: _editProduct.id,
                    isFavourite: _editProduct.isFavourite,
                    );
               },
              ),

               
               
               
               
               TextFormField(
                  initialValue: _initValues["description"] ,
                decoration: InputDecoration(
                  labelText: "Description",
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                focusNode: _descFocusNode,
              
               
               validator: (value){
                 if(value.isEmpty){
                   return "Please enter a descrpition";
                 }
                 if(value.length<10){
                   return "Should be atleast 10 characters long";
                 }
                 return null;
               },
               onSaved: (value){
                  _editProduct = Product(
                    description: value,
                    id: _editProduct.id,
                    isFavourite: _editProduct.isFavourite,
                    imageUrl: _editProduct.imageUrl, 
                    price: _editProduct.price, 
                    title: _editProduct.title,
                    );
               },
              ),





              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  
                  Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top:8, right: 10),
                      decoration: BoxDecoration(
                        border:Border.all(
                          width: 1, 
                          color:Colors.grey
                          ),
                      ),
                      child:_imageUrlController.text.isEmpty ? Padding(
                        padding: const EdgeInsets.all(27.0),
                        child: Text("Enter URL", textAlign: TextAlign.center,),
                      ) : FittedBox(
                                   
                                   child: Image.network(_imageUrlController.text,
                                   fit:BoxFit.cover,
                                   ),
                                   ),
                  ),

                  Expanded(
                                      child: TextFormField(
                                        
                       decoration: InputDecoration(
                         labelText: "Image URL"
                       ),
                       keyboardType: TextInputType.url,
                       textInputAction: TextInputAction.done,
                       controller: _imageUrlController,
                       focusNode: _imageUrlFocusNode,
                       onFieldSubmitted:(_){
                         _saveForm();
                       },
                      

                       validator: (value) {
                         return null;
                       },
                        onSaved: (value){
                  _editProduct = Product(
                    description: _editProduct.description,
                     id: _editProduct.id,
                    isFavourite: _editProduct.isFavourite,
                    imageUrl: value, 
                    price: _editProduct.price, 
                    title: _editProduct.title,
                    );
               },
                    ),
                  ),
              ],
            ),
            ],
          ), 
          ),
      ),
    );
  }
}