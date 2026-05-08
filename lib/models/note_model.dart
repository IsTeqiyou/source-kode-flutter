class Note{
  int? id;
  String title;
  String content;
  String author;
  String createdAt;
  String updatedAt;

  Note({this.id, required this.title, required this.content, required this.author, required this.createdAt, required this.updatedAt});

  Map <String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'content': content,
    'author': author,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };

  factory Note.fromMap(Map<String, dynamic> map) => Note(
    id: map['id'],
    title: map['title'],
    content: map['content'],
    author: map['author'],
    createdAt: map['createdAt'],
    updatedAt: map['updatedAt'],
  );
}