class Task {
  int? id;
  int? userid;
  String? title;
  int? completed;
  String? description;

  Task({
    this.id,
    this.userid,
    this.title,
    this.completed,
    this.description,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
    description = json['description'];
    userid = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = title;
    data['completed'] = completed;
    data['description'] = description;
    data['user_id'] = userid;
    return data;
  }
}
