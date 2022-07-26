// @dart=2.9



import 'dart:io';
import 'dart:async';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itpcchennaiapp/about.dart';
import 'package:itpcchennaiapp/changepassword.dart';
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

class contactus extends StatefulWidget {


  contactus({this.userid, this.Type, this.content, this.Name, this.signupid});

  var userid;
  var Type;
  var content;
  var Name;
  var signupid;

  @override

  UserFilterDemoState createState() => UserFilterDemoState();
}
class UserFilterDemoState extends State<contactus> {

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

  final TextEditingController name = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  final TextEditingController message = new TextEditingController();
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

  void submitinquery1() async {

    if(name.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter Name',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
    }

    else  if(email.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter Email',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
    }
    else  if(mobile.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter Mobile',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
    }
    else  if(message.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter message',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
    }


    else
    {

      submit();
    }
  }

  Future<List<dynamic>> submit() async {

    print('UPDATE');

    print(name.text);
    print(message.text);
    print(email.text);
    print(mobile);

    print('UPDATE');




    var request = http.MultipartRequest('POST', Uri.parse('https://itpcchennai.com/web_api/public/contactus_service'));
    request.fields.addAll({

      'name': name.text,
      'msg': message.text,
      'mail': email.text,
      'phone': mobile.text


    });


    http.StreamedResponse response = await request.send();


    print(response.statusCode);


    var decoded = await response.stream.bytesToString().then(json.decode);

    if (response.statusCode == 200) {



      Fluttertoast.showToast(
          msg: 'Submitted Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );


    }
    return List<Map<String, dynamic>>.from(json.decode(await response.stream.bytesToString()));

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
                        left: 5.0, right: 5.0, top: 0, bottom: 0),
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
                            Text('Contact us', style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                          ),

                        ),


                        Padding(
                            padding: const EdgeInsets.only(
                                left:5.0, right: 1.0, top: 0, bottom: 0),
                            child:

                            Row(
                              children: [

                                Expanded(
                                  flex: 1,
                                  child:Icon(
                                    Icons.location_on,
                                    color: Colors.greenAccent,
                                    size: 25.0,

                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: SizedBox(
                                    width: double.infinity,

                                    child: Text(
                                      "123/124, 3rd floor Ispahani Center Nungambakkam High Road, Chennai 600034",

                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,style:TextStyle(
                                      color: Color(0xFF000000),fontSize: 13.0,) ,

                                    ),
                                  ),

                                ),

                              ],)



                        ),


                        Padding(
                            padding: const EdgeInsets.only(
                                left:5.0, right: 1.0, top: 10, bottom: 0),
                            child:

                            Row(
                              children: [

                                Expanded(
                                  flex: 1,
                                  child:Icon(
                                    Icons.call,
                                    color: Colors.greenAccent,
                                    size: 25.0,

                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: SizedBox(
                                    width: double.infinity,

                                    child: Text(
                                      "+91-9962260037 \n +91-9962550037 ",

                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,style:TextStyle(
                                      color: Color(0xFF000000),fontSize: 13.0,) ,

                                    ),
                                  ),

                                ),

                              ],)



                        ),

                        Padding(
                            padding: const EdgeInsets.only(
                                left:5.0, right: 1.0, top: 10, bottom: 0),
                            child:

                            Row(
                              children: [

                                Expanded(
                                  flex: 1,
                                  child:Icon(
                                    Icons.email,
                                    color: Colors.greenAccent,
                                    size: 25.0,

                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: SizedBox(
                                    width: double.infinity,

                                    child: Text(
                                      "inquiry@itpcchennai.com ",

                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,style:TextStyle(
                                      color: Color(0xFF000000),fontSize: 13.0,) ,

                                    ),
                                  ),

                                ),

                              ],)



                        ),

                        Padding(
                            padding: const EdgeInsets.only(
                                left:5.0, right: 1.0, top: 10, bottom: 0),
                            child:

                            Row(
                              children: [

                                Expanded(
                                  flex: 1,
                                  child:Icon(
                                    Icons.event,
                                    color: Colors.greenAccent,
                                    size: 25.0,

                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: SizedBox(
                                    width: double.infinity,

                                    child: Text(
                                      "Office Working Days \n 09:30 AM to 06:00 PM / Monday to Friday",

                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,style:TextStyle(
                                      color: Color(0xFF000000),fontSize: 13.0,) ,

                                    ),
                                  ),

                                ),

                              ],)



                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child:
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, top: 10, bottom: 20),
                            child:
                            Text('Get in touch!', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                          ),

                        ),


                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 5, bottom: 10),
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
                                height: 30.0,

                                child:

                                Container(
                                  color: Color(0xFFffffff),
                                  child:
                                  TextFormField(
                                    controller: name,
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
                                      hintText: ' Name',
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
                                left: 20.0, right: 20.0, top: 5, bottom: 10),
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
                                height: 30.0,

                                child:

                                Container(
                                  color: Color(0xFFffffff),
                                  child:
                                  TextFormField(
                                    controller: email,
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
                                      hintText: ' Email',
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
                                left: 20.0, right: 20.0, top: 5, bottom: 10),
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
                                height: 30.0,

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
                                      hintText: ' Mobile Number',
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
                                height: 75.0,

                                child:

                                Container(
                                  color: Color(0xFFffffff),
                                  child:
                                  TextFormField(
                                    controller: message,
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
                                      hintText: 'Message',
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
                              left: 0.0, right: 0.0, top: 20, bottom: 0),
                          child:
                          Center(child:ButtonTheme(
                            height: 45.0,
                            minWidth: 150,
                            child:
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),


                              ),
                              onPressed: isEnabled ? ()=> submitinquery1() : null,
                              color:  Color(0xFF072331),
                              textColor: Colors.white,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Text('SUBMIT'),
                            ),
                          )),
                        ),



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
