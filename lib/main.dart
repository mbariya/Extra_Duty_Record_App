import 'database_client.dart';
import 'package:flutter/material.dart';
import 'homePageUI.dart';
import 'addCoffUI.dart';
import 'items.dart';
import 'package:intl/intl.dart';

List<ExtraDutyItems> itemList = <ExtraDutyItems>[];
ExtraDutyItems addedItem;
var db = new DatabaseHelper();

DateFormat dayFormat = DateFormat.d();
DateFormat monthFormat = DateFormat.MMM();
DateFormat yearFormat = DateFormat.y();


void main() => runApp(
    new MyApp()
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
        routes: <String, WidgetBuilder>{
          "/SecondPage":(BuildContext context) => new AddCoffPage(),
          //"/ThirdPage":(BuildContext context) => new EditCoffPage(),
        }
    );
  }
}
