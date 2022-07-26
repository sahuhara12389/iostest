// @dart=2.9



import 'dart:io';
import 'dart:async';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itpcchennaiapp/changepassword.dart';
import 'package:itpcchennaiapp/contact.dart';
import 'package:itpcchennaiapp/event.dart';
import 'package:itpcchennaiapp/eventsdetails.dart';
import 'package:itpcchennaiapp/exportnewsindonesia.dart';
import 'package:itpcchennaiapp/login.dart';
import 'package:itpcchennaiapp/marketbriefindia.dart';
import 'package:itpcchennaiapp/myprofile.dart';
import 'package:itpcchennaiapp/sellerdashboard.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Studentdata {
  String event_id;
  String category;
  String event_date;
  String event_title;
  String event_information;

  String image_prop;




  Studentdata({
    this.event_id,
    this.category,
    this.event_date,
    this.event_title,
    this.event_information,
    this.image_prop,



  });

  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(
      event_id: json['event_id'],
      category: json['category'],
      event_date: json['event_date'],
      event_title: json['event_title'],
      event_information: json['event_information'],

      image_prop: json['image_prop'],




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

class aboutus extends StatefulWidget {


  aboutus({this.userid, this.Type, this.content, this.Name, this.signupid});

  var userid;
  var Type;
  var content;
  var Name;
  var signupid;

  @override

  UserFilterDemoState createState() => UserFilterDemoState();
}
class UserFilterDemoState extends State<aboutus> {

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
            SingleChildScrollView(
              child:
              Stack(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 0, bottom: 0),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        SizedBox(
                          height: 40.0,
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child:
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 15.0, top: 0, bottom: 20),
                            child:
                            Text('About Us', style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                          ),

                        ),


                        Padding(
                          padding: const EdgeInsets.only(
                              left:5.0, right: 1.0, top: 0, bottom: 0),
                          child:
                          SizedBox(
                            width: double.infinity,

                            child: Text(
                              "Indonesian Trade Promotion Center(ITPC) Chennai,India is a Not-Profit Government Organization under the supervision of the Directorate General for National Export Development,Ministry of Trade of the Republic of Indonesia. Established in the year 2009, ITPC Chennai is well functioning to serve your requirements to do Trade with Indonesian and to enhance the export of Indonesian products through out india and to facilitate matchmaking  between Indonesian Sellers and Indian Buyers.",

                              maxLines: 12,
                              overflow: TextOverflow.ellipsis,style:TextStyle(
                              color: Color(0xFF000000),fontSize: 13.0,) ,

                            ),
                          ),



                        ),

                        Card(
                            elevation: 1,
                            child: Padding(
                              padding: EdgeInsets.all(7),
                              child: Stack(children: <Widget>[
                                Align(
                                  alignment: Alignment.centerRight,

                                  child: Stack(

                                    children: <Widget>[

                                      Center(
                                        child:Image.asset('images/vision.png',height: 70, width: 70,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0.0, right: 0.0, top: 80, bottom: 0),
                                        child:
                                        SizedBox(
                                          width: double.infinity,

                                          child: Text(
                                            "OUR VISION is to promote and improve trade between Indonesia-India and as well as to facilitate reliable connection between Indonesian Exporters(Seller) and Indian Importers(Buyer)",

                                            maxLines: 12,
                                            overflow: TextOverflow.ellipsis,style:TextStyle(
                                            color: Color(0xFF000000),fontSize: 13.0,) ,

                                          ),
                                        ),
                                      ),

                                    ],

                                  ),

                                ),
                              ],
                              ),
                            )
                        ),




                        Card(
                            elevation: 1,
                            child: Padding(
                              padding: EdgeInsets.all(7),
                              child: Stack(children: <Widget>[
                                Align(
                                  alignment: Alignment.centerRight,

                                  child: Stack(

                                    children: <Widget>[

                                      Center(
                                        child:Image.asset('images/mission.png',height: 70, width: 70,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0.0, right: 0.0, top: 80, bottom: 0),
                                        child:
                                        SizedBox(
                                          width: double.infinity,

                                          child: Text(
                                            "Our MISSION is to boost indonesian non-oil and gas export development to the Indian market through market penetration,information dissemination,trade inquiry services.",

                                            maxLines: 12,
                                            overflow: TextOverflow.ellipsis,style:TextStyle(
                                            color: Color(0xFF000000),fontSize: 13.0,) ,

                                          ),
                                        ),
                                      ),

                                    ],

                                  ),

                                ),
                              ],
                              ),
                            )
                        ),

                        Card(
                            elevation: 1,
                            child: Padding(
                              padding: EdgeInsets.all(7),
                              child: Stack(children: <Widget>[
                                Align(
                                  alignment: Alignment.centerRight,

                                  child: Stack(

                                    children: <Widget>[

                                      Center(
                                        child:Image.asset('images/ensure.png',height: 70, width: 70,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0.0, right: 0.0, top: 80, bottom: 0),
                                        child:
                                        SizedBox(
                                          width: double.infinity,

                                          child: Text(
                                            "Ensuring best of our services by building strong and good relations with all our clients and growing positively with our Vision and Mission in mind.",

                                            maxLines: 12,
                                            overflow: TextOverflow.ellipsis,style:TextStyle(
                                            color: Color(0xFF000000),fontSize: 13.0,) ,

                                          ),
                                        ),
                                      ),

                                    ],

                                  ),

                                ),
                              ],
                              ),
                            )
                        ),

                        Align(
                          alignment: Alignment.center,
                          child:
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 15.0, top: 5, bottom: 0),
                            child:
                            Text('Government Officials of ITPC Chennai', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                          ),

                        ),



                        Divider(),
                        Row(
                          children: [

                            Expanded(
                                flex: 2,
                                child:
                                Column(
                                  children: [
                                    Image.asset('images/kumara.png',height: 100, width: 100,),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 15.0, top: 0, bottom: 2),
                                      child:
                                      Text('Mr Kumara Jati ', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 15.0, top: 0, bottom: 20),
                                      child:
                                      Text('Director ', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                                    ),
                                  ],


                                )
                            ),

                            Expanded(
                                flex: 2,
                                child:
                                Column(
                                  children: [
                                    Image.asset('images/aji.jpg',height: 100, width: 100,),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 15.0, top: 0, bottom: 2),
                                      child:
                                      Text('Mr Aji Cahyadi ', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 15.0, top: 0, bottom: 20),
                                      child:
                                      Text('Deputy Director ', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                                    ),
                                  ],


                                )
                            ),


                          ],
                        )


                      ],
                    ),
                  ),

                ],
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
