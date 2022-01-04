class post {
  int userId;
  int id;
  String title;
  String body;
  post(
      {required this.userId,
      required this.id,
      required this.body,
      required this.title});
  factory post.fromJson(Map<String, dynamic> json) {
    return post(
        userId: json['userId'],
        id: json['id'],
        body: json['body'],
        title: json['title']);
  }
}
