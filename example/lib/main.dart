import 'dart:developer';

import 'package:data_picker/data_picker.dart';
import 'package:example/data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Picker Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Data Picker Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Sortable extends Comparable {
  String name, abbreviation;

  Sortable({
    required this.name,
    required this.abbreviation,
  });

  factory Sortable.fromMap(Map<String, dynamic> map) => Sortable(
        name: map['name'],
        abbreviation: map['abbreviation'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'abbreviation': abbreviation,
      };

  @override
  int compareTo(other) => this.name.compareTo(other.name);
}

class _MyHomePageState extends State<MyHomePage> {
  DataPicker picker = DataPicker(
    data: data.map((e) => Sortable.fromMap(e)).toList(),
    config: Config(
      label: "name",
      leading: "abbreviation",
    ),
    callback: PickerCallback(
      onSelect: (dynamic item) {
        log(item.toString(), name: 'Selected Item');
      },
    ),
    sort: true,
    theme: PickerTheme(
      showLeading: false,
      labelStyle: TextStyle(
        fontSize: 24,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => picker.showPicker(context),
          child: Text('Show Picker'),
        ),
      ),
    );
  }
}
