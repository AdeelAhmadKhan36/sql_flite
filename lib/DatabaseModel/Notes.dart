
class NotesModel{

  int? id;
  String? title;
  String? description;
  String? email;

  NotesModel({
    this.id,
    required this .title,
    required this.description,
    this.email

  });
  NotesModel.fromMap(Map<String ,dynamic> res):
        id=res['id'],
        title=res['title'],
        description=res['description'],
        email=res['email'];

  Map<String ,Object?> toMap(){
    return {
      'id':id,
      'title': title,
      'description':description,
      'email':email
    };

  }



}