import 'dart:convert';
import 'dart:core';

class Note {
  String? id;
  String? userid;
  String? title;
  String? content;
  String? dateadded;
  Note({this.content, this.id, this.title, this.userid, this.dateadded});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userid': userid,
      'title': title,
      'content': content,
      'dateadded': dateadded,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        id: map['id'] != null ? map['id'] as String : null,
        userid: map['userid'] != null ? map['userid'] as String : null,
        title: map['title'] != null ? map['title'] as String : null,
        content: map['content'] != null ? map['content'] as String : null,
        dateadded: map['dateadded'] ?? null);
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);
}
