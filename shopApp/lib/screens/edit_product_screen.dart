import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/providers/product.dart';
import 'package:shopApp/providers/products.dart';

class EditProductScreen extends StatefulWidget {

  static const routeName = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(id: null, title: "", price: 0, description: "", imageUrl: "");
  var _initValues = {
    "title": "", "price": "", "description": "", "imageUrl": ""
  };

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if(_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if(productId != null) {
        _editedProduct = Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          "title": _editedProduct.title, "price": _editedProduct.price.toString(), "description": _editedProduct.description,
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl() {
    if(!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if(!isValid) {
      return;
    }
    _form.currentState.save();
    if(_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false).updateProduct(_editedProduct.id, _editedProduct);
    }
    else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){
              _saveForm();
            },
          )
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            TextFormField(
              initialValue: _initValues["title"],
              decoration: InputDecoration(
                labelText: "Title"
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              onSaved: (value) {
                _editedProduct = Product(id: _editedProduct.id, title: value, price: _editedProduct.price, description: _editedProduct.description, imageUrl: _editedProduct.imageUrl);
              },
              validator: (value) {
                if(value.isEmpty) {
                  return "Please enter a title.";
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _initValues["price"],
              decoration: InputDecoration(
                  labelText: "Price"
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              onSaved: (value) {
                _editedProduct = Product(id: _editedProduct.id, title: _editedProduct.title, price: double.parse(value), description: _editedProduct.description, imageUrl: _editedProduct.imageUrl);
              },
              validator: (value) {
                if(value.isEmpty) {
                  return "Please enter a price.";
                }
                if(double.tryParse(value) == null) {
                  return "Please enter a valid number.";
                }
                if(double.parse(value) <= 0) {
                  return "Please a enter a positive number.";
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _initValues["description"],
              decoration: InputDecoration(
                  labelText: "Description"
              ),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
              onSaved: (value) {
                _editedProduct = Product(id: _editedProduct.id, title: _editedProduct.title, price: _editedProduct.price, description: value, imageUrl: _editedProduct.imageUrl);
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(top: 8, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey
                    )
                  ),
                  child: _imageUrlController.text.isEmpty? Text("Enter a URL") : FittedBox(
                    child: Image.network(_imageUrlController.text),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Image URL"),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    onSaved: (value) {
                      _editedProduct = Product(id: _editedProduct.id, title: _editedProduct.title, price: _editedProduct.price, description: _editedProduct.description, imageUrl: value);
                    },
                    validator: (value) {
                      if(!value.startsWith("http") && !value.startsWith("https")) {
                        return "Please enter a valid url.";
                      }
                      if(!value.endsWith(".png") && !value.endsWith("jpg") && !value.endsWith("jpeg")) {
                        return "Please enter a valid image url.";
                      }
                      return null;
                    },
                  ),
                )
              ],
            )
          ]
        )
      )
    );
  }
}
