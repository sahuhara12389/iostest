// @dart=2.9



import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:itpcchennaiapp/about.dart';
import 'package:itpcchennaiapp/changepassword.dart';
import 'package:itpcchennaiapp/contact.dart';
import 'package:itpcchennaiapp/exportnewsindonesia.dart';
import 'package:itpcchennaiapp/login.dart';
import 'package:itpcchennaiapp/marketbriefindia.dart';
import 'package:itpcchennaiapp/myprofile.dart';
import 'package:itpcchennaiapp/profile.dart';
import 'package:itpcchennaiapp/sellerdashboard.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;


class Studentdata {
  String property_id;
  String image_prop;
  String property_title;
//  String signup_category;
//
//  String property_title;
//  String property_description;
//  String property_image;
//  String property_company;
//
//  String signup_choose;
//  String signup_img;
//  String signup_gst_number;
//  String signup_organation;
//  String signup_name;
//  String signup_email;
//  String signup_mobile;
//  String signup_city;
//
//  String signup_country;
//  String signup_address;
//  String signup_count;
//  String signup_establishment;
//
//  String signup_wdays;
//  String signup_whours;
//  String signup_about;
//  String signup_website;

  Studentdata({
    this.property_id,
   this.image_prop,
    this.property_title,
//    this.signup_category,
//
//    this.property_title,
//    this.property_description,
//    this.property_image,
//    this.property_company,
//
//
//
//    this.signup_choose,
//    this.signup_img,
//    this.signup_gst_number,
//    this.signup_organation,
//
//
//    this.signup_name,
//    this.signup_email,
//    this.signup_mobile,
//    this.signup_city,
//
//
//    this.signup_country,
//    this.signup_address,
//    this.signup_count,
//    this.signup_establishment,
//
//
//    this.signup_wdays,
//    this.signup_whours,
//    this.signup_about,
//    this.signup_website,
  });

  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(
      property_id: json['property_id'],
      image_prop: json['image_prop'],
      property_title: json['property_title'],
//        signup_category: json['signup_category'],
//
//        property_title: json['property_title'],
//        property_description: json['property_description'],
//        property_image: json['property_image'],
//        property_company: json['property_company'],
//
//
//        signup_choose: json['signup_choose'],
//        signup_img: json['signup_img'],
//        signup_gst_number: json['signup_gst_number'],
//        signup_organation: json['signup_organation'],
//
//        signup_name: json['signup_name'],
//        signup_email: json['signup_email'],
//        signup_mobile: json['signup_mobile'],
//        signup_city: json['signup_city'],
//
//
//
//      signup_country: json['signup_country'],
//      signup_address: json['signup_address'],
//      signup_count: json['signup_count'],
//      signup_establishment: json['signup_establishment'],
//
//
//      signup_wdays: json['signup_wdays'],
//      signup_whours: json['signup_whours'],
//      signup_about: json['signup_about'],
//      signup_website: json['signup_website'],


    );
  }
}

class productdetails extends StatefulWidget {


  productdetails({this.userid, this.Type, this.content, this.Name, this.signupid, this.CatID});

  var userid;
  var Type;
  var content;
  var Name;
  var signupid;
  var CatID;

  @override

  UserFilterDemoState createState() => UserFilterDemoState();
}
class UserFilterDemoState extends State<productdetails> {

  bool rememberMe = true;
  bool rememberMe2 = true;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final TextEditingController _controller = TextEditingController();

  final TextEditingController signup_organation = new TextEditingController();
  final TextEditingController signup_city = new TextEditingController();
  final TextEditingController signup_country = new TextEditingController();
  final TextEditingController property_title = new TextEditingController();
  final TextEditingController signup_category = new TextEditingController();
  final TextEditingController signup_count = new TextEditingController();
  final TextEditingController signup_establishment = new TextEditingController();
  final TextEditingController signup_wdays = new TextEditingController();
  final TextEditingController signup_whours = new TextEditingController();
  final TextEditingController signup_mobile = new TextEditingController();
  final TextEditingController about = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  final TextEditingController commodityname = new TextEditingController();
  final TextEditingController hscode = new TextEditingController();
  final TextEditingController quantity = new TextEditingController();




  void _onRememberMeChanged(bool newValue) => setState(() {
    rememberMe = newValue;

    if (rememberMe) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
  });
  void _onRememberMeChanged2(bool newValue) => setState(() {
    rememberMe2 = newValue;

    if (rememberMe2) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
  });
  String selectedSpinnerItem = 'Banana';
  List data = List();
  Future myFuture;

  bool _isLoading = false;
  bool isEnabled = true;

  int _searchtype = 0;
  bool isPerformingRequest = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();

    myFuture =   fetchStudents();
  }


  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
//  List<String> images = [
//    "images/mission.png",
//    "images/india.png",
//    "images/mission.png",
//    "images/india.png",
//    "images/mission.png",
//    "images/india.png",
//    "images/mission.png",
//
//  ];

  List<String> images = [];


  Future<List<Studentdata>> fetchStudents() async {

print('CATEGORY');
print(widget.CatID.toString());
print('CATEGORY');

    var request = http.MultipartRequest(
        'POST', Uri.parse('https://itpcchennai.com/web_api/public/SingleProduct'));
    request.fields.addAll({
     'property_id': widget.CatID.toString()

    });
    print('3333');

    http.StreamedResponse response = await request.send();
    var decoded = await response.stream.bytesToString().then(json.decode);


    if (response.statusCode == 200) {




      print('000');
      final items = decoded['postimage'].cast<Map<String, dynamic>>();
      print('111');

     // images=items;


      List<Studentdata> studentList = items.map<Studentdata>((json) {
        return Studentdata.fromJson(json);
      }).toList();

      var usersDataFromJson = {decoded['data']};
      print('66666');
      String data2 = usersDataFromJson.toString();
      print(data2.toString());
      print('777');
      List<String> stri = data2.split(":");

    String  property_id = stri[1].replaceAll("property_id", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(" ", "");

//      String  property_category = stri[3].replaceAll("property_category", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  property_email = stri[5].replaceAll("property_email", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_category = stri[7].replaceAll("signup_category", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  property_title = stri[9].replaceAll("property_title", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  property_description = stri[11].replaceAll("property_description", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  property_image = stri[13].replaceAll("property_image", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  property_company = stri[15].replaceAll("property_company", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_choose = stri[17].replaceAll("signup_choose", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_img = stri[19].replaceAll("signup_img", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_gst_number = stri[21].replaceAll("signup_gst_number", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_organation = stri[23].replaceAll("signup_organation", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_name = stri[25].replaceAll("signup_name", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_email = stri[27].replaceAll("signup_email", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_mobile = stri[29].replaceAll("signup_mobile", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_city = stri[31].replaceAll("signup_city", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_country = stri[33].replaceAll("signup_country", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_address = stri[35].replaceAll("signup_address", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//
//      String  signup_count = stri[37].replaceAll("signup_count", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_establishment = stri[39].replaceAll("signup_establishment", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_wdays = stri[41].replaceAll("signup_wdays", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_whours = stri[43].replaceAll("signup_whours", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_about = stri[45].replaceAll("signup_about", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_website = stri[47].replaceAll("signup_website", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");




      return studentList;
    }
    else {
      throw Exception('Failed to load data from Server.');
    }
  }





  Future<List<Studentdata>> fetchStudents2() async {


    var request = http.MultipartRequest(
        'POST', Uri.parse('https://itpcchennai.com/web_api/public/SingleProduct'));
    request.fields.addAll({
      'property_id': '8'

    });
    print('3333');

    http.StreamedResponse response = await request.send();
    var decoded = await response.stream.bytesToString().then(json.decode);


    if (response.statusCode == 200) {




      print('000');
      final items = decoded['postimage'].cast<Map<String, dynamic>>();
      print('111');

      // images=items;


      List<Studentdata> studentList = items.map<Studentdata>((json) {
        return Studentdata.fromJson(json);
      }).toList();

      var usersDataFromJson = {decoded['data']};
      print('66666');
      String data2 = usersDataFromJson.toString();
      print(data2.toString());
      print('777');
      List<String> stri = data2.split(":");

      String  property_id = stri[1].replaceAll("property_id", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(" ", "");

//      String  property_category = stri[3].replaceAll("property_category", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  property_email = stri[5].replaceAll("property_email", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_category = stri[7].replaceAll("signup_category", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  property_title = stri[9].replaceAll("property_title", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  property_description = stri[11].replaceAll("property_description", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  property_image = stri[13].replaceAll("property_image", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  property_company = stri[15].replaceAll("property_company", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_choose = stri[17].replaceAll("signup_choose", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_img = stri[19].replaceAll("signup_img", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_gst_number = stri[21].replaceAll("signup_gst_number", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_organation = stri[23].replaceAll("signup_organation", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_name = stri[25].replaceAll("signup_name", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_email = stri[27].replaceAll("signup_email", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_mobile = stri[29].replaceAll("signup_mobile", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_city = stri[31].replaceAll("signup_city", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_country = stri[33].replaceAll("signup_country", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_address = stri[35].replaceAll("signup_address", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//
//      String  signup_count = stri[37].replaceAll("signup_count", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_establishment = stri[39].replaceAll("signup_establishment", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_wdays = stri[41].replaceAll("signup_wdays", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_whours = stri[43].replaceAll("signup_whours", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_about = stri[45].replaceAll("signup_about", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_website = stri[47].replaceAll("signup_website", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");




      return studentList;
    }
    else {
      throw Exception('Failed to load data from Server.');
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


  circularProgress() {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }



  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFffffff),
//        drawer:
//
//        Drawer(
//          // Add a ListView to the drawer. This ensures the user can scroll
//          // through the options in the drawer if there isn't enough vertical
//          // space to fit everything.
//          child: ListView(
//            // Important: Remove any padding from the ListView.
//            padding: EdgeInsets.zero,
//            children: [
//
//              DrawerHeader(
//                decoration:
//                BoxDecoration(
//                  color: Color(0xFFFAFAFA),
//                ),
//                child:
//
//                Container(
//                  child:  Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      Padding(
//                        padding: const EdgeInsets.only(
//                            left:5.0, right: 15.0, top: 5, bottom: 0),
//                        child:
//                        Text('Welcome '+widget.Name,style: const TextStyle(
//                            color: Color(0xFF082130),
//                            fontSize: 18.0,
//                            fontWeight: FontWeight.bold,
//                            fontFamily: 'Noto Sans'
//                        ),),
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.only(
//                            left:5.0, right: 15.0, top: 5, bottom: 0),
//                        child:
//                        Text('('+widget.content+' )',style: const TextStyle(
//                            color: Color(0xFF082130),
//                            fontSize: 18.0,
//                            fontWeight: FontWeight.normal,
//                            fontFamily: 'Noto Sans'
//                        ),),
//                      ),
//                    ],
//                  ),
//
//                ),
//              ),
//              ListTile(
//                title: Text("Home",style: const TextStyle(
//                    color: Color(0xFF082130),
//                    fontSize: 18.0,
//                    fontWeight: FontWeight.normal,
//                    fontFamily: 'Noto Sans'
//                ),),
//                leading: Image.asset( "images/home_nx.png", height: 25,),
//                selectedTileColor:Colors.black,
//                onTap: () {
//                  setState(() {
//
//                  });
//                },
//              ),
//
//
//              ListTile(
//                title: Text("My Profile",style: const TextStyle(
//                    color: Color(0xFF082130),
//                    fontSize: 18.0,
//                    fontWeight: FontWeight.normal,
//                    fontFamily: 'Noto Sans'
//                ),),
//                leading: Image.asset( "images/contact.png", height: 25,),
//                selectedTileColor:Colors.black,
//                onTap: () {
//                  setState(() {
//
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          myprofile(
//                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid
//
//                          )),
//                    );
//
//
//                  });
//                },
//              ),
//
//              ListTile(
//                title: Text("Event",style: const TextStyle(
//                    color: Color(0xFF082130),
//                    fontSize: 18.0,
//                    fontWeight: FontWeight.normal,
//                    fontFamily: 'Noto Sans'
//                ),),
//                leading: Image.asset( "images/event.png", height: 25,),
//                selectedTileColor:Colors.black,
//                onTap: () {
//                  setState(() {
//
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          event(
//                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid
//
//                          )),
//                    );
//                  });
//                },
//              ),
//
//              ListTile(
//                title: Text("Market Brief-India",style: const TextStyle(
//                    color: Color(0xFF082130),
//                    fontSize: 18.0,
//                    fontWeight: FontWeight.normal,
//                    fontFamily: 'Noto Sans'
//                ),),
//                leading: Image.asset( "images/marketbf.png", height: 25,),
//                selectedTileColor:Colors.black,
//                onTap: () {
//                  setState(() {
//
//
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          marketbriefindia(
//                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid
//
//                          )),
//                    );
//
//
//                  });
//                },
//              ),
//
//              ListTile(
//                title: Text("Market Brief-Indonesia",style: const TextStyle(
//                    color: Color(0xFF082130),
//                    fontSize: 18.0,
//                    fontWeight: FontWeight.normal,
//                    fontFamily: 'Noto Sans'
//                ),),
//                leading: Image.asset( "images/exportnews.png", height: 25,),
//                selectedTileColor:Colors.black,
//                onTap: () {
//                  setState(() {
//
//
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          exportnewindonesia(
//                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid
//
//                          )),
//                    );
//
//
//
//                  });
//                },
//              ),
//              ListTile(
//                title: Text("About Us",style: const TextStyle(
//                    color: Color(0xFF082130),
//                    fontSize: 18.0,
//                    fontWeight: FontWeight.normal,
//                    fontFamily: 'Noto Sans'
//                ),),
//                leading: Image.asset( "images/about.png", height: 25,),
//                selectedTileColor:Colors.black,
//                onTap: () {
//                  setState(() {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          aboutus(
//                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid
//
//                          )),
//                    );
//                  });
//                },
//              ),
//              ListTile(
//                title: Text("Contact Us",style: const TextStyle(
//                    color: Color(0xFF082130),
//                    fontSize: 18.0,
//                    fontWeight: FontWeight.normal,
//                    fontFamily: 'Noto Sans'
//                ),),
//                leading: Image.asset( "images/contact.png", height: 25,),
//                selectedTileColor:Colors.black,
//                onTap: () {
//                  setState(() {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          contactus(
//                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid
//
//                          )),
//                    );
//                  });
//                },
//              ),
//              ListTile(
//                title: Text("Change Password",style: const TextStyle(
//                    color: Color(0xFF082130),
//                    fontSize: 18.0,
//                    fontWeight: FontWeight.normal,
//                    fontFamily: 'Noto Sans'
//                ),),
//                leading: Image.asset( "images/changepassword.png", height: 25,),
//                selectedTileColor:Colors.black,
//                onTap: () {
//                  setState(() {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          changepass(
//                            userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid,previouspage: 'sellerdashboard',
//
//                          )),
//                    );
//
//
//                  });
//                },
//              ),
//
//              ListTile(
//                title: Text("Logout",style: const TextStyle(
//                    color: Color(0xFF082130),
//                    fontSize: 18.0,
//                    fontWeight: FontWeight.normal,
//                    fontFamily: 'Noto Sans'
//                ),),
//                leading: Image.asset( "images/logout.png", height: 25,),
//                selectedTileColor:Colors.black,
//                onTap: () {
//                  setState(() {
//                    _handleLogout();
//                  });
//                },
//              ),
//
//
//
//
//              Container(
//                height: 200,
//              )
//
//
//
//            ],
//          ),
//        ),


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
                child: Text('Product Details',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.left,),
              )
            ],
          ),
          backgroundColor: Colors.white,
          leading: GestureDetector(
            child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
            onTap: () {


              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    sellerdashbaord(
                        userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

                    )),
              );

            } ,
          ) ,
        ),
        body:




        LoadingOverlay(
          child:



          Container(

            child:
            Expanded(
              child:
            SingleChildScrollView(
              child:
              Column(

                children: <Widget>[









                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 0, bottom: 0),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                            padding: const EdgeInsets.only(
                                left:15.0, right: 15.0, top: 5, bottom: 0),
                            child:

                            Container(
                              height: 100,
                              child: Row(

                                children: [
                                  Expanded(
                                    flex: 3,
                                    child:
                                    Container(
                                      child:  Image.asset('images/norecord.png',),

                                    ),
                                  ),
                                  Expanded(
                                    flex: 7,
                                    child:

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left:15.0, right: 0.0, top: 10, bottom: 0),
                                      child:

                                      Container(
                                        child: Column(

                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('AVISIND, CB',style: TextStyle(fontSize: 18,color: Color(0xFF4689F6), fontWeight: FontWeight.bold,),),

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left:15.0, right: 0.0, top: 5, bottom: 0),
                                              child:
                                              Row(
                                                children: [

                                                  Icon(Icons.location_on),
                                                  Text('Cirebon'+', ',style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,),),
                                                  Text('Indoasia',style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,),),

                                                ],
                                              ),
                                            ),

                                            Row(
                                              children: [

                                                Text('Categories: '+', ',style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                                                Text('Indoasia',style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),

                                              ],
                                            ),

                                          ],
                                        ),

                                      ),
                                    ),

                                  ),

                                ],
                              ),

                            )



                        ),


                        Padding(
                            padding: const EdgeInsets.only(
                                left:15.0, right: 15.0, top: 5, bottom: 0),
                            child:
                            Container(
                              height: 50,
                              child:

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Icon(Icons.account_circle),
                                  Text('Seller Profile',style: TextStyle(fontSize: 18,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,),),


                                ],
                              ),


                            )
                        ),



                        Padding(
                          padding: const EdgeInsets.only(
                              left:5.0, right: 1.0, top: 10, bottom: 0),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 70,
                                width: 120,
                                child:  Text("Business Type:"),
                              ),
                              Expanded(
                                child: Text("Baths, Washbasins, Lavatory Seats etc of Plastics,Basketwork, Wickerwork ",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                              ),
                            ],
                          ),




                        ),



                        Padding(
                          padding: const EdgeInsets.only(
                              left:5.0, right: 1.0, top: 10, bottom: 0),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left:5.0, right: 1.0, top: 0, bottom: 0),
                                child:
                                SizedBox(
                                  height: 20,
                                  width: 120,
                                  child:  Text("Employee Count: "),
                                ),
                              ),

                              Expanded(
                                child: Text("2000 "),
                              ),
                            ],
                          ),




                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left:5.0, right: 1.0, top: 10, bottom: 0),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left:5.0, right: 1.0, top: 0, bottom: 0),
                                child:
                                SizedBox(
                                  height: 20,
                                  width: 120,
                                  child:  Text("Working Days: "),
                                ),
                              ),
                              Expanded(
                                child: Text("TMon-Tru"),
                              ),
                            ],
                          ),




                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left:5.0, right: 1.0, top: 10, bottom: 0),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left:5.0, right: 1.0, top: 0, bottom: 0),
                                child:
                                SizedBox(
                                  height: 20,
                                  width: 120,
                                  child:  Text("Working Hours: "),
                                ),
                              ),
                              Expanded(
                                child: Text("9 am 9 pm"),
                              ),
                            ],
                          ),




                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left:5.0, right: 1.0, top: 10, bottom: 0),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left:5.0, right: 1.0, top: 0, bottom: 0),
                                child:
                                SizedBox(
                                  height: 20,
                                  width: 120,
                                  child:  Text("Contact Number: "),
                                ),
                              ),
                              Expanded(
                                  child:

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[

                                      Icon(Icons.call),
                                      Text('+9861258798')
                                    ],
                                  )

                              ),
                            ],
                          ),




                        ),


                        Padding(
                            padding: const EdgeInsets.only(
                                left:15.0, right: 15.0, top: 5, bottom: 0),
                            child:
                            Container(
                              height: 50,
                              child:

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Icon(Icons.work),
                                  Text('Products & Services',style: TextStyle(fontSize: 18,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,),),


                                ],
                              ),


                            )
                        ),


//                        Padding(
//                          padding: const EdgeInsets.only(
//                              left:15.0, right: 15.0, top: 5, bottom: 0),
//                          child:
//                          GridView.count(
//                              shrinkWrap: true,
//                              crossAxisCount: 2,
//                              physics: NeverScrollableScrollPhysics(),
//                              crossAxisSpacing: 4.0,
//                              mainAxisSpacing: 8.0,
//                              children:
//                              List.generate(images.length, (index) {
//                                return Center(
//                                  child: Image.asset(images[index]),
//                                );
//                              }
//                              )
//                          ),
//
//                        ),


//              GridView.builder(
//                itemCount: images.length,
//                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                  crossAxisCount: 3,
//                  crossAxisSpacing: 5.0,
//                  mainAxisSpacing: 5.0,
//
//                ),
//                physics: NeverScrollableScrollPhysics(),
//                itemBuilder: (BuildContext context, int index) {
//                  return Image.asset(images[index]);
//                },
//              ),




                        FutureBuilder<List<Studentdata>>(
                          future: fetchStudents2(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return new Padding(
                                padding: new EdgeInsets.all(10.0),
                                child: GridView.builder(
                                  itemCount: snapshot.data.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                                  itemBuilder: (BuildContext context, int index) {
                                    return new

                                    // Text('c');
                                    GestureDetector(
                                        child: Cell(snapshot.data[index]),
                                        onTap: () => {}
                                      //gridClicked(index),
                                    );
                                  },
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text('CONSTANTS.INTERNET_ERROR');
                            }
                          },
                        ),















                        Padding(
                            padding: const EdgeInsets.only(
                                left:15.0, right: 15.0, top: 5, bottom: 0),
                            child:
                            Container(
                              height: 50,
                              child:

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Icon(Icons.markunread),
                                  Text('Contact Details',style: TextStyle(fontSize: 18,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,),),


                                ],
                              ),


                            )
                        ),



                        Padding(
                            padding: const EdgeInsets.only(
                                left:15.0, right: 15.0, top: 5, bottom: 0),
                            child: Container(

                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("VERSAGUNA INTERNATION,PT",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                                  Text("Mt. Yametr",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                                  Text("+625587855",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                                  Text("gdhgddhh@gmail.com",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                                  Text("address",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),

                                ],
                              ),
                            )

                        ),



                        Padding(
                          padding: const EdgeInsets.only(
                              left:15.0, right: 15.0, top: 15, bottom: 10),
                          child: Text("Categories",style: TextStyle(fontSize: 15,color: Color(0xFFEF5545), fontWeight: FontWeight.normal,),),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left:15.0, right: 15.0, top: 5, bottom: 0),
                            child: Container(

                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Glycerine",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                                  Text("Indonesian",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                                  Text("Exports",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                                  Text("Palm Oil",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                                  Text("Rubber",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                                  Text("Soap Noodles",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                                ],
                              ),
                            )

                        ),

                        Padding(
                            padding: const EdgeInsets.only(
                                left:15.0, right: 15.0, top: 5, bottom: 0),
                            child:
                            Container(
                              color: Colors.black,
                              width: double.infinity,
                              height: 40,
                              child:


                              Padding(
                                padding: const EdgeInsets.only(
                                    left:15.0, right: 10.0, top: 10, bottom: 0),
                                child:

                                Text('INQUIRE DIRECTLY WITH SUPPLIER',style: TextStyle(fontSize: 15,color: Color(0xFFffffff), fontWeight: FontWeight.normal,),),

                              ),


                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left:15.0, right: 15.0, top: 15, bottom: 10),
                          child: Text("VERSAGUNA INTERNATIONAL",style: TextStyle(fontSize: 15,color: Color(0xFF000000), fontWeight: FontWeight.normal,),),
                        ),


                        Align(
                          alignment: Alignment.topLeft,
                          child:
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 15.0, top: 10, bottom: 0),

                            child:
                            Text('Describe your buying requirement', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                          ),

                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 5, bottom: 0),
                            child:
                            Container(
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.all(2),


                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color(0xFF072331), // Set border color
                                    width: 1.0),   // Set border width
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5.0)), // Set rounded corner radius
                                //  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                              ),
                              child:
                              SizedBox(
                                height:100.0,

                                child:

                                Container(
                                  color: Color(0xFFffffff),
                                  child:
                                  TextFormField(
                                    controller: about,
                                    keyboardType: TextInputType.text,
                                    style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),//Enter content color and font size
                                    obscureText: false,
//                                                        decoration: InputDecoration(
//                                                          filled: true,
//
//                                                          hintText: '10 Digit Mobile Number',
//                                                          hintStyle: TextStyle(color: Color(0xFFE6E9EB),fontSize: 20.0,fontWeight: FontWeight.bold),
//
//                                                        ),

                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor:Color(0xFFffffff),
                                      hintText: 'Please include product name,order quantity,usage,special requests if any in your inquiry.',
                                      hintMaxLines: 3,
                                      hintStyle: TextStyle(color: Color(0xFFC3C9CD),fontSize: 14.0,fontWeight: FontWeight.normal),
                                      //                                  enabledBorder: OutlineInputBorder(
                                      //                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                      //                                    borderSide: BorderSide(color: Colors.blue, width: 1),
                                    ),

//                                validator: MultiValidator([
//                                  RequiredValidator(errorText: "* Required"),
//
//
//                                ])
                                    //validatePassword,        //Function to check validation
                                  ),
                                ),



//                                          InternationalPhoneNumberInput(
//                                            onInputChanged: (PhoneNumber number) {
//                                              print(number.phoneNumber);
//                                            },
//                                            onInputValidated: (bool value) {
//                                              print(value);
//                                            },
//                                            selectorConfig: SelectorConfig(
//                                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//                                            ),
//                                            ignoreBlank: false,
//                                            autoValidateMode: AutovalidateMode.disabled,
//                                            selectorTextStyle: TextStyle(color: Colors.black),
//                                            initialValue: number,
//                                            textFieldController: userid,
//                                            formatInput: false,
//                                            keyboardType:
//                                            TextInputType.numberWithOptions(signed: true, decimal: true),
//                                            inputBorder: OutlineInputBorder(),
//                                            onSaved: (PhoneNumber number) {
//                                              print('On Saved: $number');
//                                            },
//                                          ),



                              ),
                            )

                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 5, bottom: 0),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left:5.0, right: 1.0, top: 0, bottom: 0),
                                child:
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child:    Checkbox(value: rememberMe,  onChanged: _onRememberMeChanged),
                                ),
                              ),
                              Expanded(
                                  child:


                                  Text('Send this enquiry to other Suppliers or Similar products(?)')


                              ),
                            ],
                          ),

                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child:
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 15.0, top: 10, bottom: 0),


                            child:
                            Text('Mobile', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                          ),

                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 5, bottom: 0),
                            child:
                            Container(
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.all(8),


                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color(0xFF072331), // Set border color
                                    width: 1.0),   // Set border width
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)), // Set rounded corner radius
                                //  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                              ),
                              child:
                              SizedBox(
                                height: 33.0,

                                child:

                                Container(
                                  color: Color(0xFFffffff),
                                  child:
                                  TextFormField(
                                    controller: mobile,
                                    keyboardType: TextInputType.text,
                                    style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),//Enter content color and font size
                                    obscureText: false,
//                                                        decoration: InputDecoration(
//                                                          filled: true,
//
//                                                          hintText: '10 Digit Mobile Number',
//                                                          hintStyle: TextStyle(color: Color(0xFFE6E9EB),fontSize: 20.0,fontWeight: FontWeight.bold),
//
//                                                        ),

                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor:Color(0xFFffffff),
                                      hintText: ' Mobile',
                                      hintStyle: TextStyle(color: Color(0xFFC3C9CD),fontSize: 15.0,fontWeight: FontWeight.normal),
                                      //                                  enabledBorder: OutlineInputBorder(
                                      //                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                      //                                    borderSide: BorderSide(color: Colors.blue, width: 1),
                                    ),

//                                validator: MultiValidator([
//                                  RequiredValidator(errorText: "* Required"),
//
//
//                                ])
                                    //validatePassword,        //Function to check validation
                                  ),
                                ),



//                                          InternationalPhoneNumberInput(
//                                            onInputChanged: (PhoneNumber number) {
//                                              print(number.phoneNumber);
//                                            },
//                                            onInputValidated: (bool value) {
//                                              print(value);
//                                            },
//                                            selectorConfig: SelectorConfig(
//                                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//                                            ),
//                                            ignoreBlank: false,
//                                            autoValidateMode: AutovalidateMode.disabled,
//                                            selectorTextStyle: TextStyle(color: Colors.black),
//                                            initialValue: number,
//                                            textFieldController: userid,
//                                            formatInput: false,
//                                            keyboardType:
//                                            TextInputType.numberWithOptions(signed: true, decimal: true),
//                                            inputBorder: OutlineInputBorder(),
//                                            onSaved: (PhoneNumber number) {
//                                              print('On Saved: $number');
//                                            },
//                                          ),



                              ),
                            )

                        ),

                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 5, bottom: 0),
                            child:
                            Container(
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.all(8),


                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color(0xFF072331), // Set border color
                                    width: 1.0),   // Set border width
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)), // Set rounded corner radius
                                //  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                              ),
                              child:
                              SizedBox(
                                height: 33.0,

                                child:

                                Container(
                                  color: Color(0xFFffffff),
                                  child:
                                  TextFormField(
                                    controller: commodityname,
                                    keyboardType: TextInputType.text,
                                    style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),//Enter content color and font size
                                    obscureText: false,
//                                                        decoration: InputDecoration(
//                                                          filled: true,
//
//                                                          hintText: '10 Digit Mobile Number',
//                                                          hintStyle: TextStyle(color: Color(0xFFE6E9EB),fontSize: 20.0,fontWeight: FontWeight.bold),
//
//                                                        ),

                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor:Color(0xFFffffff),
                                      hintText: 'Commodity Name',
                                      hintStyle: TextStyle(color: Color(0xFFC3C9CD),fontSize: 15.0,fontWeight: FontWeight.normal),
                                      //                                  enabledBorder: OutlineInputBorder(
                                      //                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                      //                                    borderSide: BorderSide(color: Colors.blue, width: 1),
                                    ),

//                                validator: MultiValidator([
//                                  RequiredValidator(errorText: "* Required"),
//
//
//                                ])
                                    //validatePassword,        //Function to check validation
                                  ),
                                ),



//                                          InternationalPhoneNumberInput(
//                                            onInputChanged: (PhoneNumber number) {
//                                              print(number.phoneNumber);
//                                            },
//                                            onInputValidated: (bool value) {
//                                              print(value);
//                                            },
//                                            selectorConfig: SelectorConfig(
//                                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//                                            ),
//                                            ignoreBlank: false,
//                                            autoValidateMode: AutovalidateMode.disabled,
//                                            selectorTextStyle: TextStyle(color: Colors.black),
//                                            initialValue: number,
//                                            textFieldController: userid,
//                                            formatInput: false,
//                                            keyboardType:
//                                            TextInputType.numberWithOptions(signed: true, decimal: true),
//                                            inputBorder: OutlineInputBorder(),
//                                            onSaved: (PhoneNumber number) {
//                                              print('On Saved: $number');
//                                            },
//                                          ),



                              ),
                            )

                        ),

                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 5, bottom: 0),
                            child:
                            Container(
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.all(8),


                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color(0xFF072331), // Set border color
                                    width: 1.0),   // Set border width
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)), // Set rounded corner radius
                                //  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                              ),
                              child:
                              SizedBox(
                                height: 33.0,

                                child:

                                Container(
                                  color: Color(0xFFffffff),
                                  child:
                                  TextFormField(
                                    controller: hscode,
                                    keyboardType: TextInputType.text,
                                    style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),//Enter content color and font size
                                    obscureText: false,
//                                                        decoration: InputDecoration(
//                                                          filled: true,
//
//                                                          hintText: '10 Digit Mobile Number',
//                                                          hintStyle: TextStyle(color: Color(0xFFE6E9EB),fontSize: 20.0,fontWeight: FontWeight.bold),
//
//                                                        ),

                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor:Color(0xFFffffff),
                                      hintText: 'Hs Code',
                                      hintStyle: TextStyle(color: Color(0xFFC3C9CD),fontSize: 15.0,fontWeight: FontWeight.normal),
                                      //                                  enabledBorder: OutlineInputBorder(
                                      //                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                      //                                    borderSide: BorderSide(color: Colors.blue, width: 1),
                                    ),

//                                validator: MultiValidator([
//                                  RequiredValidator(errorText: "* Required"),
//
//
//                                ])
                                    //validatePassword,        //Function to check validation
                                  ),
                                ),



//                                          InternationalPhoneNumberInput(
//                                            onInputChanged: (PhoneNumber number) {
//                                              print(number.phoneNumber);
//                                            },
//                                            onInputValidated: (bool value) {
//                                              print(value);
//                                            },
//                                            selectorConfig: SelectorConfig(
//                                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//                                            ),
//                                            ignoreBlank: false,
//                                            autoValidateMode: AutovalidateMode.disabled,
//                                            selectorTextStyle: TextStyle(color: Colors.black),
//                                            initialValue: number,
//                                            textFieldController: userid,
//                                            formatInput: false,
//                                            keyboardType:
//                                            TextInputType.numberWithOptions(signed: true, decimal: true),
//                                            inputBorder: OutlineInputBorder(),
//                                            onSaved: (PhoneNumber number) {
//                                              print('On Saved: $number');
//                                            },
//                                          ),



                              ),
                            )

                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 5, bottom: 0),
                            child:
                            Container(
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.all(8),


                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color(0xFF072331), // Set border color
                                    width: 1.0),   // Set border width
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10.0)), // Set rounded corner radius
                                //  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                              ),
                              child:
                              SizedBox(
                                height: 33.0,

                                child:

                                Container(
                                  color: Color(0xFFffffff),
                                  child:
                                  TextFormField(
                                    controller: quantity,
                                    keyboardType: TextInputType.text,
                                    style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),//Enter content color and font size
                                    obscureText: false,
//                                                        decoration: InputDecoration(
//                                                          filled: true,
//
//                                                          hintText: '10 Digit Mobile Number',
//                                                          hintStyle: TextStyle(color: Color(0xFFE6E9EB),fontSize: 20.0,fontWeight: FontWeight.bold),
//
//                                                        ),

                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      filled: true,
                                      fillColor:Color(0xFFffffff),
                                      hintText: 'Quantity',
                                      hintStyle: TextStyle(color: Color(0xFFC3C9CD),fontSize: 15.0,fontWeight: FontWeight.normal),
                                      //                                  enabledBorder: OutlineInputBorder(
                                      //                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                      //                                    borderSide: BorderSide(color: Colors.blue, width: 1),
                                    ),

//                                validator: MultiValidator([
//                                  RequiredValidator(errorText: "* Required"),
//
//
//                                ])
                                    //validatePassword,        //Function to check validation
                                  ),
                                ),



//                                          InternationalPhoneNumberInput(
//                                            onInputChanged: (PhoneNumber number) {
//                                              print(number.phoneNumber);
//                                            },
//                                            onInputValidated: (bool value) {
//                                              print(value);
//                                            },
//                                            selectorConfig: SelectorConfig(
//                                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//                                            ),
//                                            ignoreBlank: false,
//                                            autoValidateMode: AutovalidateMode.disabled,
//                                            selectorTextStyle: TextStyle(color: Colors.black),
//                                            initialValue: number,
//                                            textFieldController: userid,
//                                            formatInput: false,
//                                            keyboardType:
//                                            TextInputType.numberWithOptions(signed: true, decimal: true),
//                                            inputBorder: OutlineInputBorder(),
//                                            onSaved: (PhoneNumber number) {
//                                              print('On Saved: $number');
//                                            },
//                                          ),



                              ),
                            )

                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10, bottom: 0),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left:5.0, right: 1.0, top: 0, bottom: 0),
                                child:
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child:    Checkbox(value: rememberMe2,  onChanged: _onRememberMeChanged2),
                                ),
                              ),
                              Expanded(
                                  child:


                                  Text('I agree to the Terms and Conditions')


                              ),
                            ],
                          ),

                        ),



                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 10, bottom: 0),
                            child:Text('User Disclaimer:',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal, color: Color(0xFF868686),  fontFamily: 'Noto Sans')
                              ,)),

                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 10, bottom: 0),
                            child:Text('Before Proceeding with any kind of business transactions/signing of contract with any of the listed companies in this platform, we request you to intimate our office in advance. Write us:inquiry@itpcchennai.com ',textAlign: TextAlign.left, style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal, color: Color(0xFF868686),  fontFamily: 'Noto Sans')
                              ,)),

                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 50, bottom: 50),
                            child:
                            Center(
                              child: ButtonTheme(
                                height: 30.0,
                                minWidth: 150,
                                child:
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(5.0),


                                  ),
                                  onPressed: isEnabled ? ()=> login() : null,
                                  color:  Color(0xFFE9FF54),
                                  textColor: Colors.black,
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Text('Send Inquiry'),
                                ),
                              ),
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


          isLoading: _isLoading,
          // additional parameters
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
        ),



      );
  }



}


class Cell extends StatelessWidget {
  const Cell(this.catimg);
  @required
  final Studentdata catimg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: new Column(
          children: <Widget>[
            Image.network(catimg.image_prop,
                width: 130.0,
                height: 130.0,
                alignment: Alignment.center,
                fit: BoxFit.cover),
            Text(catimg.property_title),
          ],
        ),
      ),
    );
  }
}
