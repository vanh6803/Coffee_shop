import 'package:fontend/models/product.dart';

class Cart {
  String? id;
  Product? product;
  String? user;
  String? size;
  int? quantity;

  Cart({this.id, this.product,this.user, this.size, this.quantity});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    product =  Product.fromJson(json['product']);
    user = json['user'];
    size = json['size'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = id;
    data['product'] = product;
    data['user'] = user;
    data['size'] = size;
    data['quantity'] = quantity;
    return data;
  }
}
