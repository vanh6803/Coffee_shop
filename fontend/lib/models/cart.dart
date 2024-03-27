import 'package:fontend/models/product.dart';

class Cart {
  String? id;
  Product? product;
  String? user;
  String? size;

  Cart({this.id, this.product,this.user, this.size});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    product =  Product.fromJson(json['product']);
    user = json['user'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = id;
    data['product'] = product;
    data['user'] = user;
    data['size'] = size;
    return data;
  }
}
