import 'package:book_library/data/author_model.dart';
import 'package:book_library/data/library_db.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AuthorProvider extends ChangeNotifier {
  Uint8List? photo;
  final LibraryDbService libraryDbService =
      LibraryDbService();
  ImagePicker imagePicker = ImagePicker();
  List<AuthorModel> author = [];
  int isDetailFav = 0;

  Future<void> uploadImage() async {
    XFile? file = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    Uint8List? result = await file?.readAsBytes();

    if (result != null) {
      photo = result;
      notifyListeners();
    }
  }

  void getAllAuthor() async {
    author = await libraryDbService
        .getAllAuthor();
    notifyListeners();
  }

  Future<int> updateFav(int id, int isFav) async {
    final result = await libraryDbService
        .updateFav(id, isFav);
    isDetailFav = isFav;
    notifyListeners();

    print("result is $result");
    return result;
  }

  Future<int> getFav(int id) async {
    isDetailFav = await libraryDbService.getFav(
      id,
    );
    notifyListeners();
    return isDetailFav;
  }

  Future<int> saveAuthor({
    required String name,
    required String description,
  }) async {
    print(
      "name is $name and description is $description and photo is $photo",
    );
    final result = await libraryDbService
        .insertAuthor(
          name: name,
          description: description,
          photo: photo,
        );
    getAllAuthor();
    return result;
  }
}
