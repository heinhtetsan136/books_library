import 'package:book_library/const/my_theme.dart';
import 'package:book_library/data/library_db.dart';
import 'package:book_library/provider/author_provider.dart';
import 'package:book_library/view/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LibraryDbService().createDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthorProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: MyTheme.lightTheme(),
        darkTheme: MyTheme.darkTheme(),
        home: Home(),
      ),
    );
  }
}
