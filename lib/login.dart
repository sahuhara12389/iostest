// @dart=2.9
import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itpcchennaiapp/buyerdashboard.dart';
import 'package:itpcchennaiapp/dashboard.dart';
import 'package:itpcchennaiapp/listmore.dart';
import 'package:itpcchennaiapp/listmore2.dart';
//import 'package:realhappyindiaapp/drop.dart';
//import 'package:realhappyindiaapp/dropdown.dart';
import 'package:itpcchennaiapp/loader.dart';
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

class login extends StatefulWidget {
  @override
  _LoginFormValidationState createState() => _LoginFormValidationState();
}

class _LoginFormValidationState extends State<login> {

  final Connectivity _connectivity = Connectivity();
  StreamSubscription< ConnectivityResult > _connectivitySubscription;



  DeviceInfoPlugin deviceInfo =
  DeviceInfoPlugin(); // instantiate device info plugin
  AndroidDeviceInfo androidDeviceInfo;


  bool isphysicaldevice;





  bool _isLoading = false;
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  void _showLoadingIndicator_log() {
    print('isloading');
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {

        _isLoading = false;
      });
      print(_isLoading);
    });
  }


  void _showLoadingIndicator_logguest(){
    print('isloading');
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        loginguest();
        _isLoading = false;
      });
      print(_isLoading);
    });
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


  final TextEditingController userid = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController forgetemail = new TextEditingController();



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



    super.initState();





  }


  showAlert(BuildContext context) {



    showDialog(
        context: context,
        builder: (BuildContext context) {
          return

            AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: StatefulBuilder(  // You need this, notice the parameters below:
                builder: (BuildContext context, StateSetter setState) {
                  return


                    Container(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child:


                        Column(
                          children: <Widget>[
                            new

                            Container(

                              child: new Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new

                                  Column(
                                    children: [

                                      Align(
                                        alignment: Alignment.topLeft,
                                        child:
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25.0, right: 15.0, top: 0, bottom: 0),

                                          child:
                                          Text('Reset Your Account Password', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                                        ),

                                      ),


                                      Align(
                                        alignment: Alignment.topLeft,
                                        child:
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25.0, right: 15.0, top: 10, bottom: 0),

                                          child:
                                          Text('Account Email', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                                        ),

                                      ),

                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 20.0, top: 10, bottom: 0),
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
                                                  controller: forgetemail,
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







                                            ),
                                          )

                                      ),

                                    ],
                                  )


                              ),
                            ),


                            new Container(

                                child:

                            Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

Expanded(
  flex: 5,
  child:  FlatButton(
    child: Text("Cancel", style: const TextStyle(fontSize: 15, color: Colors.blue,)),
    onPressed: () {
      //Put your code here which you want to execute on No button click.

      setState(() {

        Navigator.of(context).pop();
      });
    },
  ),
),

                              Expanded(
                                flex: 5,
                                child:
                                FlatButton(
                                  child: Text("Reset", style: const TextStyle(fontSize: 15, color: Colors.blue,)),
                                  onPressed: () {
                                    //Put your code here which you want to execute on Cancel button click.
                                    setState(() {

                                      forgetpwd();
                                      Navigator.of(context).pop();
                                    });


                                  },
                                ),
                              ),

                              ],
                            ),
                            )



                            ),

                          ],
                        ),


                      ),
                    );



                },
              ),
            );



//            Dialog(
//            insetPadding: EdgeInsets.all(10),
//            shape: RoundedRectangleBorder(
//                borderRadius:
//                BorderRadius.circular(20.0)), //this right here
//            child:
//
//          );
        });



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

  _launchURL() async {
    const url = 'https://itpcchennai.com/about_us.php';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<List<dynamic>> forgetpwd() async {


  if(forgetemail.text=="")
  {
    Fluttertoast.showToast(
        msg: 'Enter Mail',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,

        backgroundColor: Color(0xFF072331),
        textColor: Colors.white
    );
    showAlert(context);
  }
  else {
    print('///////**////////');


    var request = http.MultipartRequest('POST',
        Uri.parse('https://itpcchennai.com/web_api/public/forgot_password'));
    request.fields.addAll({

      'signup_email': forgetemail.text
    });


    http.StreamedResponse response = await request.send();


    print(response.statusCode);


    var decoded = await response.stream.bytesToString().then(json.decode);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: 'Password Reset Mail sent',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );

      forgetemail.text = "";
    }
    return List<Map<String, dynamic>>.from(
        json.decode(await response.stream.bytesToString()));
    }

  }



  Future<List<dynamic>> loginguest() async {


    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();

    sharedPreferences.setString("SessionUserid", 'sahu50@gmail.com');
    sharedPreferences.setString("SessionFIRSTNAME", 'Xcct');
    sharedPreferences.setString("Sessionemail",'sahu50@gmail.com');
    sharedPreferences.setString("SessionMemberID", '412');
    sharedPreferences.setString("Sessionsignup_choose", 'Indonesian Seller/Exporter/Manufacturer');
    sharedPreferences.setString("Sessionsignup_content", 'IndonesianSeller/Exporter/Manufacturer');
    sharedPreferences.setString("Sessionsignupid", '412');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          sellerdashbaord(
              userid:'sahu50@gmail.com' ,Type:'Indonesian Seller/Exporter/Manufacturer',content:'IndonesianSeller/Exporter/Manufacturer',Name:'Guest',signupid:'412'

          )),




    );

    return List<Map<String, dynamic>>.from(json.decode("s"));

  }

  void submitinquery1() async {
    if(userid.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter Email',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
    }
    else  if(password.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter Password',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
    }

    else
    {

      login();
    }
  }



  Future<List<dynamic>> login() async {

    String signup_id;
    String signup_choose;
    String signup_choose_content;
    String signup_img;
    String signup_gst_number;
    String signup_organation;
    String signup_name;
    String signup_email;
    String signup_mobile;
    String signup_city;
    String signup_country;
    print('///////**////////');

    print(password.text);
    print(userid.text.toString());

    print('///////**////////');
//    var url = "http://ecorewick.com/moniespay_api/api/ISINSTALLAPP";
//    final body = {
//      'UserID': userid.text.toString(),
//      'brand': brand.toString(),
//      'model': model.toString(),
//      'android': androidid.toString()
//
//    };
//    print('020202');
//    final response  =await http.post(Uri.parse(url),
//        body: json.encode(body),
//        headers: { 'Content-type': 'application/json',
//          'Accept': 'application/json',
//          "Token": "TXpBdE5TMHlMVEl3TWpJdE1BPT0sOTg2MTIzODQ5MywyLzUvMjAyMyA3OjAwOjA5IEFN"}
//    );

    var request = http.MultipartRequest('POST', Uri.parse('https://itpcchennai.com/web_api/public/login'));
    request.fields.addAll({

      'signup_email': userid.text,
      'signup_password': password.text
    });


    http.StreamedResponse response = await request.send();


    print(response.statusCode);


    var decoded = await response.stream.bytesToString().then(json.decode);

    if (response.statusCode == 200) {




      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();


      print('040404');
      //print(await response.stream.bytesToString());
      print('050505');
      print({decoded['status']});
      print({decoded['message']});
      print({decoded['data']});


      var usersDataFromJson = {decoded['data']};
      // List<String> userData = List<String>.from(usersDataFromJson);
      print('66666');



      String data2 = usersDataFromJson.toString();
      print(data2.toString());
      print('777');
      List<String> stri = data2.split(",");

      signup_id = stri[0].replaceAll("signup_id", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      print(signup_id);
      signup_choose = stri[1].replaceAll("signup_choose", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      print(signup_choose);


      signup_choose_content = stri[1].replaceAll("signup_choose", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "");



      signup_img = stri[2].replaceAll("signup_img", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");



      print(signup_img);
      signup_gst_number = stri[3].replaceAll("signup_gst_number", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");


      print(signup_gst_number);
      signup_organation = stri[4].replaceAll("signup_organation", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      print(signup_organation);
      signup_name = stri[5].replaceAll("signup_name", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");



      print(signup_name);
      signup_email = stri[6].replaceAll("signup_email", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      print(signup_email);
      signup_mobile = stri[7].replaceAll("signup_mobile", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      print(signup_mobile);
      signup_city = stri[8].replaceAll("signup_city", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");
      print(signup_city);
      signup_country = stri[9].replaceAll("signup_country", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      print(signup_country);





      sharedPreferences.setString("SessionUserid", userid.text);
      sharedPreferences.setString("SessionFIRSTNAME", signup_name);
      sharedPreferences.setString("Sessionemail",signup_email);
      sharedPreferences.setString("SessionMemberID", signup_id);
      sharedPreferences.setString("Sessionsignup_choose", signup_choose);
      sharedPreferences.setString("Sessionsignup_content", signup_choose_content);
      sharedPreferences.setString("Sessionsignupid", signup_id.toString());

      print(signup_choose);

      if(signup_choose=='IndonesianInvestor')
      {

        print('1x');


        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              buyerdashbaord(
                  userid:signup_email.toString() ,Type:signup_choose.toString(),content:signup_choose_content,Name:signup_name.toString(),signupid:signup_id.toString()

              )),


        );



      }
      else  if(signup_choose=='IndonesianSeller/Exporter/Manufacturer')
      {

        print('2x');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              sellerdashbaord(
                  userid:signup_email.toString() ,Type:signup_choose.toString(),content:signup_choose_content,Name:signup_name.toString(),signupid:signup_id.toString()

              )),




        );


      }
      else
      {
        print('b2x');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              buyerdashbaord(
                  userid:signup_email.toString() ,Type:signup_choose.toString(),content:signup_choose_content,Name:signup_name.toString(),signupid:signup_id.toString()

              )),
        );

      }


      userid.text="";
      password.text="";


    }
    return List<Map<String, dynamic>>.from(json.decode(await response.stream.bytesToString()));

  }




  @override
  Widget build(BuildContext context) {
    return


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
                          Text('Welcome Back', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                        ),

                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20, bottom: 20),
                          child:
                          Text('Thank you for getting back, please login to your \n account by filling the detail  ',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal, color: Color(0xFF868686),  fontFamily: 'Noto Sans'),),
                        ),

                      ),


                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10, bottom: 0),
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
                                  controller: userid,
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
                              left: 20.0, right: 20.0, top: 10, bottom: 0),
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
                                  controller: password,
                                  keyboardType: TextInputType.text,
                                  style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),//Enter content color and font size
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
                                    hintText: ' Password',
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

                      Align(
                        alignment: Alignment.topRight,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 30.0, top: 20, bottom: 20),
                          child:

                          InkWell(
                            onTap: (){
                              showAlert(context);
                            },
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF072331),
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),

                      ),



                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10, bottom: 0),
                          child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [


                              Expanded(
                                flex: 5,

                                child:



                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                                            mainAxisAlignment: MainAxisAlignment.start,
//                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[



                                    Container(

                                      child:




                                      ButtonTheme(
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
                                          child: Text('LOGIN'),
                                        ),
                                      ),


                                    ),




                                  ],
                                ),



                              ),


                              Expanded(
                                flex: 5,
                                child: Container(

                                  child:




                                  ButtonTheme(
                                    height: 45.0,
                                    minWidth: 150,
                                    child:
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(5.0),


                                      ),
                                      onPressed: isEnabled ? ()=> _doregister() : null,
                                      color:  Color(0xFFFFFFFF),
                                      textColor: Color(0xFF072331),
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Text('SIGN UP'),
                                    ),
                                  ),


                                ),
                              )


                            ],
                          )

                      ),







                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 15, bottom: 0),

                        child:






                        new
                        GestureDetector(
                          onTap: (){
                            loginguest();
                          },
                          child: new
                          Container(
                            decoration: BoxDecoration(
                              color:  Color(0xFF072331),

                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(1.5),
                              child:


                              Container(


                                child: Center(
                                  child:
                                  Text('  Guest Login  ',  style: TextStyle(
                                      color: Colors.white, fontSize: 16,  fontFamily: 'Noto Sans'),
                                  ),),



                              ),




                            ),
                          ),
                        ),

                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 15, bottom: 0),

                        child:






                        new
                        GestureDetector(
                          onTap: (){
                            _launchURL();
                          },
                          child: new
                          Container(
                            decoration: BoxDecoration(
                              //color:Color(0xFFFAD330) ,

                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(1.5),
                              child:


                              Container(


                                child: Center(
                                  child:
                                  Text('Privacy Policy',  style: TextStyle(
                                      color: Colors.black, fontSize: 16,  fontFamily: 'Noto Sans'),
                                  ),),



                              ),




                            ),
                          ),
                        ),

                      ),


                    ]
                  ),
















                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10, bottom: 0),
                          child:Text('User Disclaimer:',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal, color: Color(0xFF868686),  fontFamily: 'Noto Sans')
                            ,)),

                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10, bottom: 0),
                          child:Text('Before Proceeding with any kind of business transactions/signing of contract with any of the listed companies in this platform, we request you to intimate our office in advance. Write us:inquiry@itpcchennai.com ',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal, color: Color(0xFF868686),  fontFamily: 'Noto Sans')
                            ,)),










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

      );
  }







}








