import 'package:book_library/provider/author_provider.dart';
import 'package:book_library/view/widget/input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/app_theme_token.dart';

class AddAuthorSheet extends StatefulWidget {
  const AddAuthorSheet({super.key});

  @override
  State<AddAuthorSheet> createState() =>
      _AddAuthorSheetState();
}

class _AddAuthorSheetState
    extends State<AddAuthorSheet> {
  @override
  Widget build(BuildContext context) {
    final authorProvider =
        Provider.of<AuthorProvider>(
          context,
          listen: false,
        );
    final appThemeToken = Theme.of(
      context,
    ).extension<AppThemeTokens>()!;
    final TextEditingController _namecontroller =
        TextEditingController();
    final TextEditingController
    _descriptionController =
        TextEditingController();
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
                "Insert Book Record",
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
          Text(
            "Upload Photo(Optional)",
            style: TextStyle(
              color: appThemeToken.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text("Upload Photo"),
          ),
          InkWell(
            onTap: () async {
              String name = _namecontroller.text
                  .trim();
              String desc = _descriptionController
                  .text
                  .trim();
              if (name.isNotEmpty &&
                  desc.isNotEmpty) {}
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 16,
              ),
              alignment: Alignment.center,
              height: 50,
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
