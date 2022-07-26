// @dart=2.9



import 'dart:io';
import 'dart:async';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itpcchennaiapp/event_buyer.dart';
import 'package:itpcchennaiapp/sellerdashboard.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';

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

class eventdetails_buyer extends StatefulWidget {


  eventdetails_buyer({this.userid, this.Type, this.content, this.Name, this.signupid, this.eventid});

  var userid;
  var Type;
  var content;
  var Name;
  var signupid;
  var eventid;

  @override

  UserFilterDemoState createState() => UserFilterDemoState();
}
class UserFilterDemoState extends State<eventdetails_buyer> {

  String pagetitle;

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



  @override
  void initState() {

    if(widget.eventid=="1")
    {
      pagetitle="Events in Indonesia";
    }
    else if(widget.eventid=="2")
    {
      pagetitle="Events in India";
    }
    else
    {
      pagetitle="Events in ITPC";
    }

    events();
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




  Future<List<Studentdata>> events() async {


    print('SEARCH---1');
    print(widget.eventid);
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://itpcchennai.com/web_api/public/get_event'));
    request.fields.addAll({

      'Start': '0',
      'limit': '200',
      'event_category': widget.eventid
    });
    print('SEARCH---2');

    http.StreamedResponse response = await request.send();
    var decoded = await response.stream.bytesToString().then(json.decode);
    print('SEARCH---3');

    var usersData = decoded['data'];
    print(response.statusCode);
    print('SEARCH---4');
    print(decoded['data'].toString());
    //   var response = await http.post(Uri.parse(apiURL));

    if (response.statusCode == 200) {

      print('SEARCH---5');

      final items = decoded['data'].cast<Map<String, dynamic>>();
      print('SEARCH---6');
      print(items.toString());
      print('SEARCH---7');
      List<Studentdata> studentList = items.map<Studentdata>((json) {
        return Studentdata.fromJson(json);
      }).toList();

      return studentList;
    }
    else {
      throw Exception('Failed to load data from Server.');
    }
  }



  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        //  drawer:

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
//
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          sellerdashbaord(
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
//                title: Text("My Product",style: const TextStyle(
//                    color: Color(0xFF082130),
//                    fontSize: 18.0,
//                    fontWeight: FontWeight.normal,
//                    fontFamily: 'Noto Sans'
//                ),),
//                leading: Image.asset( "images/product.png", height: 25,),
//                selectedTileColor:Colors.black,
//                onTap: () {
//                  setState(() {
//
//                  });
//                },
//              ),
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
//
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
//
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
//
//                  });
//                },
//              ),
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


//        appBar:
//        AppBar(
//          centerTitle: false,
//          title:
//          Row(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//
//
//              Padding(
//                padding: const EdgeInsets.only(
//                    left: 25.0, right: 0.0, top: 10, bottom: 0),
//                child: Text(pagetitle,
//                  style: TextStyle(fontSize: 20, color: Colors.black),
//                  textAlign: TextAlign.left,),
//              )
//            ],
//          ),
//
//          iconTheme: IconThemeData(
//            color: Colors.black,
//          ),
//
//
//          backgroundColor: Color(0xFFECECEC),
//          flexibleSpace: Container(
//            decoration: BoxDecoration(
////              gradient: LinearGradient(
////                  begin: Alignment.topLeft,
////                  end: Alignment.bottomRight,
////                  colors: <Color>[
////                    Color(0xFF4F97FB).withOpacity(1),
////                    Color(0xFF5564F8).withOpacity(1)
////                  ])
//            ),
//          ),
//
//
//          elevation: 0.0,
//
//          actions: <Widget>[
//          ],
//        ),

        appBar: AppBar(
          title: Text(pagetitle,style: TextStyle(fontSize: 18, color: Colors.black),
            textAlign: TextAlign.left,),
          backgroundColor: Color(0xFFffffff),
          automaticallyImplyLeading: false,
//          leading: new IconButton(
//            icon: new Icon(Icons.arrow_back, color: Colors.black),
//            onPressed: () => Navigator.of(context).pop(),
//          ),

          leading: GestureDetector(
            child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
            onTap: () {


              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    event_buyer(
                        userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

                    )),
              );

            } ,
          ) ,

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
              FutureBuilder<List<Studentdata>>(
                future: events(),
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
                                      left:5.0, right: 5.0, top: 0, bottom: 0),
                                  child:

                                  ListTile(
                                      title:







                                      Container(
                                        margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),

                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15)
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.6),
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              offset: Offset(0, 1),
                                            ),
                                          ],
                                        ),


                                        child:

                                        Container(

                                          child:

                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [



                                              ClipRRect(
                                                  borderRadius: const BorderRadius.only(
                                                    topLeft: const Radius.circular(15.0),
                                                    topRight: const Radius.circular(15.0),
                                                  ),
                                                  child: new Image.network(data.image_prop)

                                              ),



                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left:5.0, right: 5.0, top: 10, bottom: 0),
                                                child:
                                                Text('Date:  '+data.event_date,style: const TextStyle(
                                                    color: Color(0xFF082130),
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: 'Noto Sans'
                                                ),),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left:5.0, right: 1.0, top: 0, bottom: 0),
                                                child:
                                                SizedBox(
                                                  width: double.infinity,

                                                  child: Text(
                                                    data.event_title,

                                                    maxLines: 3,
                                                    overflow: TextOverflow.ellipsis,style:TextStyle(
                                                    color: Color(0xFFC28B28),fontSize: 15.0,) ,

                                                  ),
                                                ),



                                              ),

                                              SizedBox(
                                                height: 10.0,
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left:5.0, right: 5.0, top: 0, bottom: 30),
                                                child:

                                                ReadMoreText(
                                                  data.event_information,
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
                                              ),




                                            ],),


                                        ),


                                      )






                                  )

                              )

                          )
                              .toList(),
                        )

                    );
                },
              )

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
