class Poster {
  String name;
  String email;
  Stream phone;
  Poster({required this.name, required this.email, required this.phone});
  factory Poster.fromJson(Map<String, dynamic> json) {
    return Poster(
        name: json['name'], email: json['email'], phone: json['phone']);
  }
}
