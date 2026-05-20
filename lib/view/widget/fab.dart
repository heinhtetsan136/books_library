import 'package:book_library/const/app_theme_token.dart';
import 'package:flutter/material.dart';

class Fab extends StatefulWidget {
  final VoidCallback onPress;
  const Fab({super.key, required this.onPress});

  @override
  State<Fab> createState() => _FabState();
}

class _FabState extends State<Fab> {
  @override
  Widget build(BuildContext context) {
    final AppThemeTokens appThemeTokens =
        Theme.of(
          context,
        ).extension<AppThemeTokens>()!;
    return InkWell(
      onTap: widget.onPress,
      child: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              appThemeTokens.primary,
              appThemeTokens.secondary,
            ],
          ),
        ),
        child: Icon(
          Icons.add,
          color: appThemeTokens.onPrimary,
          size: 28,
        ),
      ),
    );
  }
}
