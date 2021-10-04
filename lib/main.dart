import 'package:flutter/material.dart';
import 'screens/large_file_main.dart';
import 'widgets/bot_nav.dart';

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
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App2'),
        ),
        body: LargeFileMain(),
        // bottomNavigationBar: BotNav(),
      )
    );
  }
}
