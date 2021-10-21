// import 'package:flutter/material.dart';
//
// var bikeStations;
//
// class ShowCombos extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(body: MakeList(json: getJsonResponse())),
//     );
//   }
//
//   getJsonResponse() async {
//     //return bikeStations;
//
//     return [
//       {"branch": "B1", "xyz": "0", "ABC": "2", "MN": "2", "XYZ": "2"},
//       {"branch": "B2", "xyz": "0", "ABC": "0", "MN": "0", "another": "sugar"},
//       {"branch": "B3", "xyz": "1", "ABC": "1"},
//       {"branch": "B4", "xyz": "0", "ABC": "5", "MN": "69"},
//     ];
//   }
// }
//
// class MakeList extends StatelessWidget {
//   final List<Map<String, String>> json;
//   MakeList({required this.json});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: json.length,
//       itemBuilder: (BuildContext context, int index) {
//         return MyOwnClass(jsonObject: json[index]);
//       },
//     );
//   }
// }
//
// class MyOwnClass extends StatefulWidget {
//   final Map<String, String> jsonObject;
//
//   MyOwnClass({required this.jsonObject});
//
//   @override
//   _MyOwnClassState createState() => _MyOwnClassState();
// }
//
// class _MyOwnClassState extends State<MyOwnClass> {
//   @override
//   Future<void> initState() async {
//     //bikeStations = await BikeAngelModel().getCombos() as List;
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Container(
//         child: Row(children: makeWidgetChildren(widget.jsonObject)),
//       ),
//     );
//   }
//
//   List<Widget> makeWidgetChildren(jsonObject) {
//     List<Widget> children = [];
//     jsonObject.keys.forEach(
//       (key) => {
//         children.add(
//           Padding(
//               child: Text('${jsonObject[key]}'), padding: EdgeInsets.all(8.0)),
//         )
//       },
//     );
//     return children;
//   }
// }
