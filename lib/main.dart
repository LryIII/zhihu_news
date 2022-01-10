import 'package:flutter/material.dart';
import 'package:zhihu_news/routes/routes_list.dart';
import 'package:zhihu_news/tabs/home_content.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      home:HomeContent(),
    );
  }
}
