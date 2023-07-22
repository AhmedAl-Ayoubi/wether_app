import 'package:flutter/material.dart';
import 'package:weather_app/screens/search.dart';

import 'screens/loading_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xff131410),
      ),
      home: LoadingScreen(),
    debugShowCheckedModeBanner: false,
    //  home: ListViewSearchExample(),
      // home: const LocationScreen(),
    );
  }
}
