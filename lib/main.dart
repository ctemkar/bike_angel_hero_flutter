import 'package:flutter/material.dart';

import 'model/combos.dart';

void main() => runApp(const MyApp());
/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bike Angel Combos',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bike Angel Combos'),
        ),
        body: Center(child: CombosListView()),
      ),
    );
  }
}

 */

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const CombosListView(),
      debugShowCheckedModeBanner: false,
      // LoadingScreen(),
    );
  }
}
