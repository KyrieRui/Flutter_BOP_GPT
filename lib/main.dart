import 'package:bop_gpt_ios/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'BlackOpsOne',
          scaffoldBackgroundColor: Colors.grey.shade900,
          primaryColor: Colors.deepPurple.shade300,
        ));
  }
}
