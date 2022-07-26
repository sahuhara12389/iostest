// @dart=2.9



import 'dart:io';
import 'dart:async';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itpcchennaiapp/about.dart';
import 'package:itpcchennaiapp/about_buyer.dart';
import 'package:itpcchennaiapp/buyerdashboard.dart';
import 'package:itpcchennaiapp/changepassword.dart';
import 'package:itpcchennaiapp/changepassword_buyer.dart';
import 'package:itpcchennaiapp/contact.dart';
import 'package:itpcchennaiapp/contact_buyer.dart';
import 'package:itpcchennaiapp/event_buyer.dart';
import 'package:itpcchennaiapp/eventsdetails.dart';
import 'package:itpcchennaiapp/exportnewindonesia_buyer.dart';
import 'package:itpcchennaiapp/exportnewsindonesia.dart';
import 'package:itpcchennaiapp/login.dart';
import 'package:itpcchennaiapp/marketbriefdetails.dart';
import 'package:itpcchennaiapp/marketbriefdtls_buyer.dart';
import 'package:itpcchennaiapp/myproduct.dart';
import 'package:itpcchennaiapp/myprofile.dart';
import 'package:itpcchennaiapp/myprofile_buyer.dart';
import 'package:itpcchennaiapp/sellerdashboard.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Studentdata {
  String id;
  String title;
  String link;
  String c_date;

  Studentdata({
    this.id,
    this.title,
    this.link,
    this.c_date,
  });

  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(
      id: json['id'],
      title: json['title'],
      link: json['link'],
      c_date: json['c_date'],
    );
  }
}


class Studentcategory {
  String name;

  Studentcategory({
    this.name,

  });

  factory Studentcategory.fromJson(Map<String, dynamic> json) {
    return Studentcategory(
      name: json['name'],
    );
  }
}

class marketbriefindia_buyer extends StatefulWidget {


  marketbriefindia_buyer({this.userid, this.Type, this.content, this.Name, this.signupid});

  var userid;
  var Type;
  var content;
  var Name;
  var signupid;

  @override

  UserFilterDemoState createState() => UserFilterDemoState();
}
class UserFilterDemoState extends State<marketbriefindia_buyer> {

  String signup_id;
  String signup_choose;
  String signup_img;
  String signup_img_1="http://ecorewick.com/moniespay_api/images/default_profile.png";
  String signup_img1;
  String signup_img1_1="http://ecorewick.com/moniespay_api/images/default_profile.png";


  String signup_pdf;
  String signup_pdf_1="http://ecorewick.com/moniespay_api/images/default_profile.png";

  String signup_pdf1;
  String signup_pdf1_1="http://ecorewick.com/moniespay_api/images/default_profile.png";
  String signup_pdf2;
  String signup_pdf2_1="http://ecorewick.com/moniespay_api/images/default_profile.png";

  String signup_gst_number;

  String signup_organation;
  String signup_name;
  String signup_email;
  String signup_mobile;
  String signup_city;
  String signup_country;

  String signup_address;
  String signup_count;
  String signup_establishment;
  String signup_wdays;
  String signup_whours;
  String signup_about;
  String signup_website;



  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController controller = new TextEditingController();

  final TextEditingController _controller = TextEditingController();

  final TextEditingController gstno = new TextEditingController();
  final TextEditingController organization = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  final TextEditingController address = new TextEditingController();
  final TextEditingController city = new TextEditingController();
  final TextEditingController country = new TextEditingController();
  final TextEditingController about = new TextEditingController();
  final TextEditingController website = new TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  File _image;
  File _image_organ;
  File _image_company;
  File _image_product;
  File _image_document;



  String selectedSpinnerItem = 'Banana';

  List _selecteCategorys = List();

  String category=",";


  List data = List();
  Future myFuture;

  bool _isLoading = false;
  bool isEnabled = true;

  int _searchtype = 0;

  List<String> ShoppingItems = ['Ball', 'Clet', 'JoyStick'];


  @override
  void initState() {

    super.initState();

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




  Future<List<Studentdata>> fetchStudents() async {


    print('SEARCH MARKET BRIEF');

    var request = http.MultipartRequest(
        'POST', Uri.parse('https://itpcchennai.com/web_api/public/report_india'));
    request.fields.addAll({

      'type': 'report_india'
    });
    print('3333');

    http.StreamedResponse response = await request.send();
    var decoded = await response.stream.bytesToString().then(json.decode);

    var usersData = decoded['data'];

    print('SEARCH MARKET BRIEF----1');
    print(decoded['data'].toString());
    //   var response = await http.post(Uri.parse(apiURL));

    if (response.statusCode == 200) {
      print('SEARCH MARKET BRIEF----2');
      print('000');
      final items = decoded['data'].cast<Map<String, dynamic>>();
      print('111');
      print('SEARCH MARKET BRIEF----4');
      List<Studentdata> studentList = items.map<Studentdata>((json) {
        return Studentdata.fromJson(json);
      }).toList();

      return studentList;
    }
    else {
      throw Exception('Failed to load data from Server.');
    }
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
        backgroundColor: Color(0xFFFAFAFA),
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
                          buyerdashbaord(
                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

                          )),
                    );




                  });
                },
              ),

              ListTile(
                title: Text("My Product",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/product.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          myproducts(
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
                          myprofile_buyer(
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
                          event_buyer(
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
                          marketbriefindia_buyer(
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
                          exportnewindonesia_buyer(
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
                          aboutus_buyer(
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
                          contactus_buyer(
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
                          changepass_buyer(
                            userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid,previouspage: 'buyerdashboard',

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

          backgroundColor: Color(0xFFECECEC),
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






                    Padding(
                      padding: const EdgeInsets.only(
                          left:15.0, right: 15.0, top: 15, bottom: 20),
                      child:
                      Text('Market Brief- India',style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Noto Sans'
                      ),),
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
                                    .map((data) =>




                                    Padding(
                                        padding: const EdgeInsets.only(
                                            left:10.0, right: 10.0, top: 0, bottom: 0),
                                        child:
                                        Card(
                                            child:
                                            ListTile(
                                              title:
                                              Container(
                                                child:

                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [


                                                    Row(

                                                      children: <Widget>[


                                                        Expanded(
                                                          flex: 10,
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

                                                                  Center(
                                                                    child:Text(data.title,style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),) ,

                                                                  ),





//                                                                  ReadMoreText(
//                                                                    data.link,
//                                                                    trimLines: 5,
//                                                                    textAlign: TextAlign.justify,
//                                                                    trimMode: TrimMode.Line,
//                                                                    trimCollapsedText: "  More ",
//                                                                    trimExpandedText: "  Less ",
//                                                                    lessStyle: TextStyle(
//                                                                      fontWeight: FontWeight.bold,
//                                                                      color: Color(0xFF9A9CA0),
//                                                                    ),
//                                                                    moreStyle: TextStyle(
//                                                                      fontWeight: FontWeight.bold,
//                                                                      color: Color(0xFF9A9CA0),
//                                                                    ),
//                                                                    style: TextStyle(
//                                                                      fontSize: 12,
//
//                                                                    ),
//                                                                  ),





                                                                ],),
                                                            ),

                                                          ),
                                                        ),
                                                      ],
                                                    ),





                                                  ],),


                                              ),


                                              onTap: () {

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) =>
                                                      marketbriefdtlsbuyer(
                                                        userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid,previouspage: data.id,Url: data.link,

                                                      )),
                                                );
                                              },


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
