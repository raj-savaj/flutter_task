import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fresher_task/data.dart';
import 'package:http/http.dart' as htttp;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(3, 1),
  const StaggeredTile.count(1, 1),
  const StaggeredTile.count(4, 1),
];

List<Widget> _tiles = <Widget>[];

List<Color> colors = [
  Colors.green,
  Colors.lightBlue,
  Colors.amber,
  Colors.brown,
  Colors.deepOrange,
  Colors.indigo,
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.blue
];

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String apiUrl =
      "https://0ff15105-f26b-42ee-9264-ed947b4147eb.mock.pstmn.io/flutter_tst";
  Data data;
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    var headers = {
      'x-api-key':
          'PMAK-5ec39ada394b4200422eb173-a201dd13e9b920d18e17647e00c9accde6',
    };
    var response = await htttp.get(apiUrl, headers: headers);

    if (response.statusCode == 200) {
      var body = response.body;
      var decodeJson = jsonDecode(body);
      data = Data.fromJson(decodeJson);
      int i = 0;
      for (String s in data.string) {
        _tiles.add(_Example01Tile(colors[i++], s));
      }
      setState(() {});
    } else {
      throw Exception('Failed to load data!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("My App")),
      ),
      body: new Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: data != null
            ? new StaggeredGridView.count(
                crossAxisCount: 4,
                staggeredTiles: _staggeredTiles,
                children: _tiles,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                padding: const EdgeInsets.all(4.0),
              )
            : LinearProgressIndicator(),
      ),
    );
  }
}

class _Example01Tile extends StatelessWidget {
  const _Example01Tile(this.backgroundColor, this.name);

  final Color backgroundColor;
  final String name;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {},
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Text(name,
                style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
