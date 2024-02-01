class NoteModel {
  String? noteId;
  String? noteTitle;
  String? noteContent;
  String? noteImage;
  String? noteUserId;
  String? noteDel;

  NoteModel(
      {this.noteId,
      this.noteTitle,
      this.noteContent,
      this.noteImage,
      this.noteUserId,
      this.noteDel});

  NoteModel.fromJson(Map<String, dynamic> json) {
    noteId = json['note_id'];
    noteTitle = json['note_title'];
    noteContent = json['note_content'];
    noteImage = json['note_image'];
    noteUserId = json['note_user_id'];
    noteDel = json['note_del'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['note_id'] = this.noteId;
  //   data['note_title'] = this.noteTitle;
  //   data['note_content'] = this.noteContent;
  //   data['note_image'] = this.noteImage;
  //   data['note_user_id'] = this.noteUserId;
  //   data['note_del'] = this.noteDel;
  //   return data;
  // }
}