import 'package:book_library/const/app_theme_token.dart';
import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  final String title,hintText;
  final int maxLines;
  final TextEditingController controller;
  const InputFieldWidget({
    super.key, required this.title, required this.hintText, required this.maxLines, required this.controller,

  });



  @override
  Widget build(BuildContext context) {
    final appThemeToken=Theme.of(context).extension<AppThemeTokens>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color:
            appThemeToken.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor:
            appThemeToken.surface,
            contentPadding:
            EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder:
            OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(
                12,
              ),
              borderSide: BorderSide(
                color: appThemeToken
                    .border,
              ),
            ),
            focusedBorder:
            OutlineInputBorder(
              borderRadius:
              BorderRadius.circular(
                12,
              ),
              borderSide: BorderSide(
                color: appThemeToken
                    .primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}