class comment {
  int postId;
  int id;
  String name;
  String body;
  String email;
  comment(
      {required this.postId,
      required this.id,
      required this.name,
      required this.body,
      required this.email});
  factory comment.fromJson(Map<String, dynamic> json) {
    return comment(
        postId: json['postId'],
        id: json['id'],
        body: json['body'],
        name: json['name'],
        email: json['email']);
  }
}
