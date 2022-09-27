// ignore_for_file: unnecessary_this

class User {
  int? id;
  String? name;
  String? email;
  String? image;
  String? token;

  User({this.id, this.name, this.email, this.image, this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['user']['id'];
    name = json['user']['name'];
    email = json['user']['email'];
    image = json['user']['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user']['id'] = this.id;
    data['user']['name'] = this.name;
    data['user']['email'] = this.email;
    data['user']['image'] = this.image;
    data['token'] = this.token;
    return data;
  }
}
