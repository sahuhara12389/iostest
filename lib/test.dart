


// @dart=2.9
//import 'package:flutter/material.dart';
//import 'package:multi_select_flutter/multi_select_flutter.dart';
//import 'dart:async';
//import 'package:http/http.dart' as http;
//import 'dart:convert';
//
//
//
//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//
//
//
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Multi Select',
//      theme: ThemeData(
//        primarySwatch: Colors.purple,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: MyHomePage(title: 'Flutter Multi Select'),
//    );
//  }
//}
//class Animal {
//  final int category_id;
//  final String category_type;
//
//  Animal({
//    this.category_id,
//    this.category_type,
//  });
//}
//
//
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//  final String title;
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//
//
//  Future<List<Album>> futureBal;
//  static List<Album> _animals
//
//
//
//  =
//  [
//    Album(category_id: "1", category_type: "Lion"),
//    Album(category_id: "2", category_type: "Flamingo"),
//    Album(category_id: "3", category_type: "Hippo"),
//    Album(category_id: "4", category_type: "Horse"),
//    Album(category_id: "5", category_type: "Tiger"),
//    Album(category_id: "6", category_type: "Penguin"),
//
//  ];
//
//
//
//  Future <List<Album>> fetchData() async {
//
//    print(
//        'xxx');
//
//        var url = 'https://itpcchennai.com/web_api/public/common_service';
//    print(
//        '2222');
//
//       final response  =await http.get(Uri.parse(url));
//
//
//    print(
//        '3333');
//
//
//    print(response.statusCode);
//    if (response.statusCode == 200) {
//      print(
//          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
//      String  data = response.body;
//
//
//      var parsed =json.decode(response.body);
//
//      List jsonResponse=parsed["Category"] as List;
//
//      String Json=jsonResponse.toString();
//       Json=Json.replaceAll("{", "(").replaceAll("}", ")") ;
//
//      _animals
//
//
//
//      =
//      [
//        Album(category_id: "7", category_type: "xx"),
//        Album(category_id: "8", category_type: "ee"),
//        Album(category_id: "9", category_type: "lll"),
//        Album(category_id: "10", category_type: "vvvv"),
//
//
//      ];
//
//
//      print(Json);
//      //_animals=jsonResponse.toList();
//      print('ssss');
//      return jsonResponse.map((data) => new Album.fromJson(data)).toList();
//
//    } else {
//      throw Exception('error while fetching record');
//    }
//  }
//
//
//
//
////    Future<List<Album>> fetchData2() async {
////
////    print('x1');
////    var url = 'https://itpcchennai.com/web_api/public/common_service';
////    print('x11');
////    final response  =await http.get(Uri.parse(url));
////    print('x2');
//////here you turn the json to a <String, dynamic> map
////    var data = jsonDecode(response.body);
////
////
////
////    print(response.body);
////
////      var parsed1 =json.decode(response.body);
////
////
////
////      List jsonResponse3=parsed1["Category"] as List;
////
////
////
////
////
////    List<Album> result = [];
////
//////that should be your disered list
////    return result;
////  }
//
//
//  final _items = _animals
//      .map((animal) => MultiSelectItem<Album>(animal, animal.category_type))
//      .toList();
//
//
//
//
//
//  @override
//  void initState() {
//   // fetchData2();
//    futureBal = fetchData();
//    print('XXXXXXXX');
//   // _selectedAnimals5 = _animals;
//
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: SingleChildScrollView(
//        child: Container(
//          alignment: Alignment.center,
//          padding: EdgeInsets.all(5),
//          child: Column(
//            children: <Widget>[
//
//
////    FutureBuilder<List<GetUsers>>(
////    future: fetchJSONData(),
////    builder: (context, snapshot) {
////      if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
////
////      return ListView(
////        children: snapshot.data
////            .map((user) =>
////            ListTile(
////              title: Text(user.category_type),
////              onTap: () {
////                //print(user.name);
////              },
////
////            ),
////        )
////            .toList(),
////      );
////
////    }
////    )
//
//      MultiSelectDialogField(
//        items: _items,
//        searchable: true,
//        title: Text("Animals"),
//        selectedColor: Colors.blue,
//        decoration: BoxDecoration(
//          color: Colors.blue.withOpacity(0.1),
//          borderRadius: BorderRadius.all(Radius.circular(40)),
//          border: Border.all(
//            color: Colors.blue,
//            width: 2,
//          ),
//        ),
////
//        buttonText: Text(
//          "Select Category",
//          style: TextStyle(
//            color: Colors.blue[800],
//            fontSize: 16,
//          ),
//        ),
//        onConfirm: (results) {
//          //_selectedAnimals = results;
//        },
//      )
//
//
//
//
//
//
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}












































//import 'package:multi_select_flutter/multi_select_flutter.dart';
//import 'package:http/http.dart' as http;
//
//
//
//class Item {
//  final int category_id;
//  final String category_type;
//
//  Item({
//    this.category_id,
//    this.category_type,
//  });
//}
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: MyHomePage(),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  List _myActivities;
//  String _myActivitiesResult;
//  final formKey = new GlobalKey<FormState>();
//
//  @override
//  void initState() {
//    super.initState();
//    this.fetchData();
//    _myActivities = [];
//
//
//
//  }
//
////  final _items = _animals
////      .map((animal) => MultiSelectItem<Animal>(animal, animal.category_type))
////      .toList();
//
//
//  _saveForm() {
//    var form = formKey.currentState;
//    if (form.validate()) {
//      form.save();
//      setState(() {
//        _myActivitiesResult = _myActivities.toString();
//      });
//    }
//  }
//
//  Map<List, dynamic> userdata;
//
//
//  Future<List<Item>> fetchData() async {
//    var url = 'https://itpcchennai.com/web_api/public/common_service';
//
//    final response  =await http.get(Uri.parse(url));
////here you turn the json to a <String, dynamic> map
//    var data = jsonDecode(response.body);
//
//
//
//    print(response.body);
//
//      final _items =  MultiSelectItem<Animal>(animal, animal.category_type).t
//    userdata = new Map<List, dynamic>.from(json.decode(response.body));
//    print(userdata);
//
//    List<Item> result = [];
//    for (var item in data) {
//      //use your factory if you wanna to parse the data the way you want it
//    // result.add(Item.fromJson(item));
//      print('v');
//     // _myActivities = item;
//     // return jsonResponse3.map((data) => new Album.fromJson(data)).toList();
//    }
////that should be your disered list
//    return result;
//  }
//
////  fetchData() async{
////    var url = 'https://itpcchennai.com/web_api/public/common_service';
////
////    final response  =await http.post(Uri.parse(url));
////   // var response = await http.get(url);
////    if(response.statusCode == 200){
////      var items = json.decode(response.body);
////      print(items);
////      setState(() {
////        _myActivities = items;
////      });
////    } else {
////      setState(() {
////        _myActivities = [];
////      });
////    }
////  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    final double maxWidth = MediaQuery.of(context).size.width;
//    final double maxHeight = MediaQuery.of(context).size.height;
//
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('MultiSelect Formfield Example'),
//      ),
//      body: Center(
//        child: Form(
//          key: formKey,
//          child:
//
//          Column(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//
//
//
//
//              MultiSelectDialogField(
//        items: _myActivities,
//        searchable: true,
//        title: Text("Animals"),
//        selectedColor: Colors.blue,
//        decoration: BoxDecoration(
//          color: Colors.blue.withOpacity(0.1),
//          borderRadius: BorderRadius.all(Radius.circular(40)),
//          border: Border.all(
//            color: Colors.blue,
//            width: 2,
//          ),
//        ),
////
//        buttonText: Text(
//          "Select Category",
//          style: TextStyle(
//            color: Colors.blue[800],
//            fontSize: 16,
//          ),
//        ),
//        onConfirm: (results) {
//          //_selectedAnimals = results;
//        },
//      )
//
//
//
////              Container(
////                height: maxHeight/2,
////                width: maxWidth,
////                padding: EdgeInsets.all(16),
////                child: getListView(),
////              ),
////              Container(
////                padding: EdgeInsets.all(8),
////                child: RaisedButton(
////                  child: Text('Save'),
////                  onPressed: _saveForm,
////                ),
////              ),
////              Container(
////                padding: EdgeInsets.all(16),
////                child: Text(_myActivitiesResult),
////              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
////  Widget getListView() {
////    return ListView.builder(
////      itemCount: _myActivities.length,
////      itemBuilder: (context, index){
////        return cardView(_myActivities[index]);
////      },
////    );
////  }
////
////  Widget cardView(item) {
////
////    var fullName = item;
////
////    return MultiSelectDialogField(
////      items: _myActivities,
////      title: Text("Animals"),
////      selectedColor: Colors.blue,
////      decoration: BoxDecoration(
////        color: Colors.blue.withOpacity(0.1),
////        borderRadius: BorderRadius.all(Radius.circular(40)),
////        border: Border.all(
////          color: Colors.blue,
////          width: 2,
////        ),
////      ),
////      buttonIcon: Icon(
////        Icons.pets,
////        color: Colors.blue,
////      ),
////      buttonText: Text(
////        "Favorite Animals",
////        style: TextStyle(
////          color: Colors.blue[800],
////          fontSize: 16,
////        ),
////      ),
////      onConfirm: (results) {
////        _myActivities = results;
////      },
////    );
////  }
//}
//
//

//
//import 'package:flutter/material.dart';
//import 'dart:convert';
//import 'package:http/http.dart' as http;
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//        home: Scaffold(
//          body: Center(
//              child: JSONListView()
//          ),
//        ));
//  }
//}
//
//class GetUsers {
//  int id;
//  String name;
//
//
//  GetUsers({
//    this.id,
//    this.name
//
//  });
//
//  factory GetUsers.fromJson(Map<String, dynamic> json) {
//    return GetUsers(
//        id: json['category_id'],
//        name: json['category_type']
//
//    );
//  }
//}
//
//class JSONListView extends StatefulWidget {
//  CustomJSONListView createState() => CustomJSONListView();
//}
//
//class CustomJSONListView extends State {
//
//  final String apiURL = 'https://itpcchennai.com/web_api/public/common_service';
//
//
//
//  Future <List<Album>> fetchDatabalance() async {
//
//
//        final response  =await http.get(Uri.parse(apiURL));
//        print('x2');
//    //here you turn the json to a <String, dynamic> map
//    var data = jsonDecode(response.body);
//
//
//
//    print(response.body);
//
//
//      if (response.statusCode == 200) {
//
//
//        var parsed1 =json.decode(response.body);
//
//
//
//        List jsonResponse3=parsed1["Category"] as List;
//
//      print('ssss');
//      return jsonResponse3.map((data) => new Album.fromJson(data)).toList();
//    } else {
//      throw Exception('error while fetching record');
//    }
//  }
//
//  ////    var url = 'https://itpcchennai.com/web_api/public/common_service';
//////
//////    final response  =await http.post(Uri.parse(url));
////  Future<List<GetUsers>> fetchJSONData() async {
////
////    var jsonResponse = await http.get(Uri.parse(apiURL));
////
////    if (jsonResponse.statusCode == 200) {
////
////
////
////      final jsonItems = json.decode(jsonResponse.body).cast<Map<String, dynamic>>();
////
////      var parsed =(jsonItems);
////      List jsonRespon=parsed["Category"] as List;
////
////      List<GetUsers> usersList = jsonRespon.map<GetUsers>((json) {
////        return GetUsers.fromJson(json);
////      }).toList();
////
////      return usersList;
////
////    } else {
////      throw Exception('Failed to load data from internet');
////    }
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('JSON ListView in Flutter'),
//      ),
//      body: FutureBuilder<List<Album>>(
//        future: fetchDatabalance(),
//        builder: (context, snapshot) {
//
//          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
//
//          return ListView(
//            children: snapshot.data
//                .map((user) => ListTile(
//              title: Text(user.category_type),
//              onTap: (){ print(user.category_type); },
//
//              leading: CircleAvatar(
//                backgroundColor: Colors.green,
//                child: Text(user.category_type[0],
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 20.0,
//                    )),
//              ),
//            ),
//            )
//                .toList(),
//          );
//        },
//      ),
//    );
//  }
//}
//class Album {
//  final String category_id;
//  final String category_type;
//
//
//  Album({
//
//    this.category_id,
//    this.category_type,
//
//
//
//
//
//  });
//
//  factory Album.fromJson(Map<String, dynamic> json) {
//    return Album(
//
//
//      category_id: json['category_id'],
//      category_type: json['category_type'],
//
//
//
//    );
//  }
//}




import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
  home: new MyApp(),
  debugShowCheckedModeBanner: false,
));

class MyApp extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<MyApp> {
  TextEditingController controller = new TextEditingController();


  List _selecteCategorys = List();

  String category;


  void _onCategorySelected(bool selected, category_id) {

    print(category_id);

    if (selected == true) {
      print('xxxx');
      print(category_id);
      setState(() {
        _selecteCategorys.add(category_id);

        category=category+',';


      });
    } else {
      setState(() {
        _selecteCategorys.remove(category_id);

      });
    }

  }

  // Get json result and convert it to model. Then add
  Future<Null> getUserDetails() async {
    final response =  await http.get(Uri.parse(url));
    final responseJson = json.decode(response.body);


    var parsed =json.decode(response.body);
    List jsonResponse=parsed["Category"] as List;


    setState(() {
      for (Map user in jsonResponse) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Home'),
        elevation: 0.0,
      ),
      body: new

      Column(
        children: <Widget>[
          new

          Container(
            color: Theme.of(context).primaryColor,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                    controller.clear();
                    onSearchTextChanged('');
                  },),
                ),
              ),
            ),
          ),
          new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? new ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, i) {
                return new Card(
                  child: new ListTile(
                    leading: new
                    Text('xx'),

                    title: new Text(_searchResult[i].firstName ),
                  ),
                  margin: const EdgeInsets.all(0.0),
                );
              },
            )
                : new ListView.builder(
              itemCount: _userDetails.length,
              itemBuilder: (context, index) {
                return



                  CheckboxListTile(

                      value: _userDetails[index].selected,
                      onChanged: (bool value) {
                        setState(() {
                          _onCategorySelected(_userDetails[index].selected,_userDetails[index].firstName);

                          _userDetails[index].selected = value;
                        });
                      },

                      title: Text(_userDetails[index].firstName),
                      );





//                  CheckboxListTile(
//                    value: _selecteCategorys.contains(_userDetails[index].id),
//                    onChanged: (bool selected) {
//                      _onCategorySelected(selected,
//                          _userDetails[index].firstName);
//                    },
//                    title: Text(_userDetails[index].firstName),
//                  );


//                Card(
//                  child: new ListTile(
//                    leading:
//                    new
//
//                   Text('x'),
//
//                    title: new Text(_userDetails[index].firstName),
//                  ),
//                  margin: const EdgeInsets.all(0.0),
//                );
             },
            ),
          ),



        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.firstName.contains(text) )
        _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List<UserDetails> _searchResult = [];

List<UserDetails> _userDetails = [];

final String url = 'https://itpcchennai.com/web_api/public/common_service';
class UserDetails {
  final String id;
  final String firstName;
  bool selected = false;

  UserDetails({this.id, this.firstName });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return new UserDetails(
      id: json['category_id'],
      firstName: json['category_type'],

    );
  }
}
