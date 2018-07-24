import 'package:flutter/material.dart';
import 'main.dart';
import 'items.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  //Following Variables are for Drawer Building
  AnimationController _controller;
  Animation<double> _drawerContentsOpacity;
  Animation<Offset> _drawerDetailsPosition;
  bool _showDrawerContents = true;


  _onAdd(){
    Navigator.of(context).pushNamed("/SecondPage");
  }

  _readList() async{
    List items = await db.getItems();
    items.forEach((item){
      setState(() {
        itemList.add(ExtraDutyItems.fromMap(item));
      });
    });
  }

  _deleteFromList(int id, int index) async {
    await db.deleteItem(id);
    setState(() {
      itemList.removeAt(index);
      Navigator.pop(context, false);
    });
  }

  _handleSubmittedUpdate (int index, ExtraDutyItems item){
    setState(() {
      itemList.removeWhere((element){
        itemList[index].pending==item.pending;
        itemList[index].reason==item.reason;
        itemList[index].noOfCoffs==item.noOfCoffs;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readList();

    //Following Three Items are for Drawer Building
    _controller = new AnimationController(
      vsync: this,   //Add 'with TickerProviderStateMixin' at class
      duration: const Duration(milliseconds: 200),
    );
    _drawerContentsOpacity = new CurvedAnimation(
      parent: new ReverseAnimation(_controller),
      curve: Curves.fastOutSlowIn,
    );
    _drawerDetailsPosition = new Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ),
    );

  }

  @override
  void dispose() {
    // TODO: implement dispose

    //Controller Disposal for Drawer
    _controller.dispose();

    super.dispose();
  }


  //Drawer Body
  Widget _drawer (){
    return new Drawer(
      child: Column(
        children: <Widget>[

          //User Header Details
          new UserAccountsDrawerHeader(
            margin: EdgeInsets.zero,
            accountName: new Text('Bariya Mohit'),
            accountEmail: new Text("bariya.mohit@gmail.com"),
            currentAccountPicture: new CircleAvatar(
              //backgroundColor: Colors.blue,
              child: new Image.asset('images/appicon.png',),
              //child: new Text("MB"),
              //backgroundImage: ,
            ),

            //Added for Drawer Extra Item Open close
            onDetailsPressed: () {
              _showDrawerContents = !_showDrawerContents;
              if (_showDrawerContents) {
                _controller.reverse();
              }
              else {
                _controller.forward();
              }
            },
          ),


          //Drawer Main List and Add Account Stack View general
          new MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: new Expanded(
              child: new ListView(
                padding: const EdgeInsets.only(top: 8.0),
                children: <Widget>[
                  new Stack(
                    children: <Widget>[

                      // The initial contents of the drawer.
                      new FadeTransition(
                        opacity: _drawerContentsOpacity,
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[


                            // About App Tile
                            new AboutListTile(
                              icon: new Icon(Icons.error_outline),
                              applicationVersion: '1.01',
                              applicationName: "Extra Duty Record",
                              applicationIcon: new Image.asset('images/appicon.png', width: 50.0, height: 50.0,),
                              aboutBoxChildren: <Widget>[
                                new Text("This application is developed By Mr. Mohit Bariya"),
                                new Text(""),
                                new Text("Contact: bariya.mohit@gmail.com"),
                                new Text(""),
                                new Text("Application is not for retail use, it is created for personal use only"),
                              ],
                            ),

                            //With list or TO DO list Tile
                            new ListTile(
                              title: new Text("Wish List"),
                              leading: new Icon(Icons.format_list_bulleted),
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return Dialog(
                                      child: Container(
                                        height: 350.0,
                                        child: new ListView(
                                          children: <Widget>[
                                            new ListTile(
                                              title: new Text(
                                                "Things TODO",
                                                style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            new Divider(),
                                            new ListTile(
                                              leading: Icon(Icons.arrow_drop_down),
                                              title: new Text("Adding Option for Note in Edit C-off Page"),
                                            ),
                                            new ListTile(
                                              leading: Icon(Icons.arrow_drop_down),
                                              title: new Text("Date and Extra Duty Type make editable in Edit C-off page"),
                                            ),
                                            new ListTile(
                                              leading: Icon(Icons.arrow_drop_down),
                                              title: new Text("Total Pending C-off To be show on Main Page"),
                                            ),

                                            new ListTile(
                                              leading: Icon(Icons.arrow_drop_down),
                                              title: new Text("Filter for Pending and Consumed C-off on Main Page"),
                                            ),

                                            new Divider(),
                                            new FlatButton(
                                              child: new Text("OK", style: new TextStyle(color: Colors.blue, fontSize: 20.0),),
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
                              },
                            ),

                            //Close Drawer Tile
                            new ListTile(
                              title: new Text("Close"),
                              leading: new Icon(Icons.close),
                              onTap: ()=>Navigator.of(context).pop(),
                            ),

                          ],
                        ),
                      ),


                      // The drawer's "details" view. Add Account Details
                      new SlideTransition(
                        position: _drawerDetailsPosition,
                        child: new FadeTransition(
                          opacity: new ReverseAnimation(_drawerContentsOpacity),
                          child: new Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              new ListTile(
                                leading: const Icon(Icons.add),
                                title: const Text('Add account'),
                                onTap: (){},
                              ),
                              new ListTile(
                                leading: const Icon(Icons.settings),
                                title: const Text('Manage accounts'),
                                onTap: (){},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  //Main Page Builder
  Widget _body(){
    return new SafeArea(
        top: false,
        bottom: false,
        child: new Container(
          padding: new EdgeInsets.all(5.0),
          child: new ListView.builder(
            reverse: false,
            itemCount: itemList.length,
            itemBuilder: (_, int index){
              return new InkWell(
                  child: itemList[index],
                  onTap: (){
                    Navigator.push(context, new MaterialPageRoute(
                      builder: (BuildContext context) => _alert(itemList[index], index),
                      fullscreenDialog: true,
                    ));
                  },
              );
            },
          ),
        ),
    );
  }


  //Edit Body Builder
  Widget _alert(ExtraDutyItems item, int index) {
    TextEditingController pendingInput = new TextEditingController(text: item.pending);
    TextEditingController reasonInput = new TextEditingController(text: item.reason);
    TextEditingController noInput = new TextEditingController(text: item.noOfCoffs);

    return Scaffold(
      body: Stack(
        children: <Widget>[

          //Top Body
          new Container(
              color: item.pending== "Yes"? Colors.redAccent: Colors.indigoAccent,
              height: 300.0,
              //margin: const EdgeInsets.only(top: 60.0, right: 10.0),
              child: new ListView(
                  children: <Widget>[

                    //Date Picker
                    new Container(
                      margin:const EdgeInsets.only(top: 60.0, left: 40.0, right: 20.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text("Date", style: TextStyle(color: Colors.yellow, fontSize: 15.0),),
                          new TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              hintText: '${dayFormat.format(DateTime.parse(item.date))}-${monthFormat.format(DateTime.parse(item.date))}-${yearFormat.format(DateTime.parse(item.date))}',
                              hintStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                          new Padding(padding: EdgeInsets.only(top: 15.0)),

                        ],
                      ),
                    ),

                    //C-off Dropdown
                    new Container(
                      margin:const EdgeInsets.only(top: 20.0, left: 40.0, right: 20.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text("Extra Duty Type", style: TextStyle(color: Colors.yellow, fontSize: 15.0),),
                          //new Padding(padding: EdgeInsets.only(top: 15.0)),
                          new TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              hintText: item.coff,
                              hintStyle: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                          ),

                        ],
                      ),
                    ),

                  ]
              )
          ),


          //Bottom Half
          new Container(
            margin: const EdgeInsets.only(top: 300.0),
            child: ListView(
              children: <Widget>[
                //Reason Block
                new Container(
                  //color: Colors.green,
                  margin:const EdgeInsets.only(top: 20.0, left: 40.0, right: 20.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text("Reason of Extra Duty", style: TextStyle(color: Colors.black, fontSize: 15.0),),
                      new TextFormField(
                        enabled: true,
                        controller: reasonInput,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                        ),
                      ),

                    ],
                  ),
                ),

                //No of C-off
                new Container(
                  margin:const EdgeInsets.only(top: 20.0, left: 40.0, right: 20.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text("No of Coff", style: TextStyle(color: Colors.black, fontSize: 15.0),),
                      /*new TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          hintText: item.noOfCoffs,
                          hintStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                      ), */
                      new InkWell(
                        onTap: (){
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
                                          noInput = TextEditingController(text: "1");
                                          setState(() {
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                      new ListTile(
                                        title: new Text("2"),
                                        onTap: (){
                                          noInput = TextEditingController(text: "2");
                                          setState((){
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
                        },
                        child: new TextField(
                          enabled: false,
                          autofocus: false,
                          controller: noInput,
                          style: new TextStyle(color: Colors.black, fontSize: 20.0),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                //Pending Status
                new Container(
                  margin:const EdgeInsets.only(top: 20.0, left: 40.0, right: 20.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text("C-off Pending", style: TextStyle(color: Colors.black, fontSize: 15.0),),
                      new TextFormField(
                        enabled: true,
                        controller: pendingInput,
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),


          //Close Button
          new Positioned(
            left: 10.0,
            top: 25.0,
            child: new IconButton(
                splashColor: Colors.white,
                tooltip: 'Cancel',
                icon: new Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed:(){
                  Navigator.pop(context);
                }
            ),
          ),


          //Delete Button
          new Positioned(
            right: 20.0,
            top: 25.0,
            child: new IconButton(
                splashColor: Colors.white,
                tooltip: 'Delete',
                icon: new Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed:(){
                  _deleteFromList(itemList[index].id, index);
                }
            ),
          ),


          //Floating Action Button
          new Positioned(
            right: 20.0,
            top: 265.0,
            child: new FloatingActionButton(
              tooltip: 'Update',
              child: new Icon(Icons.done, color: Colors.black,),
              backgroundColor: Colors.yellow,
              onPressed: () async{
                ExtraDutyItems newItemUpdate = ExtraDutyItems.fromMap(
                  { "reason": reasonInput.text,
                    "date": item.date,
                    "coff": item.coff,
                    "noOfCoff": noInput.text,
                    "pending": pendingInput.text,
                    "id": item.id,
                  });
                _handleSubmittedUpdate(index, item);
                await db.updateItem(newItemUpdate);
                setState(() {
                  _readList();
                });
                pendingInput.clear();
                reasonInput.clear();
                noInput.clear();
                Navigator.pop(context);
              },
            ),
          )

        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Extra Duty Record"),
      ),
      drawer: _drawer(),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add New C-off",
        child: Icon(Icons.add),
        onPressed: _onAdd,
      ),
    );
  }
}
