import 'package:fontend/models/product.dart';

class OrderItem {
  Product? product;
  String? size;

  OrderItem({this.product, this.size});

  OrderItem.fromJson(Map<String, dynamic> json) {
    product = Product.fromJson(json['product']);
    size = json["size"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product'] = product;
    data['size'] = size;
    return data;
  }
}
