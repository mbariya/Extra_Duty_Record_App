import 'package:flutter/material.dart';
import 'dart:async';
import 'main.dart';
import 'items.dart';

class AddCoffPage extends StatefulWidget {
  @override
  _AddCoffPageState createState() => _AddCoffPageState();
}

class _AddCoffPageState extends State<AddCoffPage> {
  double appBarHeight = 250.0;
  DateTime _date1 = new DateTime.now();
  String _getCoff = 'A+B Shift';
  String _getNo = '1';
  TextEditingController reasonInput = new TextEditingController();

  
  //Date selection Portion
  Future<Null> _selectDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date1,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2200),
    );
    if(picked != null && picked != _date1){
      setState(() {
        _date1 = picked;
          //2018-07-11 00:00:00.000
      });
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    reasonInput.dispose();
    super.dispose();
  }

  // Application App Bar Body which has 1st Half portion
  Widget _appBar(){
    return new PreferredSize(
        preferredSize: new Size(MediaQuery.of(context).size.width, appBarHeight),
        child: new Container(
            color: Colors.redAccent,
            child: new Container(
                margin:const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      //Close Button
                      new Container(
                        margin:const EdgeInsets.only(top: 10.0),
                        child: new IconButton(
                            tooltip: "Cancel",
                            icon: new Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context, false);
                            }
                        ),
                      ),



                      //Date Picker
                      new Container(
                        //color: Colors.blue,
                        margin:const EdgeInsets.only(top: 10.0, left: 40.0, right: 20.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text("Date", style: TextStyle(color: Colors.yellow, fontSize: 15.0),),
                            new InkWell(
                              onTap: (){_selectDate(context);},
                              child: TextField(
                                enabled: false,
                                decoration: new InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText:  "${dayFormat.format(_date1)}-${monthFormat.format(_date1)}-${yearFormat.format(_date1)}",
                                  hintStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                      //C-off Dropdown
                      new Container(
                        //color: Colors.green,
                        margin:const EdgeInsets.only(top: 20.0, left: 40.0, right: 20.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text("Extra Duty Type", style: TextStyle(color: Colors.yellow, fontSize: 15.0),),
                            new InkWell(
                              onTap: _onTapShiftDialogList,
                              child: new TextField(
                                enabled: false,
                                autofocus: false,
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: Colors.red,
                                        )
                                    ),
                                    hintText: '$_getCoff',
                                    hintStyle: new TextStyle(color: Colors.white, fontSize: 20.0),
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),

                    ]
                )
            )
        )
    );
  }

  // Main Application Body which has 2nd Half portion
  Widget _body(){
    return new Container(
      margin:const EdgeInsets.only(top: 30.0, left: 50.0, right: 30.0),
      child: ListView(
        children: <Widget>[

          // Reason for Coff
          new Text("Reason", style: TextStyle(color: Colors.black, fontSize: 15.0),),
          new TextFormField(
            autofocus: false,
            enabled: true,
            decoration: new InputDecoration(
              border: const UnderlineInputBorder(),
              hintText: 'Reason for Extra Duty Done',
              hintStyle: TextStyle(fontSize: 20.0),
            ),
            validator: (value) {
              if (value.isEmpty) {return 'Please enter Reason';}
            },
            controller: reasonInput,
          ),


          //No of C-off
          new SizedBox(height: 30.0,),
          new Text("No of Extra Duty", style: TextStyle(color: Colors.black, fontSize: 15.0),),
          new InkWell(
            onTap: _onTapNoOfCoffDialogList,
            child: new TextField(
              enabled: false,
              autofocus: false,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: new BorderSide(
                        color: Colors.red,
                      )
                  ),
                  hintText: '$_getNo',
                  hintStyle: new TextStyle(color: Colors.black, fontSize: 20.0)
              ),
            ),
          ),



        ],
      ),
    );

  }

  // Dialog for No of C-off Selection option
  void _onTapNoOfCoffDialogList() {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return Dialog(
          child: Container(
            height: 250.0,
            child: new ListView(
              children: <Widget>[
                new ListTile(
                  title: new Text(
                    "Select No of C-off Created",
                    style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                new Divider(),

                new ListTile(
                  title: new Text("1"),
                  onTap: (){
                    _getNo = '1';
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),

                new ListTile(
                  title: new Text("2"),
                  onTap: (){
                    _getNo = '2';
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),

                new Divider(),

                new FlatButton(
                  child: new Text("Cancel", style: new TextStyle(color: Colors.red),),
                  onPressed: (){
                    setState(() {
                      Navigator.pop(context);
                    });
                  },

                ),

              ],
            ),
          ),

        );
      },
    );
  }

  // Dialog for Shift Selection option
  void _onTapShiftDialogList() {
    showDialog(
      context: context,
      builder: (BuildContext context){
        return Dialog(
          child: Container(
            height: 520.0,
            child: new ListView(
              children: <Widget>[
                new ListTile(
                  title: new Text(
                    "Select Duty from List",
                    style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                new Divider(),

                new ListTile(
                  title: new Text("A+B Shift"),
                  onTap: (){
                    _getCoff = 'A+B Shift';
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),

                new ListTile(
                  title: new Text("B+C Shift"),
                  onTap: (){
                    _getCoff = 'B+C Shift';
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),

                new ListTile(
                  title: new Text("A-Shift"),
                  onTap: (){
                    _getCoff = 'A-Shift';
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),

                new ListTile(
                  title: new Text("B-Shift"),
                  onTap: (){
                    _getCoff = 'B-Shift';
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),

                new ListTile(
                  title: new Text("C-Shift"),
                  onTap: (){
                    _getCoff = 'C-Shift';
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),

                new ListTile(
                  title: new Text("G-Shift"),
                  onTap: (){
                    _getCoff = 'G-Shift';
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),

                new ListTile(
                  title: new Text("W-off"),
                  onTap: (){
                    _getCoff = 'W-off';
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),

                new Divider(),

                new FlatButton(
                  child: new Text("Cancel", style: new TextStyle(color: Colors.red),),
                  onPressed: (){
                    setState(() {
                      Navigator.pop(context);
                    });
                  },

                ),

              ],
            ),
          ),

        );
      },
    );
  }

  // Adding C-off
  void _onFinalAdd() async {
    ExtraDutyItems extraDutyItems = new ExtraDutyItems(_date1.toString(), _getCoff, reasonInput.text, _getNo, "Yes");
    int savedItemId = await db.saveItem(extraDutyItems);
    addedItem = await db.getItem(savedItemId);

    setState(() {
      itemList.insert(0, addedItem);
    });
    reasonInput.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        new Scaffold(
          appBar: _appBar(),
          body: _body(),
        ),
        new Positioned(
          child: new FloatingActionButton(
            tooltip: 'Add',
            child : new Icon(Icons.add, color: Colors.black,),
            onPressed: _onFinalAdd,
            backgroundColor: Colors.yellow,
          ),
          right: 20.0,
          top: appBarHeight -5.0,
        )
      ],
    );
  }


}
