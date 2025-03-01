import 'package:codeconverter/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

const apiKey = 'API KEY';
void main() {
  Gemini.init(apiKey: apiKey, enableDebugging: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String result = "";

  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Code Converter',
      theme: ThemeData.dark(),
      home: const Homepage(),
    );
  }
}
