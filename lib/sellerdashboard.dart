// @dart=2.9



import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:itpcchennaiapp/about.dart';
import 'package:itpcchennaiapp/changepassword.dart';
import 'package:itpcchennaiapp/contact.dart';
import 'package:itpcchennaiapp/event.dart';

import 'package:itpcchennaiapp/exportnewsindonesia.dart';
import 'package:itpcchennaiapp/itemss.dart';
import 'package:itpcchennaiapp/listmore.dart';
import 'package:itpcchennaiapp/login.dart';
import 'package:itpcchennaiapp/marketbriefdetails.dart';
import 'package:itpcchennaiapp/marketbriefindia.dart';
import 'package:itpcchennaiapp/myprofile.dart';
import 'package:itpcchennaiapp/productdtls.dart';
import 'package:itpcchennaiapp/profile.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
import 'package:itpcchennaiapp/productdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

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

class sellerdashbaord extends StatefulWidget {


  sellerdashbaord({this.userid, this.Type, this.content, this.Name, this.signupid});

  var userid;
  var Type;
  var content;
  var Name;
  var signupid;

  @override

  UserFilterDemoState createState() => UserFilterDemoState();
}
class UserFilterDemoState extends State<sellerdashbaord> {


  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final TextEditingController _controller = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedSpinnerItem = 'Banana';
  List data = List();
  Future myFuture;

  bool _isLoading = false;
  bool isEnabled = true;

  int _searchtype = 0;
  bool isPerformingRequest = false;



  @override
  void initState() {
    super.initState();

   String str = p.extension('https://itpcchennai.com/img_uploads/productimages53264_0.A');
    print('extention');
    print(str);
    myFuture = fetchData();
  }


  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }


  void showOverlay() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }


  final String uri = 'https://itpcchennai.com/web_api/public/common_service';

  Future<String> fetchData() async {

    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      print('Loaded');
      var res = await http.get(
          Uri.parse(uri), headers: {"Accept": "application/json"});
      print(response.body);
      var resBody = json.decode(res.body);
      List jsonResponse = resBody["Category"] as List;

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

    if (_searchtype == 0) {
      searchfiled = '';
    }
    else if (_searchtype == 1) {
      searchfiled = _controller.text;
    }
    else {
      searchfiled = selectedSpinnerItem.toString();
    }
    print('SEARCH');
    print(_searchtype);
    print(searchfiled);
    print('SEARCH');
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://itpcchennai.com/web_api/public/getProduct'));
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
      setState(() {
        _searchtype = 1;
        fetchStudents();
        _isLoading = true;
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
      });
    } catch (error) {
      print(error);
    }
  }


  Future<void> dropclick(BuildContext context) async {
    try {
      setState(() {
        _searchtype = 2;
        fetchStudents();
        _isLoading = true;
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
      });
    } catch (error) {
      print(error);
    }
  }


  Future<void> clearclick(BuildContext context) async {
    try {
      setState(() {
        _searchtype = 0;
        fetchStudents();
        _isLoading = true;
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
      });
    } catch (error) {
      print(error);
    }
  }


  // to show progressbar while loading data in background
  Widget _buildProgressIndicator() {
    return new

    BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Center(
            child: new Opacity(
              opacity: isPerformingRequest ? 1.0 : 0.0,
              child: new CircularProgressIndicator(),
            ),
          ),
        )
    );

  }
  Future<List<dynamic>> productdtls(String id) async {



    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          productdls(
              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,CatID:id.toString()

          )),
    );



  }

  void _handleLogout() async {
    print('logout');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("SessionUserid");
    prefs.remove("SessionFIRSTNAME");
    prefs.remove("Sessionemail");
    prefs.remove("SessionMemberID");
    prefs.remove("Sessionsignup_choose");
    prefs.remove("Sessionsignup_content");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => login()),
    );

  }


  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFffffff),
        drawer:

        Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
            Container(
            height: 150.0,
            child:
              DrawerHeader(
                decoration:
                BoxDecoration(
                  color: Color(0xFFFAFAFA),
                ),
                child:

                Container(
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [


                    Align(
                    alignment: Alignment.topLeft,
                    child:
                      Padding(
                        padding: const EdgeInsets.only(
                            left:5.0, right: 15.0, top: 5, bottom: 0),
                        child:
                        Text('Welcome '+widget.Name,style: const TextStyle(
                            color: Color(0xFF082130),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Noto Sans'
                        ),),
                      ),
                    ),
                  Align(
                    alignment: Alignment.topLeft,
                    child:
                      Padding(
                        padding: const EdgeInsets.only(
                            left:5.0, right: 15.0, top: 5, bottom: 0),
                        child:
                        Text('('+widget.content+' )',style: const TextStyle(
                            color: Color(0xFF082130),
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Noto Sans'
                        ),),
                      ),
                  ),



                    ],
                  ),

                ),
              ),
            ),

              ListTile(
                title: Text("Home",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/home_nx.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          sellerdashbaord(
                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

                          )),
                    );

                  });
                },
              ),


              ListTile(
                title: Text("My Profile",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading:

                Icon(Icons.account_circle, color: Colors.black,),
                //Image.asset( "images/contact.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          myprofile(
                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

                          )),
                    );


                  });
                },
              ),

              ListTile(
                title: Text("Event",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/event.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          event(
                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

                          )),
                    );
                  });
                },
              ),

              ListTile(
                title: Text("Market Brief-India",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/marketbf.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {


                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          marketbriefindia(
                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

                          )),
                    );


                  });
                },
              ),

              ListTile(
                title: Text("Export News-Indonesia",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/exportnews.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {


                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          exportnewindonesia(
                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

                          )),
                    );



                  });
                },
              ),
              ListTile(
                title: Text("About Us",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/about.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          aboutus(
                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

                          )),
                    );
                  });
                },
              ),
              ListTile(
                title: Text("Contact Us",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/contact.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          contactus(
                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

                          )),
                    );
                  });
                },
              ),
              ListTile(
                title: Text("Change Password",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/changepassword.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          changepass(
                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid,previouspage: 'sellerdashboard',

                          )),
                    );


                  });
                },
              ),

              ListTile(
                title: Text("Logout",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/logout.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {
                    _handleLogout();
                  });
                },
              ),




              Container(
                height: 200,
              )



            ],
          ),
        ),


        appBar:
        AppBar(
          centerTitle: false,
          title:
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 0.0, top: 10, bottom: 0),
                child: Text('ITPC CHENNAI',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.left,),
              )
            ],
          ),

          iconTheme: IconThemeData(
            color: Colors.black,
          ),

          leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: Image.asset(
              'images/menu.png',
              height: 25,
            ),
          ),
          backgroundColor: Color(0xFFFFFFFF),
          flexibleSpace: Container(
            decoration: BoxDecoration(
//              gradient: LinearGradient(
//                  begin: Alignment.topLeft,
//                  end: Alignment.bottomRight,
//                  colors: <Color>[
//                    Color(0xFF4F97FB).withOpacity(1),
//                    Color(0xFF5564F8).withOpacity(1)
//                  ])
            ),
          ),


          elevation: 0.0,

          actions: <Widget>[
          ],
        ),
        body:

        LoadingOverlay(
          child:

//        Container(
//          padding: const EdgeInsets.all(16.0),
//          child: Column(
//            children: [
//              Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child:  Text( 'Modal Progress HUD Example ',
//                    style: TextStyle(fontSize: 20.0),
//                  )
//              ),
//              Padding(
//                padding: const EdgeInsets.all(32.0),
//                child: RaisedButton(
//                  onPressed: showOverlay,
//                  child: Text('Show'),
//                ),
//              ),
//            ],
//          ),
//        ),

          Container(

            child:
            Stack(
              children: <Widget>[


                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Container(

                      height: 80,
                      child:
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 7,
                            child:
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 0.0, top: 0, bottom: 0),
                              child:
                              Container(
                                height: 40,
                                child: TextField(
                                  controller: _controller,

                                  onChanged: (value) {
                                    // Call setState to update the UI
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(

                                    hintText: 'Search here',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey
                                        )
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.grey)
                                    ),


                                    prefixIcon: const Icon(
                                      Icons.search, color: Colors.grey,),


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
                                    left: 5.0, right: 5.0, top: 0, bottom: 0),
                                child:
                                ButtonTheme(
                                  height: 40.0,
                                  minWidth: 75,
                                  child:
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(
                                          5.0),


                                    ),
                                    onPressed: isEnabled ? () =>
                                        buttonclick(context) : null,
                                    color: Color(0xFF072331),
                                    textColor: Colors.white,
                                    padding: EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Text('SEARCH',
                                        style: const TextStyle(
                                          fontSize: 12, color: Colors.white,)),
                                  ),
                                ),
                              ),

                            ),
                          ),
                        ],
                      ),
                    ),


                    Container(

                      height: 55,
                      child:
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 7,
                            child:
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 0.0, top: 0, bottom: 0),
                              child:
                              Container(
                                height: 50,
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
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
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
                                                              overflow: TextOverflow
                                                                  .ellipsis,
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
                                                        selectedSpinnerItem =
                                                            newVal;
                                                        print(
                                                            'WWWWWWWWWWWWWWWWWW');


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
                                    left: 5.0, right: 5.0, top: 0, bottom: 0),
                                child:
                                ButtonTheme(
                                  height: 45.0,
                                  minWidth: 75,
                                  child:
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(
                                          5.0),


                                    ),
                                    onPressed: isEnabled ? () =>
                                        clearclick(context) : null,
                                    color: Color(0xFF072331),
                                    textColor: Colors.white,
                                    padding: EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Text(
                                      'CLEAR FILTER', style: const TextStyle(
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left:15.0, right: 15.0, top: 5, bottom: 0),
                      child:
                      Text('LATEST PRODUCTS',style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Noto Sans'
                      ),),
                    ),

                    FutureBuilder<List<Studentdata>>(
                      future: fetchStudents(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return Center(
                            child: _buildProgressIndicator()
                        );

                        return

                          Expanded(
                              child:
                              ListView(
                                children: snapshot.data
                                    .map((data) =>




                                Padding(
                                    padding: const EdgeInsets.only(
                                        left:10.0, right: 10.0, top: 0, bottom: 0),
                                    child:
                                    Card(
                                        child:
                                        ListTile(
                                          title: Container(
                                            child:

                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [


                                                Row(

                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 4,
                                                      child:
                                                      Container(

                                                        //color:Color(0xFFD1D4D9),

                                                        child:

                                                        Image.network(
                                                          data.image_prop == '' ? 'http://ecorewick.com/moniespay_api/images/norecord.png' : p.extension(data.image_prop) != '.jpg' ? p.extension(data.image_prop) != '.png' ? 'http://ecorewick.com/moniespay_api/images/norecord.png':data.image_prop :data.image_prop
                                                         // data.image_prop == ''? 'http://ecorewick.com/moniespay_api/images/norecord.png' :  data.image_prop == ''?'http://ecorewick.com/moniespay_api/images/norecord.png': data.image_prop
                                                          ,  width: 120,
                                                          height: 110,
                                                          fit: BoxFit.cover,
                                                        ),


                                                      ),
                                                    ),


                                                    Expanded(
                                                      flex: 7,
                                                      child:
                                                      Container(


                                                        child:
                                                        Padding(
                                                          padding: const EdgeInsets.only(
                                                              left:10.0, right: 0.0, top: 5, bottom: 0),
                                                          child:
                                                          Column(

                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [

                                                              Text(data.property_title,style: TextStyle(fontSize: 14,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,),),

//                                                              Container(
//                                                                width: 200,
//                                                                child: Text(
//                                                                  users[index].property_description,
//                                                                  overflow: TextOverflow.ellipsis,
//                                                                  maxLines: 6,style: TextStyle(fontSize: 12,color: Color(0xFF0F1C51),),
//                                                                ),
//                                                              ),

                                                              ReadMoreText(
                                                                data.property_description,
                                                                trimLines: 5,
                                                                textAlign: TextAlign.justify,
                                                                trimMode: TrimMode.Line,
                                                                trimCollapsedText: "  More ",
                                                                trimExpandedText: "  Less ",
                                                                lessStyle: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Color(0xFF9A9CA0),
                                                                ),
                                                                moreStyle: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Color(0xFF9A9CA0),
                                                                ),
                                                                style: TextStyle(
                                                                  fontSize: 12,

                                                                ),
                                                              ),





                                                            ],),
                                                        ),

                                                      ),
                                                    ),
                                                  ],
                                                ),



                                                Row(

                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 5,
                                                      child:
                                                      Container(

                                                        //color:Color(0xFFD1D4D9),

                                                          child:


                                                          Row(
                                                            children: [
                                                             // Image.asset('images/trusted.png', width: 50, height: 50,),
//                                                              Text('Trusted Seller',style: const TextStyle(
//                                                                  color: Colors.black,
//                                                                  fontSize: 12.0,
//                                                                  fontWeight: FontWeight.bold,
//                                                                  fontFamily: 'Noto Sans'
//                                                              ),),
                                                            ],
                                                          )


                                                      ),
                                                    ),


                                                    Expanded(
                                                      flex: 5,
                                                      child:
                                                      Container(


                                                        child:
                                                        Image.asset('images/like.png',  height: 30,),

                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                Row(

                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 5,
                                                      child:
                                                      Container(

                                                        //color:Color(0xFFD1D4D9),

                                                        child:
                                                        Padding(
                                                          padding: const EdgeInsets.only(
                                                              left:0.0, right: 0.0, top: 5, bottom: 0),
                                                          child:


                                                          ButtonTheme(
                                                            height: 35.0,
                                                            minWidth: 150,

                                                            child:
                                                            RaisedButton(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: new BorderRadius.circular(5.0),
                                                                  side: BorderSide(color: Color(0xFF072331))


                                                              ),
                                                              onPressed: isEnabled ? ()=> '': null,
                                                              color:  Color(0xFFFFFFFF),
                                                              textColor: Color(0xFF072331),
                                                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                              child: Text('Call '+data.signup_mobile, style: TextStyle(fontSize: 12,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,

                                                              ),),
                                                            ),
                                                          ),
                                                        ),


                                                      ),
                                                    ),


                                                    Expanded(
                                                      flex: 5,
                                                      child:
                                                      Container(


                                                        child:
                                                        Padding(
                                                          padding: const EdgeInsets.only(
                                                              left:10.0, right: 5.0, top: 5, bottom: 0),
                                                          child:

                                                          ButtonTheme(
                                                            height: 35.0,
                                                            minWidth: double.infinity,
                                                            child:
                                                            RaisedButton(
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: new BorderRadius.circular(5.0),


                                                              ),
                                                              onPressed: isEnabled ? ()=> productdtls(data.property_id) : null,
                                                              color:  Color(0xFF072331),
                                                              textColor: Colors.white,
                                                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                              child: Text('Send Inquiry'),
                                                            ),
                                                          ),
                                                        ),

                                                      ),
                                                    ),
                                                  ],
                                                ),



                                              ],),


                                          ),

                                        )
                                    ))

                                )
                                    .toList(),
                              )

                          );
                      },
                    )


                  ],
                ),


              ],
            ),
          ),

          isLoading: _isLoading,
          // additional parameters
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
        ),
      );
  }
}











