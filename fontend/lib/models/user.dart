class User {
  String? id;
  String? email;
  String? password;
  String? avatar;
  String? username;
  String? createdAt;
  String? updatedAt;
  String? token;

  User(
      {this.id,
      this.email,
      this.password,
      this.avatar,
      this.username,
      this.createdAt,
      this.updatedAt,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    email = json['email'];
    password = json['password'];
    avatar = json['avatar'];
    username = json['username'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['avatar'] = avatar;
    data['username'] = username;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['token'] = token;
    return data;
  }
}
