import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hello_flutter/widgets/drink_info_widget.dart';
import 'package:provider/provider.dart';
import 'widgets/home_page_widget.dart';
import 'widgets/list_widget.dart';
import 'widgets/drink_list_widget.dart';
import 'widgets/ingredient_widget.dart';

void main() {
  runApp(MyApp());
}

class MyAppState extends ChangeNotifier {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Cocktail DB',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/L': (context) => ListPage(),
          '/D': (context) => DrinkListPage(),
          '/DI': (context) => DrinkInfoPage(),
          '/I': (context) => IngredientPage(),
        },
        scrollBehavior: MyCustomScrollBehavior(),
      ),
    );
  }
}

// macOS scrolling issues
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
