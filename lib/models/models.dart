class Note {
  final String? id;
  final String? title;
  final String? description;


    Note({ this.id, required this.title, required this.description});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'].toString(), 
      title: json['Title']??'null found',
      description: json['Discription']??'null found',
    );
  }



  Map<String, dynamic> toJson() => {
    'id' : id,
    'Title': title,
    'Discription': description, 
  };
}