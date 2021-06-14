import 'dart:convert';
class Model {
   int userId;
   int id;
   String title;

  Model({required this.userId, required this.id, required this.title});
  // {userId: 1, id: 2, title: sunt qui excepturi placeat culpa}
  factory Model.fromJson(Map<String, dynamic> jsonMake) => Model(

        id: jsonMake['id'],
      userId: jsonMake['userId'],
        title: jsonMake['title'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
