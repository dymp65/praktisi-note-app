class NoteModel {
  int? id;
  String? title;
  String? note;

  NoteModel({
    this.id,
    this.title,
    this.note,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['note'] = note;

    return map;
  }

  NoteModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.note = map['note'];
  }
}
