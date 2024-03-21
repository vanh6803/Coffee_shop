
class Category {
  String? id;
  String? name;
  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = id;
    data['name'] = name;
    return data;
  }
}