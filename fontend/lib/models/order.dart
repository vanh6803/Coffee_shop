import 'package:fontend/models/order_item.dart';

class Order {
  String? id;
  String? user;
  List<OrderItem>? productOrder;
  int? totalPrice;
  String? status;
  String? createdAt;
  String? updatedAt;

  Order({
    this.id,
    this.user,
    this.productOrder,
    this.totalPrice,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    user = json["user"];
    if (json["productOrder"] != null) {
      List<dynamic> list = json["productOrder"];
      productOrder = list.map((item) => OrderItem.fromJson(item)).toList();
    } else {
      productOrder = [];
    }
    totalPrice = json["totalPrice"];
    status = json["status"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['user'] = user;
    data['productOrder'] = productOrder;
    data['totalPrice'] = totalPrice;
    data['status'] = status;
    return data;
  }
}
