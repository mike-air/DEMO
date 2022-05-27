import 'package:demo/HomePage.dart';
import 'package:demo/VideoDetailsPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red)),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        appBarTheme: const AppBarTheme(color: Colors.white),
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
