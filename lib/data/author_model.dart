import 'dart:typed_data';

class AuthorModel {
  final int id;
  final String name, description;
  final Uint8List? photo;
  final int? fav;

  AuthorModel({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
    required this.fav,
  });

  factory AuthorModel.fromJson(dynamic data) {
    return AuthorModel(
      id: data["id"],
      name: data["name"],
      description: data["description"],
      photo: data["photo"],
      fav: data["fav"],
    );
  }
}
