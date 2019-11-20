import 'package:flutter/material.dart';
import 'package:my_diary/data/task.dart';
import 'package:my_diary/view/add.dart';
import 'package:my_diary/view/detail.dart';
import 'package:provider/provider.dart';
import 'view/homepage.dart';
import 'package:my_diary/routes/route.dart';

void main() async {
  Routes.generateRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (_) => TasksDatabase().taskDao,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            brightness: Brightness.dark,
            fontFamily: "Sans",
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.teal,
            )),
        navigatorKey: Routes.sailor.navigatorKey, // important
        onGenerateRoute: Routes.sailor.generator(),
        home: MyHomePage(),
      ),
    );
  }
}
