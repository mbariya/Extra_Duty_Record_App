import 'package:flutter/material.dart';
import 'main.dart';

class ExtraDutyItems extends StatelessWidget {

  String _date;
  String _coff;
  String _reason;
  String _noOfCoffs;
  int _id;
  String _pending;

  ExtraDutyItems(this._date, this._coff, this._reason, this._noOfCoffs, this._pending);

  ExtraDutyItems.map(dynamic obj){
    this._date = obj ["date"];
    this._coff = obj ["coff"];
    this._reason = obj ["reason"];
    this._noOfCoffs= obj ["noOfCoff"];
    this._id = obj ["id"];
    this._pending = obj ["pending"];
  }

  String get date => _date;
  String get coff => _coff;
  String get reason => _reason;
  String get noOfCoffs => _noOfCoffs;
  int get id => _id;
  String get pending => _pending;


  Map<String, dynamic> toMap(){

    var map = new Map<String, dynamic>();
    map["date"] = _date;
    map["coff"] = _coff;
    map["reason"] = _reason;
    map["noOfCoff"] = _noOfCoffs;
    map ["pending"] = _pending;
    if(_id!= null) {
      map["id"] = _id;
    }
    return map;
  }


  ExtraDutyItems.fromMap(Map<String, dynamic> map){
    this._date = map["date"];
    this._coff = map ["coff"];
    this._reason = map ["reason"];
    this._noOfCoffs = map ["noOfCoff"];
    this._id =  map ["id"];
    this._pending = map ["pending"];
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      child: new Row(
        children: <Widget>[

          //Date Entry
            new SizedBox(
                  height: 80.0,
                  width: 50.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text("${dayFormat.format(DateTime.parse(_date))}", style: new TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold),),  //14-02-2018
                      new Text("${monthFormat.format(DateTime.parse(_date))}", style: new TextStyle(fontSize: 15.0, color: Colors.red, fontWeight: FontWeight.bold),),
                      new Text("${yearFormat.format(DateTime.parse(_date))}", style: new TextStyle(fontSize: 15.0, color: Colors.green, fontWeight: FontWeight.bold),),
                    ],
                  ),
            ),


          //Main Body
          new Expanded(
            child: new SizedBox(
              height: 90.0,
              child: Card(
                elevation: 5.0,
                color: _pending== "Yes"? Colors.red: Colors.indigo,
                child: Column(
                  children:  <Widget>[
                    
                    //Top Part
                    Container(
                      color: _pending== "Yes"? Colors.redAccent: Colors.indigoAccent,
                      child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.only(top: 10.0, left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text(_coff, style: new TextStyle(fontSize: 20.0, color: Colors.white),),
                                  new Padding(padding: EdgeInsets.only(bottom: 15.0)),
                                ],
                              )
                          ),
                        ),

                        Container(
                            padding: EdgeInsets.only(top: 10.0, right: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                new Text("# $_noOfCoffs", style: new TextStyle(fontSize: 20.0, color: Colors.white),),
                                new Padding(padding: EdgeInsets.only(bottom: 15.0)),
                              ],
                            )
                        ),

                      ],
                  ),
                    ),

                    
                    //Bottom Part UI
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.only(top: 10.0, left: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Text("Reason: $_reason", style: new TextStyle(fontSize: 12.0, color: Colors.white70, fontStyle: FontStyle.italic),),

                                  ],
                                )
                            ),
                          ),

                          Container(
                              padding: EdgeInsets.only(top: 10.0, right: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  new Text("Pending: $_pending", style: new TextStyle(fontSize: 12.0, color: Colors.white70, fontStyle: FontStyle.italic),),

                                ],
                              )
                          ),

                        ],
                      ),
                    ),


                 ],

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
