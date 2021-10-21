import 'package:flutter/material.dart';

import 'model/combos.dart';

void main() => runApp(MyApp());

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
/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: CombosListView(),
      debugShowCheckedModeBanner: false,
      // LoadingScreen(),
    );
  }
}

 */
