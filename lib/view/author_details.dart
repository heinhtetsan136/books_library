import 'dart:typed_data';

import 'package:book_library/const/app_theme_token.dart';
import 'package:book_library/data/author_model.dart';
import 'package:book_library/provider/author_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorDetails extends StatefulWidget {
  AuthorModel author;

  AuthorDetails({
    super.key,
    required this.author,
  });

  @override
  State<AuthorDetails> createState() =>
      _AuthorDetailsState();
}

class _AuthorDetailsState
    extends State<AuthorDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((
      _,
    ) {
      Provider.of<AuthorProvider>(
        context,
        listen: false,
      ).getFav(widget.author.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthorModel author = widget.author;
    final Uint8List? photo = author.photo;
    final String name = author.name;
    final String description = author.description;
    final themeTokens = Theme.of(
      context,
    ).extension<AppThemeTokens>()!;
    AuthorProvider authorProvider =
        Provider.of<AuthorProvider>(
          context,
          listen: false,
        );
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          photo != null
              ? Image.memory(
                  photo,
                  height: 350,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Container(
                  color: themeTokens.background,
                  height: 350,
                ),
          Positioned(
            top: 50,
            left: 30,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: themeTokens.backBtnBg,
                borderRadius:
                    BorderRadius.circular(24),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 30,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: themeTokens.backBtnBg,
                borderRadius:
                    BorderRadius.circular(24),
              ),
              child: Consumer<AuthorProvider>(
                builder: (context, provider, child) {
                  bool isFav =
                      provider.isDetailFav == 1;
                  print(isFav);
                  print(provider.isDetailFav);
                  return IconButton(
                    onPressed: () {
                      provider.updateFav(
                        author.id,
                        isFav ? 0 : 1,
                      );

                      // provider.updateFavourite(
                      //   widget.authorData.id,
                      //   isFav ? 0 : 1,
                      // );
                    },
                    icon: isFav
                        ? Icon(Icons.favorite)
                        : Icon(
                            Icons.favorite_border,
                          ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: -350,
            left: 50,
            right: 50,
            height: 400,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(
                  8.0,
                ),
                child: Column(
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 32,
                        color: themeTokens
                            .onBackground,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            themeTokens.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
