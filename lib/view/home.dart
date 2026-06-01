import 'package:book_library/view/author_page.dart';
import 'package:book_library/view/widget/add_author_sheet.dart';
import 'package:book_library/view/widget/bottom_nav.dart';
import 'package:book_library/view/widget/fab.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (_index) {
        1 => AuthorPage(),
        _ => SizedBox(),
      },
      floatingActionButton: _index == 2
          ? null
          : Fab(
              onPress: () {
                if (_index == 1) {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return AddAuthorSheet();
                    },
                  );
                }
              },
            ),
      bottomNavigationBar: BottomNav(
        onSelected: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }
}
