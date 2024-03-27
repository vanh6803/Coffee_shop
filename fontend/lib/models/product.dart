class Product {
  String? id;
  String? name;
  String? category;
  String? image;
  int? price;
  String? about;
  List<String>? ingredients;

  Product(
      {this.id,
      this.name,
      this.category,
      this.image,
      this.price,
      this.about,
      this.ingredients});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    category = json['category'];
    image = json['image'];
    price = json['price'];
    about = json['about'];
    if (json['ingredients'] != null) {
      ingredients = json['ingredients'].cast<String>();
    } else {
      ingredients = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['image'] = image;
    data['price'] = price;
    data['about'] = about;
    data['ingredients'] = ingredients;
    return data;
  }
}
