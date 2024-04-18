class Note {
  final String? id;
  final String? title;
  final String? note;

  Note({ this.id, required this.title, required this.note});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
        id: json['id'].toString(),
        title: json['Title'],
        note: json['Discription']);
  }
  Map<String,dynamic> toJson()=>{
    'id':id,
    'Title':title,
    'Discription':note,

  };
}
