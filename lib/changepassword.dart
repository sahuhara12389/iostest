// @dart=2.9
import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itpcchennaiapp/about.dart';
import 'package:itpcchennaiapp/buyerdashboard.dart';
import 'package:itpcchennaiapp/contact.dart';
import 'package:itpcchennaiapp/dashboard.dart';
import 'package:itpcchennaiapp/event.dart';
import 'package:itpcchennaiapp/listmore.dart';
import 'package:itpcchennaiapp/listmore2.dart';
//import 'package:realhappyindiaapp/drop.dart';
//import 'package:realhappyindiaapp/dropdown.dart';
import 'package:itpcchennaiapp/loader.dart';
import 'package:itpcchennaiapp/marketbriefindia.dart';
import 'package:itpcchennaiapp/myprofile.dart';
import 'package:itpcchennaiapp/productdetails.dart';
import 'package:itpcchennaiapp/sellerdashboard.dart';
import 'package:itpcchennaiapp/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:itpcchennaiapp/test.dart';
import 'package:passcode_screen/circle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';


String contype="";
String _title;
String _description;
String storedPasscode = '';
String token="";
String board, brand, device, hardware, host, id, manufacture, model, product, type, androidid;
String BBPSAGENTID="";

class changepass extends StatefulWidget {


  changepass({this.userid, this.Type, this.content, this.Name, this.signupid, this.previouspage});

  var userid;
  var Type;
  var content;
  var Name;
  var signupid;
  var previouspage;


  @override
  _LoginFormValidationState createState() => _LoginFormValidationState();
}

class _LoginFormValidationState extends State<changepass> {

  final Connectivity _connectivity = Connectivity();
  StreamSubscription< ConnectivityResult > _connectivitySubscription;



  DeviceInfoPlugin deviceInfo =
  DeviceInfoPlugin(); // instantiate device info plugin
  AndroidDeviceInfo androidDeviceInfo;


  bool isphysicaldevice;





  bool _isLoading = false;
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  Future<bool> _onBackPressed(){


    if(widget.previouspage=="aboutus")
    {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            aboutus(
                userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

            )),
      );
    }
    else if(widget.previouspage=="sellerdashboard")
    {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            sellerdashbaord(
                userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

            )),
      );
    }
    else if(widget.previouspage=="contact")
    {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            contactus(
                userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

            )),
      );
    }
    else if(widget.previouspage=="event")
    {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            event(
                userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

            )),
      );
    }
    else if(widget.previouspage=="marketbriefindia")
    {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            marketbriefindia(
                userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

            )),
      );
    }
    else if(widget.previouspage=="myprofile")
    {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            myprofile(
                userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

            )),
      );
    }
    else if(widget.previouspage=="productdetails")
    {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            productdetails(
                userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

            )),
      );
    }


    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => mycustompage()),
//    );
  }

  Future<bool> onWillPop() async {

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  // Navigator.of(context).pop(true);

                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else {
                    if (Platform.isIOS) {
                      exit(0);
                    }
                  }


                },
              ),
            ],
          );
        });
    return true;
  }







//  Future<bool>  _onBackPressed() {
//
//
//     showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return AlertDialog(
//            title: Text('Are you sure?'),
//            content: Text('You are going to exit the application!!'),
//            actions: <Widget>[
//              FlatButton(
//                child: Text('NO'),
//                onPressed: () {
//                  Navigator.of(context).pop(false);
//                },
//              ),
//              FlatButton(
//                child: Text('YES'),
//                onPressed: () {
//                  // Navigator.of(context).pop(true);
//
//                  if (Platform.isAndroid) {
//                    SystemNavigator.pop();
//                  } else {
//                    if (Platform.isIOS) {
//                      exit(0);
//                    }
//                  }
//
//
//                },
//              ),
//            ],
//          );
//        });
//
//  }


  GlobalKey<FormState> formkey = GlobalKey<FormState>();


  final TextEditingController oldpass = new TextEditingController();
  final TextEditingController newpassword = new TextEditingController();
  final TextEditingController confirmpassword = new TextEditingController();



  bool _isObscure = true;
  bool visible = false ;




  bool isEnabled = true ;
  enableButton(){

    setState(() {
      isEnabled = true;
    });
  }
  disableButton(){

    setState(() {
      isEnabled = false;
    });
  }


  final StreamController<bool> _verificationNotifier = StreamController<bool>.broadcast();
  bool isAuthenticated = false;
  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  loadProgress(){

    if(visible == true){
      setState(() {
        visible = false;
      });
    }
    else{
      setState(() {
        visible = true;
      });
    }
  }



  @override
  void initState() {

    try {

    } catch (e) {
      print(e);
    }





    super.initState();





  }




  String validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 0) {
      return "Password should be atleast 1 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return null;
  }

  void _doregister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          signup()
      ),
    );
  }







  void submitinquery1() async {

    if(oldpass.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter Old Password',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
    }

    else  if(newpassword.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter New Password',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
    }
    else  if(confirmpassword.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter Confirm Password',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
    }



    else
    {

      update();
    }
  }




  Future<List<dynamic>> update() async {

    print(oldpass.text);
    print(newpassword.toString());

    print('///////**////////');


    var request = http.MultipartRequest('POST', Uri.parse('https://itpcchennai.com/web_api/public/change_password'));
    request.fields.addAll({
      'id': widget.signupid,
      'password': newpassword.text,
      'oldPassword': oldpass.text
    });


    http.StreamedResponse response = await request.send();


    print(response.statusCode);


    var decoded = await response.stream.bytesToString().then(json.decode);

    if (response.statusCode == 200) {

      Fluttertoast.showToast(
          msg: 'Updated Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );

      oldpass.text="";
      newpassword.text="";


    }
    return List<Map<String, dynamic>>.from(json.decode(await response.stream.bytesToString()));

  }






  Widget build(BuildContext context){
    return WillPopScope(
        onWillPop: _onBackPressed,
        child:



        Scaffold(

          //backgroundColor: Colors.white,
          backgroundColor: Color(0xFFFAFAFA),




          body:
          Stack(
            children: <Widget>[

              WillPopScope(
                // onWillPop: _onBackPressed,
                onWillPop: () async => false,
                child:
                SingleChildScrollView(
                  child: Form(
                    autovalidate: true, //check for validation while typing
                    key: formkey,
                    child:








                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[


                        Align(
                          alignment: Alignment.topLeft,
                          child:
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 0),
                            child:
                            Image.asset('images/logo.png',),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topCenter,
                          child:
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 30, bottom: 0),
                            child:
                            Text('Change Password', style: TextStyle(fontSize: 25,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                          ),

                        ),


                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20, bottom: 10),
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
                                    controller: oldpass,
                                    keyboardType: TextInputType.text,
                                    style: new TextStyle(color: Colors.black,fontSize: 14.0,fontWeight: FontWeight.bold),//Enter content color and font size
                                    obscureText: true,
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
                                      hintText: 'Old Password',
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
                                left: 20.0, right: 20.0, top: 10, bottom: 10),
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
                                    controller: newpassword,
                                    keyboardType: TextInputType.text,
                                    style: new TextStyle(color: Colors.black,fontSize: 14.0,fontWeight: FontWeight.bold),//Enter content color and font size
                                    obscureText: true,
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
                                      hintText: 'New Password',
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
                                left: 20.0, right: 20.0, top: 10, bottom: 10),
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
                                    controller: confirmpassword,
                                    keyboardType: TextInputType.text,
                                    style: new TextStyle(color: Colors.black,fontSize: 14.0,fontWeight: FontWeight.bold),//Enter content color and font size
                                    obscureText: true,
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
                                      hintText: 'Confirm Password',
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
                                left: 20.0, right: 20.0, top: 20, bottom: 0),
                            child:
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [


                                Expanded(
                                  flex: 10,

                                  child:



                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                                            mainAxisAlignment: MainAxisAlignment.start,
//                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[



                                      Container(

                                        child:



                                        Center(child:ButtonTheme(
                                          height: 45.0,
                                          minWidth: 250,
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
                            )

                        ),












                      ],
                    ),





                  ),
                ),

              ),

              Container(
                  child: _isLoading ? Loader(loadingTxt: 'Content is loading...',) : Container()
              ),








            ],
          ),





//        floatingActionButton:
//    Padding(
//    padding: const EdgeInsets.only(
//    left: 30.0, right: 0.0, top: 10, bottom: 0),
//    child:
//        GestureDetector(
//        onTap: (){
//          if (formkey.currentState.validate()) {
//
//            print("Validated");
//            //   tokencreate();
//            //login();
//
//
//
//            if(userid.text !='' )
//            {
//              _showLoadingIndicator_log();
//            }
//            else{
//
//
//            }
//
//
//
//
//          } else {
//            print("Not Validated");
//          }
//        },
//        child: new
//        Container(
//          decoration: BoxDecoration(
//
//            color:Color(0xFFFAD330) ,
//            // borderRadius: BorderRadius.circular(12),
//            borderRadius: BorderRadius.only(
//                bottomLeft: Radius.circular(0.0),
//                bottomRight:Radius.circular(0.0)
//            ),
//          ),
//          height: 50,
//          width:double.infinity,
//          child: Padding(
//            padding: const EdgeInsets.all(0),
//            child: Container(
////                                  decoration: BoxDecoration(
////                                    color:  Color(0xFF191B2A),
////                                    borderRadius: BorderRadius.circular(35),
////                                  ),
//              child: Center(
//                child:
//                // Text('Enter further widgets here'),
//
//
//                Text(
//                  'LOGIN',
//                  style: TextStyle(
//                      color: Colors.white, fontSize: 16),
//                ),
//              ),
//
//
//
//
//            ),
//          ),
//        ),
//
//      ),
//    ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        )
    );
  }




}








