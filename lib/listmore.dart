// @dart=2.9



import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';


void main() => runApp(MyApplist());




class MyApplist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('JSON ListView with Multiple Text Items')
        ),
        body:


        JsonListView(),
      ),
    );
  }
}



class Studentdata {
  String property_id;
  String property_category;
  String property_email;
  String property_title;

  String property_description;
  String property_company;
  String signup_mobile;
  String image_prop;

  Studentdata({
    this.property_id,
    this.property_category,
    this.property_email,
    this.property_title,

    this.property_description,
    this.property_company,
    this.signup_mobile,
    this.image_prop,
  });

  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(
        property_id: json['property_id'],
        property_category: json['property_category'],
        property_email: json['property_email'],
        property_title: json['property_title'],

        property_description: json['property_description'],
        property_company: json['property_company'],
        signup_mobile: json['signup_mobile'],
        image_prop: json['image_prop']


    );
  }
}
//class Studentdata {
//  int studentID;
//  String studentName;
//  int studentPhoneNumber;
//  String studentSubject;
//
//  Studentdata({
//    this.studentID,
//    this.studentName,
//    this.studentPhoneNumber,
//    this.studentSubject
//  });
//
//  factory Studentdata.fromJson(Map<String, dynamic> json) {
//    return Studentdata(
//        studentID: json['property_id'],
//        studentName: json['property_category'],
//        studentPhoneNumber: json['property_email'],
//        studentSubject: json['property_title']
//
//    );
//  }
//}

class JsonListView extends StatefulWidget {

  JsonListViewWidget createState() => JsonListViewWidget();

}

class JsonListViewWidget extends State {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final TextEditingController _controller = TextEditingController();
  String selectedSpinnerItem = 'Banana';
  List data = List();
  Future myFuture;

  bool _isLoading = false;
  bool isEnabled = true;

  int _searchtype = 0;












  @override
  void initState() {
    super.initState();
    myFuture = fetchData();

  }


  @override
  void dispose() {
    _controller.dispose();
    EasyLoading.dismiss();
    super.dispose();
  }




  final String uri = 'https://itpcchennai.com/web_api/public/common_service';

  Future<String> fetchData() async {
    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      print('Loaded');
      var res = await http.get(Uri.parse(uri), headers: {"Accept": "application/json"});
      print(response.body);
      var resBody = json.decode(res.body);
      List jsonResponse=resBody["Category"] as List;

      setState(() {
        data = jsonResponse;
      });

      print('Loaded Successfully');

      return "Loaded Successfully";
    } else {
      throw Exception('Failed to load data.');
    }
  }

  Future<List<Studentdata>> fetchStudents() async {


    String searchfiled;

    if(_searchtype==0) {
      searchfiled='';
    }
    else if(_searchtype==1) {
      searchfiled=_controller.text;
    }
    else
      {
        searchfiled=selectedSpinnerItem.toString();
      }
    print('SEARCH');
print(_searchtype);
    print(searchfiled);
    print('SEARCH');
    var request = http.MultipartRequest('POST', Uri.parse('https://itpcchennai.com/web_api/public/getProduct'));
    request.fields.addAll({

      'Start': '0',
      'limit': '200',
      'Category': searchfiled.toString()
    });
    print('3333');

    http.StreamedResponse response = await request.send();
    var decoded = await response.stream.bytesToString().then(json.decode);

    var usersData = decoded['data'];


      print(decoded['data'].toString());
 //   var response = await http.post(Uri.parse(apiURL));

    if (response.statusCode == 200) {
      print('000');
      final items = decoded['data'].cast<Map<String, dynamic>>();
      print('111');

      List<Studentdata> studentList = items.map<Studentdata>((json) {
        return Studentdata.fromJson(json);
      }).toList();

      return studentList;
    }
    else {
      throw Exception('Failed to load data from Server.');
    }
  }

  selectedItem(BuildContext context, String dataHolder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(dataHolder),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Future<void> buttonclick(BuildContext context) async {
    try {
      _searchtype=1;
      EasyLoading.show();
      //Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      fetchStudents();

      EasyLoading.dismiss();
    } catch (error) {
      print(error);
    }
  }


//  void buttonclick() {
//    _searchtype=1;
//    Dialogs.showLoadingDialog(context, _keyLoader);
//
//
//
//  }
  Future<void> dropclick(BuildContext context) async {
    try {
      _searchtype=2;
      EasyLoading.show();
      //Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      fetchStudents();

      EasyLoading.dismiss();

    } catch (error) {
      print(error);
    }
  }
//  void dropclick() {
//    _searchtype=2;
//    Dialogs.showLoadingDialog(context, _keyLoader);
//    fetchStudents();
//
//  }

//  void clearclick() {
//    _searchtype=0;
//    Dialogs.showLoadingDialog(context, _keyLoader);
//    fetchStudents();
//
//  }

  Future<void> clearclick(BuildContext context) async {
    try {
      _searchtype=0;
      EasyLoading.show();
      //Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      fetchStudents();

      EasyLoading.dismiss();
    } catch (error) {
      print(error);
    }
  }


  @override
  Widget build(BuildContext context) {
    return




      Container(

        child:
        Stack(
            children: <Widget>[



        Column(
        mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [




            Container(
              color:Colors.orange,
              height: 80,
              child:
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child:
                    Padding(
                      padding: const EdgeInsets.only(
                          left:15.0, right: 0.0, top: 0, bottom: 0),
                      child:
                      Container(
                        height: 40,
                        child:TextField(
                          controller: _controller,

                          onChanged: (value) {
                            // Call setState to update the UI
                            setState(() {});
                          },
                          decoration: InputDecoration(

                            hintText: 'Search here' ,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey
                                )
                            ),
                            border:  OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.grey)
                            ),


                            prefixIcon: const Icon(Icons.search,color: Colors.grey,  ),



                          ),
                        ),



                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Container(

                      child:
                      Padding(
                        padding: const EdgeInsets.only(
                            left:5.0, right: 5.0, top: 0, bottom: 0),
                        child:
                        ButtonTheme(
                          height: 40.0,
                          minWidth: 75,
                          child:
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),


                            ),
                            onPressed: isEnabled ? ()=> buttonclick(context): null,
                            color:  Color(0xFF072331),
                            textColor: Colors.white,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text('SEARCH', style: const TextStyle(fontSize: 12, color: Colors.white,)),
                          ),
                        ),
                      ),

                    ),
                  ),
                ],
              ),
            ),



            Container(
              color:Colors.green,
              height: 80,
              child:
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child:
                    Padding(
                      padding: const EdgeInsets.only(
                          left:15.0, right: 0.0, top: 0, bottom: 0),
                      child:
                      Container(
                        height: 48,
                        child:



                        FutureBuilder<String>(
                            future: myFuture,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return
                                  Center(
                                      child:
                                      Container()
                                  );
                              return

//                                        Scaffold(
//                                        body:

                                Center(
                                    child:


                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          DropdownButton(
                                            items: data.map((item) {
                                              return
                                                DropdownMenuItem(
                                                  child:

                                                  Container(
                                                    width: 200,
                                                    child: Text(
                                                      item['category_type'],
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                  ),
//                                                        Text(item['category_type'], style: const TextStyle(fontSize: 13, color: Colors.black,),maxLines: 2,
//                                                          overflow: TextOverflow.ellipsis,),


                                                  value: item['category_type'],
                                                );
                                            }).toList(),
                                            onChanged: (newVal) {
                                              setState(() {
                                                selectedSpinnerItem = newVal;
                                                print('WWWWWWWWWWWWWWWWWW');


                                                setState(() {
                                                  dropclick(context);
                                                });

                                              });
                                            },
                                            value: selectedSpinnerItem,
                                          ),

                                        ]));
                              // );
                            }),




                      ),
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Container(

                      child:
                      Padding(
                        padding: const EdgeInsets.only(
                            left:5.0, right: 5.0, top: 0, bottom: 0),
                        child:
                        ButtonTheme(
                          height: 45.0,
                          minWidth: 75,
                          child:
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),


                            ),
                            onPressed: isEnabled ? ()=> clearclick(context) : null,
                            color:  Color(0xFF072331),
                            textColor: Colors.white,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text('CLEAR FILTER',style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,

                                fontFamily: 'Noto Sans'
                            ),),
                          ),
                        ),
                      ),

                    ),
                  ),
                ],
              ),
            ),

            FutureBuilder<List<Studentdata>>(
              future: fetchStudents(),
              builder: (context, snapshot) {

                if (!snapshot.hasData) return Center(
                    child: CircularProgressIndicator()
                );

                return

                  Expanded(
                      child:
                    ListView(
                  children: snapshot.data
                      .map((data) => Column(children: <Widget>[
                    GestureDetector(
                      onTap: (){selectedItem(context, data.property_title);},
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: Text('ID = ' + data.property_id.toString(),
                                    style: TextStyle(fontSize: 21))),

                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: Text('Name = ' + data.property_title,
                                    style: TextStyle(fontSize: 21))),

                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: Text('Phone Number = ' + data.signup_mobile.toString(),
                                    style: TextStyle(fontSize: 21))),

                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                child: Text('Subject = ' + data.signup_mobile,
                                    style: TextStyle(fontSize: 21))),

                          ]),),

                    Divider(color: Colors.black),
                  ],))
                      .toList(),
                )

                );

              },
            )








          ],
        ),



          ],
        ),
      );











  }




}






//class Dialogs {
//  static Future<void> showLoadingDialog(
//      BuildContext context, GlobalKey key) async {
//    return showDialog<void>(
//        context: context,
//        barrierDismissible: false,
//        builder: (BuildContext context) {
//          return new WillPopScope(
//              onWillPop: () async => false,
//              child: SimpleDialog(
//                  key: key,
//                  backgroundColor: Colors.black54,
//                  children: <Widget>[
//                    Center(
//                      child: Column(children: [
//                        CircularProgressIndicator(),
//                        SizedBox(height: 10,),
//                        Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),),
//                        FlatButton(
//                          onPressed: () => Navigator.pop(context, true), // passing true
//                          child: Text('Yes'),
//                        ),
//                      ]),
//                    )
//                  ]));
//        });
//  }
//}
























































































//import 'package:flutter/material.dart';
//import 'dart:async';
//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//
//void main() => runApp(MyApplist());
//
//class MyApplist extends StatelessWidget {
//
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter',
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//
//      ),
//      home: InfiniteUsersList(),
//
//
//
//    );
//  }
//}
//
//
//class InfiniteUsersList extends StatefulWidget {
//  static String tag = 'users-page';
//
//  @override
//  State<StatefulWidget> createState() {
//    return new _InfiniteUsersListState();
//  }
//}
//
//class _InfiniteUsersListState extends State<InfiniteUsersList> {
//  final TextEditingController _controller = TextEditingController();
//
//  bool isEnabled = true ;
//
//
//  List<User> users = new List<User>();
//  ScrollController _scrollController = new ScrollController();
//  bool isPerformingRequest = false;
//  int pageNumber = 0;
//
//  @override
//  void initState() {
//    super.initState();
//
//    // Loading initial data or first request to get the data
//    _getMoreData();
//
//    // Loading data after scroll reaches end of the list
//    _scrollController.addListener(() {
//      if (_scrollController.position.pixels ==
//          _scrollController.position.maxScrollExtent) {
//        _getMoreData();
//      }
//    });
//  }
//
//  // to show progressbar while loading data in background
//  Widget _buildProgressIndicator() {
//    return new Padding(
//      padding: const EdgeInsets.all(8.0),
//      child: new Center(
//        child: new Opacity(
//          opacity: isPerformingRequest ? 1.0 : 0.0,
//          child: new CircularProgressIndicator(),
//        ),
//      ),
//    );
//  }
//
//  @override
//  void dispose() {
//    _scrollController.dispose();
//    super.dispose();
//  }
//
//  // Webservice request to load 20 users data using paging
//  Future<List<User>> _getUsers() async {
//    List<User> users = new List<User>();
//    setState(() {
//      pageNumber++;
//    });
//
//    String url =
//        "https://api.randomuser.me/?page=$pageNumber&results=20&seed=abc";
//    print(url);
//
//  //  var response = await http.get(Uri.parse(url));
//   // var jsonData = json.decode(response.body);
//
//   // print(jsonData);
//
//
//
//
//    var request = http.MultipartRequest('POST', Uri.parse('https://itpcchennai.com/web_api/public/buyer_data'));
//    request.fields.addAll({
//
//      'Start': '0',
//      'limit': '100',
//      'search_data': ''
//    });
//    print('3333');
//
//    http.StreamedResponse response = await request.send();
//    var decoded = await response.stream.bytesToString().then(json.decode);
//
//    var usersData = decoded['data'];
//
//   // var usersData = jsonData["results"];
////    for (var user in usersData) {
////      User newUser = User(user["name"]["first"] + user["name"]["last"],
////          user["email"], user["picture"]["large"], user["phone"]);
////      users.add(newUser);
////    }
//    for (var user in usersData) {
//      User newUser = User(user["signup_img1"],user["signup_id"],user["signup_choose"],user["signup_category"]
//          ,user["signup_gst_number"],user["signup_organation"],user["signup_name"],user["signup_email"],user["signup_mobile"]
//          ,user["signup_city"],user["signup_country"],user["signup_address"],user["signup_count"],user["signup_establishment"]
//          ,user["signup_wdays"],user["signup_whours"]
//      );
//      users.add(newUser);
//    }
//
//    return users;
//  }
//
//  _getMoreData() async {
//    if (!isPerformingRequest) {
//      setState(() {
//        isPerformingRequest = true;
//      });
//      List<User> newEntries = await _getUsers(); //returns empty list
//      if (newEntries.isEmpty) {
//        double edge = 50.0;
//        double offsetFromBottom = _scrollController.position.maxScrollExtent -
//            _scrollController.position.pixels;
//        if (offsetFromBottom < edge) {
//          _scrollController.animateTo(
//              _scrollController.offset - (edge - offsetFromBottom),
//              duration: new Duration(milliseconds: 500),
//              curve: Curves.easeOut);
//        }
//      }
//      setState(() {
//        users.addAll(newEntries);
//        isPerformingRequest = false;
//      });
//    }
//  }
//
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Color(0xFFffffff),
//      drawer:
//
//      Drawer(
//        // Add a ListView to the drawer. This ensures the user can scroll
//        // through the options in the drawer if there isn't enough vertical
//        // space to fit everything.
//        child: ListView(
//          // Important: Remove any padding from the ListView.
//          padding: EdgeInsets.zero,
//          children: [
//
//            DrawerHeader(
//              decoration:
//              BoxDecoration(
//                color: Color(0xFFFAFAFA),
//              ),
//              child:
//
//              Container(
//                child:  Column(
//                  mainAxisAlignment: MainAxisAlignment.start,
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                    Padding(
//                      padding: const EdgeInsets.only(
//                          left:5.0, right: 15.0, top: 5, bottom: 0),
//                      child:
//                      Text('Welcome widget.Name',style: const TextStyle(
//                          color: Color(0xFF082130),
//                          fontSize: 18.0,
//                          fontWeight: FontWeight.bold,
//                          fontFamily: 'Noto Sans'
//                      ),),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(
//                          left:5.0, right: 15.0, top: 5, bottom: 0),
//                      child:
//                      Text('(widget.content',style: const TextStyle(
//                          color: Color(0xFF082130),
//                          fontSize: 18.0,
//                          fontWeight: FontWeight.normal,
//                          fontFamily: 'Noto Sans'
//                      ),),
//                    ),
//                  ],
//                ),
//
//              ),
//            ),
//            ListTile(
//              title: Text("Home",style: const TextStyle(
//                  color: Color(0xFF082130),
//                  fontSize: 18.0,
//                  fontWeight: FontWeight.normal,
//                  fontFamily: 'Noto Sans'
//              ),),
//              leading: Image.asset( "images/home_nx.png", height: 25,),
//              selectedTileColor:Colors.black,
//              onTap: () {
//                setState(() {
//
//                });
//              },
//            ),
//
//            ListTile(
//              title: Text("My Product",style: const TextStyle(
//                  color: Color(0xFF082130),
//                  fontSize: 18.0,
//                  fontWeight: FontWeight.normal,
//                  fontFamily: 'Noto Sans'
//              ),),
//              leading: Image.asset( "images/product.png", height: 25,),
//              selectedTileColor:Colors.black,
//              onTap: () {
//                setState(() {
//
//                });
//              },
//            ),
//            ListTile(
//              title: Text("My Profile",style: const TextStyle(
//                  color: Color(0xFF082130),
//                  fontSize: 18.0,
//                  fontWeight: FontWeight.normal,
//                  fontFamily: 'Noto Sans'
//              ),),
//              leading: Image.asset( "images/contact.png", height: 25,),
//              selectedTileColor:Colors.black,
//              onTap: () {
//                setState(() {
//
//                });
//              },
//            ),
//
//            ListTile(
//              title: Text("Event",style: const TextStyle(
//                  color: Color(0xFF082130),
//                  fontSize: 18.0,
//                  fontWeight: FontWeight.normal,
//                  fontFamily: 'Noto Sans'
//              ),),
//              leading: Image.asset( "images/event.png", height: 25,),
//              selectedTileColor:Colors.black,
//              onTap: () {
//                setState(() {
//
//                });
//              },
//            ),
//
//            ListTile(
//              title: Text("Market Brief-India",style: const TextStyle(
//                  color: Color(0xFF082130),
//                  fontSize: 18.0,
//                  fontWeight: FontWeight.normal,
//                  fontFamily: 'Noto Sans'
//              ),),
//              leading: Image.asset( "images/marketbf.png", height: 25,),
//              selectedTileColor:Colors.black,
//              onTap: () {
//                setState(() {
//
//                });
//              },
//            ),
//
//            ListTile(
//              title: Text("Market Brief-Indonesia",style: const TextStyle(
//                  color: Color(0xFF082130),
//                  fontSize: 18.0,
//                  fontWeight: FontWeight.normal,
//                  fontFamily: 'Noto Sans'
//              ),),
//              leading: Image.asset( "images/exportnews.png", height: 25,),
//              selectedTileColor:Colors.black,
//              onTap: () {
//                setState(() {
//
//                });
//              },
//            ),
//            ListTile(
//              title: Text("About Us",style: const TextStyle(
//                  color: Color(0xFF082130),
//                  fontSize: 18.0,
//                  fontWeight: FontWeight.normal,
//                  fontFamily: 'Noto Sans'
//              ),),
//              leading: Image.asset( "images/about.png", height: 25,),
//              selectedTileColor:Colors.black,
//              onTap: () {
//                setState(() {
//
//                });
//              },
//            ),
//            ListTile(
//              title: Text("Contact Us",style: const TextStyle(
//                  color: Color(0xFF082130),
//                  fontSize: 18.0,
//                  fontWeight: FontWeight.normal,
//                  fontFamily: 'Noto Sans'
//              ),),
//              leading: Image.asset( "images/contact.png", height: 25,),
//              selectedTileColor:Colors.black,
//              onTap: () {
//                setState(() {
//
//                });
//              },
//            ),
//            ListTile(
//              title: Text("Change Password",style: const TextStyle(
//                  color: Color(0xFF082130),
//                  fontSize: 18.0,
//                  fontWeight: FontWeight.normal,
//                  fontFamily: 'Noto Sans'
//              ),),
//              leading: Image.asset( "images/changepassword.png", height: 25,),
//              selectedTileColor:Colors.black,
//              onTap: () {
//                setState(() {
//
//                });
//              },
//            ),
//
//            ListTile(
//              title: Text("Logout",style: const TextStyle(
//                  color: Color(0xFF082130),
//                  fontSize: 18.0,
//                  fontWeight: FontWeight.normal,
//                  fontFamily: 'Noto Sans'
//              ),),
//              leading: Image.asset( "images/logout.png", height: 25,),
//              selectedTileColor:Colors.black,
//              onTap: () {
//                setState(() {
//
//                });
//              },
//            ),
//
//            Container(
//              height: 200,
//            )
//
//
//
//          ],
//        ),
//      ),
//      appBar:
//      AppBar(
//        centerTitle: false,
//        title:
//        Row(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: [
//
//
//            Padding(
//              padding: const EdgeInsets.only(
//                  left: 25.0, right: 0.0, top: 10, bottom: 0),
//              child:Text('ITPC CHENNAI', style: TextStyle(fontSize: 20,color: Colors.black),textAlign: TextAlign.left,),
//            )
//          ],
//        ),
//
//        iconTheme: IconThemeData(
//          color: Colors.black,
//        ),
//
//
//
//
//        backgroundColor:Color(0xFFFFFFFF),
//        flexibleSpace: Container(
//          decoration: BoxDecoration(
////              gradient: LinearGradient(
////                  begin: Alignment.topLeft,
////                  end: Alignment.bottomRight,
////                  colors: <Color>[
////                    Color(0xFF4F97FB).withOpacity(1),
////                    Color(0xFF5564F8).withOpacity(1)
////                  ])
//          ),
//        ),
//
//
//        elevation: 0.0,
//
//        actions: <Widget>[
//
//
//
//        ],
//      ),
//      body:
//
//
//     Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//
//         SizedBox(
//           height: 10,
//         ),
//     Container(
//
//       child:
//       Row(
//         children: <Widget>[
//           Expanded(
//             flex: 7,
//             child:
//             Padding(
//               padding: const EdgeInsets.only(
//                   left:15.0, right: 0.0, top: 0, bottom: 0),
//               child:
//             Container(
//height: 40,
//                  child:TextField(
//  controller: _controller,
//  onChanged: (value) {
//    // Call setState to update the UI
//    setState(() {});
//  },
//  decoration: InputDecoration(
//    labelText: 'Search here',
//    border: const OutlineInputBorder(),
//    prefixIcon: const Icon(Icons.search),
//
//
//
//  ),
//),
//
//
//
//             ),
//             ),
//           ),
//
//           Expanded(
//             flex: 3,
//             child: Container(
//
//              child:
//              Padding(
//                padding: const EdgeInsets.only(
//                    left:5.0, right: 5.0, top: 0, bottom: 0),
//                child:
//              ButtonTheme(
//                 height: 40.0,
//                 minWidth: 75,
//                 child:
//                 RaisedButton(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(5.0),
//
//
//                   ),
//                   onPressed: isEnabled ? ()=> _getUsers() : null,
//                   color:  Color(0xFF072331),
//                   textColor: Colors.white,
//                   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                   child: Text('LOGIN'),
//                 ),
//               ),
//              ),
//
//             ),
//           ),
//         ],
//       ),
//     ),
//     Padding(
//     padding: const EdgeInsets.only(
//     left:15.0, right: 15.0, top: 5, bottom: 0),
//     child:
//     Text('Indian Buyer Deatils',style: const TextStyle(
//     color: Colors.black,
//    fontSize: 16.0,
//    fontWeight: FontWeight.bold,
//    fontFamily: 'Noto Sans'
//    ),),
//     ),
//         SizedBox(
//           height: 30,
//         ),
//
//
//     Expanded(child:
//         Container(
//             child:
//             ListView.builder(
//                 shrinkWrap: true,
//                 controller: _scrollController,
//                 itemCount: users.length + 1,
//                 itemBuilder: (BuildContext context, int index) {
//                   if (index == users.length) {
//                     return _buildProgressIndicator();
//                   } else {
//                     return
//
////                    ListTile(
////                    onTap: () {
////                      Navigator.push(
////                          context,
////                          new MaterialPageRoute(
////                              builder: (context) =>
////                                  UserDetailPage(users[index])));
////                    },
////                    title: Text(users[index].fullName),
////                    subtitle: Text(users[index].mobileNumber),
////                    leading: CircleAvatar(
////                        backgroundImage: NetworkImage(users[index].imageUrl)),
////                  );
//
//                       Padding(
//                           padding: const EdgeInsets.only(
//                               left:10.0, right: 10.0, top: 0, bottom: 0),
//                           child:
//                           Card(
//                               child:
//                               ListTile(
//                                 title: Container(
//                                   child:
//
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//
//
//                                       Row(
//
//                                         children: <Widget>[
//                                           Expanded(
//                                             flex: 3,
//                                             child:
//                                             Container(
//
//                                               color:Color(0xFFD1D4D9),
//                                               height: 80,
//                                               width: 80,
//                                               child:
//
//                                               Image.network(
//
//                                                 users[index].signup_img1 == 'https://itpcchennai.com/profile_icon/'? 'http://ecorewick.com/moniespay_api/images/default_profile.png' :  users[index].signup_img1 == 'https://itpcchennai.com/profile_icon/ '?'http://ecorewick.com/moniespay_api/images/default_profile.png': users[index].signup_img1
//                                                 ,
//                                               ),
//
//
//                                             ),
//                                           ),
//
//
//                                           Expanded(
//                                             flex: 7,
//                                             child:
//                                             Container(
//
//                                               height: 100,
//                                               child:
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left:10.0, right: 0.0, top: 5, bottom: 0),
//                                                 child:
//                                                 Column(
//
//                                                   mainAxisAlignment: MainAxisAlignment.start,
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(users[index].signup_name,style: TextStyle(fontSize: 14,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,),),
//                                                     Text(users[index].signup_organation,style: TextStyle(fontSize: 13,color: Color(0xFF000000), fontWeight: FontWeight.normal,),),
//                                                     Text(users[index].signup_email,style: TextStyle(fontSize: 13,color: Color(0xFF000000), fontWeight: FontWeight.normal,),),
//                                                     Text(users[index].signup_mobile,style: TextStyle(fontSize: 13,color: Color(0xFF000000), fontWeight: FontWeight.normal,),),
//                                                     Text(users[index].signup_gst_number,style: TextStyle(fontSize: 13,color: Color(0xFF000000), fontWeight: FontWeight.normal,),),
//
//                                                   ],),
//                                               ),
//
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//
//                                       Text('Type:'+users[index].signup_choose,style: TextStyle(fontSize: 13,color: Color(0xFF000000), fontWeight: FontWeight.normal,),),
//                                       Text('Categories: '+users[index].signup_category,style: TextStyle(fontSize: 13,color: Color(0xFF000000), fontWeight: FontWeight.normal,),),
//
//                                     ],),
//
//
//                                 ),
//
//                               )
//                           ));
//                   }
//                 }))),
//
//
//
//       ],
//     ) ,
//
//
//
//
//    );
//  }
//}
//
//class User {
//  final String signup_img1;
//
//  final String signup_id;
//
//  final String signup_choose;
//
//  final String signup_category;
//  final String signup_gst_number;
//  final String signup_organation;
//  final String signup_name;
//  final String signup_email;
//  final String signup_mobile;
//  final String signup_city;
//  final String signup_country;
//  final String signup_address;
//  final String signup_count;
//  final String signup_establishment;
//  final String signup_wdays;
//  final String signup_whours;
//
//  User(this.signup_img1, this.signup_id, this.signup_choose, this.signup_category
//      ,this.signup_gst_number,this.signup_organation,this.signup_name,this.signup_email,this.signup_mobile
//      ,this.signup_city,this.signup_country,this.signup_address,this.signup_count,this.signup_establishment
//      ,this.signup_wdays,this.signup_whours
//
//      );
//}
//
//// User Detail Page
//
//class UserDetailPage extends StatelessWidget {
//  final User user;
//
//  UserDetailPage(this.user);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("User Details"),
//      ),
//      body: Center(
//        child: Text(
//          user.signup_name,
//          style: TextStyle(fontSize: 35.0),
//        ),
//      ),
//    );
//  }
//}