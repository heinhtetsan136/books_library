import 'dart:typed_data';

import 'package:book_library/const/app_theme_token.dart';
import 'package:book_library/data/author_model.dart';
import 'package:book_library/provider/author_provider.dart';
import 'package:book_library/view/author_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({super.key});

  @override
  State<AuthorPage> createState() =>
      _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
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
      ).getAllAuthor();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appThemeToken = Theme.of(
      context,
    ).extension<AppThemeTokens>()!;
    return ColoredBox(
      color: appThemeToken.background,
      child: Consumer<AuthorProvider>(
        builder: (_, provider, __) {
          List<AuthorModel> authors =
              provider.author;
          return ListView.builder(
            itemCount: authors.length,
            itemBuilder: (_, index) {
              final author = authors[index];
              final Uint8List? photo =
                  author.photo;
              final String name = author.name;
              final String description =
                  author.description;
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return AuthorDetails(
                          author: author,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(
                    bottom: 16.0,
                    left: 16,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                    color: appThemeToken.surface,
                    borderRadius:
                        BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      if (photo != null)
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              MemoryImage(photo),
                        ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Text(
                              maxLines: 1,
                              overflow:
                                  TextOverflow
                                      .ellipsis,
                              name,
                              style: TextStyle(
                                fontSize: 17,
                                color: appThemeToken
                                    .onBackground,
                                fontWeight:
                                    FontWeight
                                        .w600,
                              ),
                            ),
                            Text(
                              maxLines: 2,
                              overflow:
                                  TextOverflow
                                      .ellipsis,
                              description,
                              style: TextStyle(
                                fontSize: 14,
                                color: appThemeToken
                                    .textSecondary,
                                fontWeight:
                                    FontWeight
                                        .w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
