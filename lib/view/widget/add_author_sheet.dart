import 'package:book_library/data/author_model.dart';
import 'package:book_library/provider/author_provider.dart';
import 'package:book_library/view/widget/input_field_widget.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../const/app_theme_token.dart';

class AddAuthorSheet extends StatefulWidget {
  final AuthorModel? authormodel;

  AddAuthorSheet({super.key, this.authormodel});

  @override
  State<AddAuthorSheet> createState() =>
      _AddAuthorSheetState();
}

class _AddAuthorSheetState
    extends State<AddAuthorSheet> {
  final TextEditingController _namecontroller =
      TextEditingController();
  final TextEditingController
  _descriptionController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.authormodel != null) {
      _namecontroller.text =
          widget.authormodel!.name;
      _descriptionController.text =
          widget.authormodel!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUpdate =
        widget.authormodel != null;
    final authorProvider =
        Provider.of<AuthorProvider>(context);
    final appThemeToken = Theme.of(
      context,
    ).extension<AppThemeTokens>()!;

    return Container(
      padding: EdgeInsets.all(30),
      height:
          MediaQuery.of(context).size.height *
          0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border(
          top: BorderSide(
            color: appThemeToken.border,
          ),
        ),
        color: appThemeToken.background,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isUpdate
                    ? "Update Author Record"
                    : "Insert Author Record",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color:
                      appThemeToken.onBackground,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
          InputFieldWidget(
            controller: _namecontroller,

            maxLines: 1,
            title: "Record Name",
            hintText: "Enter Author Name",
          ),
          SizedBox(height: 8),
          InputFieldWidget(
            controller: _descriptionController,

            maxLines: 5,
            title: "Author Description",
            hintText: "Enter Description",
          ),
          SizedBox(height: 8),
          isUpdate
              ? SizedBox()
              : Text(
                  "Upload Photo(Optional)",
                  style: TextStyle(
                    color: appThemeToken
                        .textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          isUpdate
              ? SizedBox()
              : TextButton(
                  onPressed: () async {
                    authorProvider.uploadImage();
                  },
                  child: Text("Upload Photo"),
                ),
          if (authorProvider.photo != null)
            Center(
              child: Image.memory(
                authorProvider.photo!,
                height: 150,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          if (authorProvider.photo != null)
            SizedBox(height: 8),
          InkWell(
            onTap: () async {
              String name = _namecontroller.text
                  .trim();
              String desc = _descriptionController
                  .text
                  .trim();
              if (name.isNotEmpty &&
                  desc.isNotEmpty) {
                int result = isUpdate
                    ? await authorProvider
                          .updateAuthor(
                            name: name,
                            description: desc,
                            id: widget
                                .authormodel!
                                .id,
                          )
                    : await authorProvider
                          .saveAuthor(
                            name: name,
                            description: desc,
                          );
                print(result);
                if (result > 0 &&
                    context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Save Sucessfully",
                      ),
                    ),
                  );
                }
              } else {
                showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text("Data Missing"),
                      content: Text(
                        "Name or Description is missing",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 16,
              ),
              alignment: Alignment.center,

              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(14),
                gradient: LinearGradient(
                  colors: [
                    appThemeToken.primary,
                    appThemeToken.secondary,
                  ],
                ),
              ),
              child: Text(
                "Save Author",

                style: TextStyle(
                  color: appThemeToken.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
