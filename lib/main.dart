import 'package:flutter/material.dart';
import 'package:zoalna/screens/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      debugShowCheckedModeBanner: false,
      title: 'Zoalna',
      theme: ThemeData(
        fontFamily: 'din',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
