import 'package:book_library/data/library_db.dart';
import 'package:flutter/foundation.dart';

class AuthorProvider extends ChangeNotifier {
  final LibraryDbService libraryDbService =
      LibraryDbService();

  Future<int> saveAuthor({
    required String name,
    required String description,
    Uint8List? photo,
  }) async {
    final result = await libraryDbService
        .insertAuthor(
          name: name,
          description: description,
          photo: photo,
        );
    return result;
  }
}
