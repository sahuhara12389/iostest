// @dart=2.9

import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itpcchennaiapp/dashboard.dart';
//import 'package:realhappyindiaapp/drop.dart';
//import 'package:realhappyindiaapp/dropdown.dart';
import 'package:itpcchennaiapp/loader.dart';
import 'package:itpcchennaiapp/login.dart';
import 'package:itpcchennaiapp/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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

//import 'package:searchable_dropdown/searchable_dropdown.dart';


String contype="";
String _title;
String _description;
String storedPasscode = '';
String token="";
String board, brand, device, hardware, host, id, manufacture, model, product, type, androidid;
String BBPSAGENTID="";



class signup extends StatefulWidget {
  @override
  _LoginFormValidationState createState() => _LoginFormValidationState();
}

class _LoginFormValidationState extends State<signup> {

  final Connectivity _connectivity = Connectivity();
  StreamSubscription< ConnectivityResult > _connectivitySubscription;

  List<Map> _myJsontitle = [{"id":'Choose Type',"name":"Choose Type"},{"id":'Indonesian Seller/Exporter/Manufacture',"name":"Indonesian Seller/Exporter/Manufacture"},{"id":'Indian Importer/Buyer/Trader',"name":"Indian Importer/Buyer/Trader"},{"id":'Indian local Distributor',"name":"Indian local Distributor"},{"id":'Indonesian Investor',"name":"Indonesian Investor"}];
   String _mySelection_title="Choose Type";


  DeviceInfoPlugin deviceInfo =
  DeviceInfoPlugin(); // instantiate device info plugin
  AndroidDeviceInfo androidDeviceInfo;

  bool _isChecked = false;
  String checkall="0";
  String checkalldata="";
  bool isphysicaldevice;


  int number;

  static final Map<int, String> map = {
    0: "zero",
    1: "one",
    2: "two",
    3: "three",
    4: "four",
    5: "five",
    6: "six",
    7: "seven",
    8: "eight",
    9: "nine",
    10: "ten",
    11: "eleven",
    12: "twelve",
    13: "thirteen",
    14: "fourteen",
    15: "fifteen",
  };


  bool _isLoading = false;
  String initialCountry = 'IN';


  void _showLoadingIndicator_log() {
    print('isloading');
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
      //  getDeviceinfo();

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


  final TextEditingController orgname = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController conpassword = new TextEditingController();
  final TextEditingController name = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  final TextEditingController City = new TextEditingController();
  final TextEditingController country = new TextEditingController();
  final TextEditingController gstno = new TextEditingController();
  TextEditingController controller = new TextEditingController();




  List _selecteCategorys = List();

  String listcategory=",";

  String category=",";


  void _onCategorySelected(bool selected, category_id) {

    print(category_id);
    print('Start');
    print(selected);

    if (selected == false) {
      print('check');
      print(category_id);
      setState(() {
        _selecteCategorys.add(category_id);

        category=category+category_id+',';
          print(category);
        listcategory=category;
      });
    } else {
      print('uncheck');
      setState(() {
        _selecteCategorys.remove(category_id);

      });
    }

  }
  bool _isObscure = true;
  bool visible = false ;

  String hintcontent_gstno;
  String selectedValue;
  String preselectedValue = "dolor sit";

  List<int> selectedItems = [];
  final List<DropdownMenuItem> items = [];


  Future<bool> _onBackPressed(){

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            login(


            )),
      );

//    else if(widget.previouspage=="sellerdashboard")
//    {
//      Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) =>
//            sellerdashbaord(
//                userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid
//
//            )),
//      );
//    }

    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => mycustompage()),
//    );
  }

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


  Future<Null> getUserDetails() async {
    final response =  await http.get(Uri.parse(url));
    final responseJson = json.decode(response.body);


    var parsed =json.decode(response.body);
    List jsonResponse=parsed["Category"] as List;
    var datalist=parsed["Category"] as List;
    setState(() {

      print('OOOOOOOOOOOO');
      checkalldata = datalist.toString();
      print(checkalldata);
    });

    setState(() {
      for (Map user in jsonResponse) {
        _userDetails.add(UserDetails.fromJson(user));
      }
    });
  }



  @override
  void initState() {

    try {

    } catch (e) {
      print(e);
    }

//    initConnectivity();
//    _connectivitySubscription =
//        _connectivity.onConnectivityChanged.listen(_UpdateConnectionState);
    super.initState();
    getUserDetails();


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









  Future<List<dynamic>> loginguest() async {


    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();

    sharedPreferences.setString("SessionUserid", "RH0000001");
    sharedPreferences.setString("Sessionpass", "richindia");
    sharedPreferences.setString("SessionFIRSTNAME", "Demo");
    sharedPreferences.setString("Sessionemail","demo@gmail.com");
    sharedPreferences.setString("SessionMemberID", "z1");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          dashboard(
            userid:"RH0000001",Password:password.text.toString(),Name:"Demo",email: "demo@gmail.com",
          )),
    );

    return List<Map<String, dynamic>>.from(json.decode("s"));

  }

  showAlert(BuildContext context) {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        return
//
//          AlertDialog(
//          title: Text('Alert Dialog Title Text.'),
//          content:
//
//
//
//
//          Column(
//            children: <Widget>[
//              new
//
//              Container(
//                color: Theme.of(context).primaryColor,
//                child: new Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: new Card(
//                    child: new ListTile(
//                      leading: new Icon(Icons.search),
//                      title: new TextField(
//                        controller: controller,
//                        decoration: new InputDecoration(
//                            hintText: 'Search', border: InputBorder.none),
//                        onChanged: onSearchTextChanged,
//                      ),
//                      trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
//                        controller.clear();
//                        onSearchTextChanged('');
//                      },),
//                    ),
//                  ),
//                ),
//              ),
//              new Expanded(
//                child: _searchResult.length != 0 || controller.text.isNotEmpty
//                    ? new ListView.builder(
//                  itemCount: _searchResult.length,
//                  itemBuilder: (context, i) {
//                    return new Card(
//                      child: new ListTile(
//                        leading: new
//                        Text('xx'),
//
//                        title: new Text(_searchResult[i].firstName ),
//                      ),
//                      margin: const EdgeInsets.all(0.0),
//                    );
//                  },
//                )
//                    : new ListView.builder(
//                  itemCount: _userDetails.length,
//                  itemBuilder: (context, index) {
//                    return
//
//
//
//                      CheckboxListTile(
//
//                        value: _userDetails[index].selected,
//                        onChanged: (bool value) {
//                          setState(() {
//                            _onCategorySelected(_userDetails[index].selected,_userDetails[index].firstName);
//
//                            _userDetails[index].selected = value;
//                          });
//                        },
//
//                        title: Text(_userDetails[index].firstName),
//                      );
//
//
//
//
//
////                  CheckboxListTile(
////                    value: _selecteCategorys.contains(_userDetails[index].id),
////                    onChanged: (bool selected) {
////                      _onCategorySelected(selected,
////                          _userDetails[index].firstName);
////                    },
////                    title: Text(_userDetails[index].firstName),
////                  );
//
//
////                Card(
////                  child: new ListTile(
////                    leading:
////                    new
////
////                   Text('x'),
////
////                    title: new Text(_userDetails[index].firstName),
////                  ),
////                  margin: const EdgeInsets.all(0.0),
////                );
//                  },
//                ),
//              ),
//
//
//
//            ],
//          ),
//          actions: <Widget>[
//
//
//
//
//
//
//
//            FlatButton(
//              child: Text("YES"),
//              onPressed: () {
//                //Put your code here which you want to execute on Yes button click.
//                Navigator.of(context).pop();
//              },
//            ),
//
//            FlatButton(
//              child: Text("NO"),
//              onPressed: () {
//                //Put your code here which you want to execute on No button click.
//                Navigator.of(context).pop();
//              },
//            ),
//
//            FlatButton(
//              child: Text("CANCEL"),
//              onPressed: () {
//                //Put your code here which you want to execute on Cancel button click.
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//
//
//        );
//      },
//
//    );


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
                      height: 600,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child:


                        Column(
                          children: <Widget>[
                            new

                            Container(

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

                                      value: checkall=="0"? _userDetails[index].selected :checkall=="1"? true : _userDetails[index].selected,
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

                            new Container(
                                child: Row(
                                  children: [


                                    FlatButton(
                                      child: Text("OK", style: const TextStyle(fontSize: 10, color: Colors.blue,)),
                                      onPressed: () {
                                        //Put your code here which you want to execute on No button click.

                                        setState(() {

                                          Navigator.of(context).pop();
                                        });
                                      },
                                    ),

                                    FlatButton(
                                      child: Text("CLOSE & CLEAR", style: const TextStyle(fontSize: 10, color: Colors.blue,)),
                                      onPressed: () {
                                        //Put your code here which you want to execute on Cancel button click.
                                        setState(() {
                                          checkall = "3";
                                          listcategory= "";
                                          Navigator.of(context).pop();
                                        });


                                      },
                                    ),

                                    FlatButton(
                                      child: Text("SELECT ALL", style: const TextStyle(fontSize: 10, color: Colors.blue,)),
                                      onPressed: () {


                                        setState(() {

                                          checkall = "1";
                                          listcategory= checkalldata..toString();

                                          });
          //Put your code here which you want to execute on Cancel button click.
                                       // Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
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



  void submitinquery1() async {
    if(gstno.text == '') {


      Fluttertoast.showToast(
          msg: 'Enter Email',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );


    }
    else  if(name.text == '') {
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
    else  if(City.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter City',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
    }
    else  if(country.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter Country',
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
    else  if(conpassword.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter conform password',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
    }

    else
    {

      register();
    }
  }



  Future<List<dynamic>> register() async {

    print('///////**////////');
    print(category.toString());
    print(password.text);
    print(orgname.text.toString());
    print(name.text.toString());
    print(email.text.toString());
    print(mobile.text.toString());
    print(City.text.toString());
    print(country.text.toString());
    print(gstno.text.toString());
    print(_mySelection_title);
    print(category);
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

    var request = http.MultipartRequest('POST', Uri.parse('https://itpcchennai.com/web_api/public/registers'));
    request.fields.addAll({
      'signup_choose': _mySelection_title.toString(),
      'signup_category': category.toString(),
      'signup_organation': orgname.text,
      'signup_name': name.text,
      'signup_email': email.text,
      'signup_mobile': mobile.text,
      'signup_city': City.text,
      'signup_country': country.text,
      'signup_password': password.text,
      'signup_gst_number': gstno.text
    });


    http.StreamedResponse response = await request.send();


    print(response.statusCode);


    var decoded = await response.stream.bytesToString().then(json.decode);

    if (response.statusCode == 200) {

      print('040404');
      //print(await response.stream.bytesToString());
      print('050505');
      print({decoded['status']});
      print({decoded['message']});
      String strmsg= decoded['message'];




      category="";
      orgname.text="";
      name.text="";
      email.text="";
      mobile.text="";
      City.text="";
     country.text="";
     password.text="";
     gstno.text="";
     conpassword.text="";



      Fluttertoast.showToast(msg: decoded['message'], toastLength: Toast.LENGTH_LONG);

//      var  data = await response.stream.bytesToString();
//      print('060606');
//
//      print(data.toString());
//      // {"status":1,"message":"Registered Successful","signup_id":"427"}
//      List<String> strings = data.split(",");
//
//      var Status = strings[0].replaceAll("status", "").replaceAll("{", "")
//          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "")
//          .replaceAll(":", "");
//      var message = strings[1].replaceAll("message", "").replaceAll("{", "")
//          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "")
//          .replaceAll(":", "");
//
//      print('070707');
//      print('xxxxxxxxx');
//      print(Status);


    }
    else
      {
        Fluttertoast.showToast(msg: decoded['message'], toastLength: Toast.LENGTH_LONG);
      }
    return List<Map<String, dynamic>>.from(json.decode(await response.stream.bytesToString()));

  }



  @override
  Widget build(BuildContext context) {
    return

      WillPopScope(
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

//                  Container(
//                    //color: Color(0xFF1A8DD6),
//
//
//                    decoration: BoxDecoration(
//                      gradient: LinearGradient(
//                        begin: Alignment.topCenter,
//                        end: Alignment.bottomCenter,
//                        colors: <Color>[
//                          Color(0xFF1A8DD6),
//                          Color(0xFF0D528C)
//                        ],
//                      ),
//                    ),
//                    width: double.infinity,
//
//
//
//
//
//
//                    child: Container(
//
//                      width: double.infinity,
//                      //color: Color(0xFF1A8DD6),
//                      decoration: BoxDecoration(
//                        gradient: LinearGradient(
//                          begin: Alignment.topCenter,
//                          end: Alignment.bottomCenter,
//                          colors: <Color>[
//                            Color(0xFF1A8DD6),
//                            Color(0xFF0D528C)
//                          ],
//                        ),
//                      ),
//
//
//                      child: Stack(
//
//
//
//                        alignment: Alignment.center,
//
//
//
//                        children: <Widget>[
//
//                          Column(
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: <Widget>[
//                              SizedBox(height:120,),
//
//                              Padding(
//                                padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
//                                child:
//
//
//                                Container(
//
//                                  width: double.infinity,
//                                  //color: Color(0xFF23242F),
//                                  decoration: BoxDecoration(
//                                      color: Color(0xFFEAEAE8),
//                                      border: Border.all(
//                                        color: Color(0xFFEAEAE8),
//                                      ),
//                                      borderRadius: BorderRadius.all(Radius.circular(10))
//                                  ),
//
//
//
//
//
//
//                                  child: Column(
//                                    mainAxisAlignment: MainAxisAlignment.start,
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    children: <Widget>[
//
//
//                                      Center(
//                                        child:Padding(
//                                          padding: EdgeInsets.only(left: 0, right: 10, top: 10, bottom: 0),
//                                          child:
//                                          Image.asset('images/moniespaylogo3.png', width: 150, height: 80,),
//                                        ),
//                                      ),
//
//                                      SizedBox(height: 15,),
//
//
//                                      Padding(
//                                        padding: const EdgeInsets.only(
//                                            left: 5.0, right: 15.0, top: 10, bottom: 0),
//                                        child: Center(
//                                          child:
//
//                                          Text('Login to your account!', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
//                                        ),
//                                      ),
//
//                                      SizedBox(height: 20,),
//
//
//                                      Align(
//                                        alignment: Alignment.topLeft,
//                                        child:
//                                        Padding(
//                                          padding: const EdgeInsets.only(
//                                              left: 20.0, right: 15.0, top: 0, bottom: 0),
//                                          child:
//                                          Text('User ID', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
//                                        ),
//
//                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.only(
//                                            left: 15.0, right: 15.0, top: 10, bottom: 0),
//                                        child:
//                                        SizedBox(
//                                          height: 50.0,
//                                          child:
//                                          TextFormField(
//                                            controller: userid,
//                                            style: new TextStyle(color: Colors.black,fontSize: 16.0),//Enter content color and font size
//                                            obscureText: false,
//                                            decoration: InputDecoration(
//
//                                              filled: true,
//                                              fillColor:Color(0xFFDDE7F0),
//
////                                  enabledBorder: OutlineInputBorder(
////                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
////                                    borderSide: BorderSide(color: Colors.blue, width: 1),
////                                  ),
//
//                                              border: OutlineInputBorder(
//                                                borderRadius: new BorderRadius.circular(5.0),
//                                              ),
//
//                                              hintText: 'Enter UserID',
//                                              hintStyle: TextStyle(color: Colors.black),
//
//
//                                            ),
////                                validator: MultiValidator([
////                                  RequiredValidator(errorText: "* Required"),
////
////
////                                ])
//                                            //validatePassword,        //Function to check validation
//                                          ),
//
//
////                                          InternationalPhoneNumberInput(
////                                            onInputChanged: (PhoneNumber number) {
////                                              print(number.phoneNumber);
////                                            },
////                                            onInputValidated: (bool value) {
////                                              print(value);
////                                            },
////                                            selectorConfig: SelectorConfig(
////                                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
////                                            ),
////                                            ignoreBlank: false,
////                                            autoValidateMode: AutovalidateMode.disabled,
////                                            selectorTextStyle: TextStyle(color: Colors.black),
////                                            initialValue: number,
////                                            textFieldController: userid,
////                                            formatInput: false,
////                                            keyboardType:
////                                            TextInputType.numberWithOptions(signed: true, decimal: true),
////                                            inputBorder: OutlineInputBorder(),
////                                            onSaved: (PhoneNumber number) {
////                                              print('On Saved: $number');
////                                            },
////                                          ),
//
//
//
//                                        ),
//                                      ),
//                                      Align(
//                                        alignment: Alignment.topLeft,
//                                        child:
//                                        Padding(
//                                          padding: const EdgeInsets.only(
//                                              left: 20.0, right: 15.0, top: 10, bottom: 0),
//                                          child:
//                                          Text('Password', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
//                                        ),
//
//                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.only(
//                                            left: 15.0, right: 15.0, top: 10, bottom: 0),
//                                        child:
//                                        SizedBox(
//                                          height: 50.0,
//                                          child:
//
//                                          TextFormField(
//                                            controller: password,
//                                            style: new TextStyle(color: Colors.black,fontSize: 16.0),//Enter content color and font size
//
//                                            obscureText: _isObscure,
//                                            decoration: InputDecoration(
//
//
//
//                                              suffixIcon: IconButton(
//                                                  icon: Icon(
//                                                      _isObscure ? Icons.visibility : Icons.visibility_off),
//                                                  onPressed: () {
//                                                    setState(() {
//                                                      _isObscure = !_isObscure;
//                                                    });
//                                                  }),
//
//
//                                              fillColor:Color(0xFFDDE7F0),
//                                              filled: true,
////                                  enabledBorder: OutlineInputBorder(
////                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
////                                    borderSide: BorderSide(color: Colors.blue, width: 1),
////                                  ),
//                                              border: OutlineInputBorder(
//                                                borderRadius: new BorderRadius.circular(5.0),
//                                              ),
//
//                                              hintText: 'Enter Password',
//                                              hintStyle: TextStyle(color: Colors.black,  fontFamily: 'Noto Sans'),
//                                            ),
//
////                                validator: MultiValidator([
////                                  RequiredValidator(errorText: "* Required"),
////                                  MinLengthValidator(1,
////                                      errorText: "Password should be atleast 1 characters"),
////                                  MaxLengthValidator(15,
////                                      errorText:
////                                      "Password should not be greater than 15 characters")
////                                ])
//
//                                          ),
//                                        ),
//
//
//
//
//                                      ),
//
//                                      Align(
//                                        alignment: Alignment.topRight,
//                                        child:
//                                        FlatButton(
//                                          onPressed: () {
//                                            _doforget();
//                                          },
//                                          child: Text(
//                                            'Forgot Password?',
//                                            style: TextStyle(color: Colors.black, fontSize: 15,  fontFamily: 'Noto Sans'),
//                                          ),
//                                        ),
//
//                                      ),
//
//                                      Padding(
//                                        padding: const EdgeInsets.only(
//                                            left: 0.0, right: 0.0, top: 10, bottom: 0),
//
//                                        child:
//
//
//
//                                        Column(
//                                          mainAxisAlignment: MainAxisAlignment.center,
//                                          children: <Widget>[
//
//
//                                            new
//                                            GestureDetector(
//                                              onTap: (){
//                                                if (formkey.currentState.validate()) {
//
//                                                  print("Validated");
//                                                  //   tokencreate();
//                                                  //login();
//
//
//
//                                                  if(userid.text !='' )
//                                                  {
//                                                    _showLoadingIndicator_log();
//                                                  }
//                                                  else{
//
//
//                                                  }
//
//
//
//
//                                                } else {
//                                                  print("Not Validated");
//                                                }
//                                              },
//                                              child: new
//                                              Container(
//                                                decoration: BoxDecoration(
//
//                                                  color:Color(0xFFFAD330) ,
//                                                  // borderRadius: BorderRadius.circular(12),
//                                                  borderRadius: BorderRadius.only(
//                                                      bottomLeft: Radius.circular(12.0),
//                                                      bottomRight:Radius.circular(12.0)
//                                                  ),
//                                                ),
//                                                height: 50,
//                                                child: Padding(
//                                                  padding: const EdgeInsets.all(1.5),
//                                                  child: Container(
////                                  decoration: BoxDecoration(
////                                    color:  Color(0xFF191B2A),
////                                    borderRadius: BorderRadius.circular(35),
////                                  ),
//                                                    child: Center(
//                                                      child:
//                                                      // Text('Enter further widgets here'),
//
//
//                                                      Text(
//                                                        'LOGIN',
//                                                        style: TextStyle(
//                                                            color: Colors.white, fontSize: 16),
//                                                      ),
//                                                    ),
//
//
//
//
//                                                  ),
//                                                ),
//                                              ),
//
//                                            ),
//
//                                          ],
//                                        ),
//
//                                      ),
//
//
//
//
//                                    ],
//                                  ),
//
//
//
//
//
//
//
//
//
//                                ),
//                              ),
//
//
//                              Container(
//
//                                width: double.infinity,
//                                //color: Color(0xFF23242F),
//
//                                child:
//
//                                Container(
//
//                                  width: double.infinity,
//
//
//                                  child: Column(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    crossAxisAlignment: CrossAxisAlignment.center,
//                                    children: <Widget>[
//
//                                      Row(
//                                          mainAxisAlignment: MainAxisAlignment.center,
//                                          children: <Widget>[
//
//                                            Padding(
//                                              padding: const EdgeInsets.only(
//                                                  left: 25.0, right: 25.0, top: 15, bottom: 0),
//
//                                              child:
//
//
//
//
//
//
//                                              new
//                                              GestureDetector(
//                                                onTap: (){
//                                                  _showLoadingIndicator_logguest();
//                                                },
//                                                child: new
//                                                Container(
//                                                  decoration: BoxDecoration(
//                                                    color:Color(0xFFFAD330) ,
//
//                                                    borderRadius: BorderRadius.circular(12),
//                                                  ),
//                                                  height: 50,
//                                                  child: Padding(
//                                                    padding: const EdgeInsets.all(1.5),
//                                                    child:
//
//
//                                                    Container(
//
//
//                                                      child: Center(
//                                                        child:
//                                                        Text('  Guest Login  ',  style: TextStyle(
//                                                            color: Colors.white, fontSize: 16,  fontFamily: 'Noto Sans'),
//                                                        ),),
//
//
//
//                                                    ),
//
//
//
//
//                                                  ),
//                                                ),
//                                              ),
//
//                                            ),
//                                            Padding(
//                                              padding: const EdgeInsets.only(
//                                                  left: 25.0, right: 25.0, top: 15, bottom: 0),
//
//                                              child:
//
//
//
//
//
//
//                                              new
//                                              GestureDetector(
//                                                onTap: (){
//                                                  _launchURL();
//                                                },
//                                                child: new
//                                                Container(
//                                                  decoration: BoxDecoration(
//                                                    //color:Color(0xFFFAD330) ,
//
//                                                    borderRadius: BorderRadius.circular(12),
//                                                  ),
//                                                  height: 30,
//                                                  child: Padding(
//                                                    padding: const EdgeInsets.all(1.5),
//                                                    child:
//
//
//                                                    Container(
//
//
//                                                      child: Center(
//                                                        child:
//                                                        Text('Privacy Policy',  style: TextStyle(
//                                                            color: Colors.white, fontSize: 16,  fontFamily: 'Noto Sans'),
//                                                        ),),
//
//
//
//                                                    ),
//
//
//
//
//                                                  ),
//                                                ),
//                                              ),
//
//                                            ),
//
//                                          ]
//                                      ),
//
//
//                                      SizedBox(height: 20,),
//
//                                      Text(
//                                        'Don\'t have an account?',
//                                        style: TextStyle(
//                                            color: Colors.white, fontSize: 16,  fontFamily: 'Noto Sans'),
//                                      ),
//
//                                      Padding(
//                                        padding: const EdgeInsets.only(
//                                            left: 25.0, right: 25.0, top: 15, bottom: 0),
//
//                                        child:
//
//
//
//
//
//
//                                        new
//                                        GestureDetector(
//                                          onTap: (){
//                                            Navigator.push(context,
//                                                MaterialPageRoute(builder: (_) => signup()));
//                                          },
//                                          child: new
//                                          Container(
//                                            decoration: BoxDecoration(
//                                              color:Color(0xFFFAD330) ,
//
//                                              borderRadius: BorderRadius.circular(12),
//                                            ),
//                                            height: 50,
//                                            child: Padding(
//                                              padding: const EdgeInsets.all(1.5),
//                                              child:
//
//
//                                              Container(
//
//
//                                                child: Center(
//                                                  child:
//                                                  Text('SIGN UP',  style: TextStyle(
//                                                      color: Colors.white, fontSize: 16,  fontFamily: 'Noto Sans'),
//                                                  ),),
//
//
//
//                                              ),
//
//
//
//
//                                            ),
//                                          ),
//                                        ),
//
//                                      ),
//
//
//
//
//
//
//                                    ],
//                                  ),
//
//                                ),
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//                              ),
//
//                            ],
//                          ),
//
//
//                        ],
//                      ),
//                    ),
//                  ),






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
                          Text('Dont Have an Account', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                        ),

                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20, bottom: 20),
                          child:
                          Text('Signup Today ',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal, color: Color(0xFF868686),  fontFamily: 'Noto Sans'),),
                        ),

                      ),







                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 15, bottom: 0),
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
                                padding: EdgeInsets.only(top: 0, left: 5, right: 0),
                                color: Color(0xFFffffff),
                                child:
                                DropdownButtonHideUnderline(
                                  child:
                                  DropdownButton(
                                    items: _myJsontitle.map((item) {
                                      return new DropdownMenuItem(
                                          child: new
                                          Text(
                                            item['name'],
                                            style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                            ),

                                          ),




                                          value: item['id'].toString()





                                      );
                                    }).toList(),

                                    onChanged: (String newVal){
                                      setState(() {
                                        _mySelection_title=newVal;

                                          if(_mySelection_title=="Indonesian Seller/Exporter/Manufacture")
                                          {
                                             hintcontent_gstno="Nomor Induk Berusaha";
                                          }
                                          else  if(_mySelection_title=="Indonesian Investor")
                                          {
                                            hintcontent_gstno="";
                                          }
                                          else
                                          {
                                            hintcontent_gstno="GST NUMBER";
                                          }


                                        print(_mySelection_title.toString());
                                      });
                                    },
                                    hint: Container(
                                      //and here
                                      child: Text(
                                        "Choose Type",
                                        style: TextStyle(color: Colors.white,  fontFamily: 'Noto Sans'),
                                        textAlign: TextAlign.center,
                                      ),

                                    ),

                                    value: _mySelection_title,
                                  ),
                                ),
                              ),







                            ),
                          )

                      ),



                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20, bottom: 0),
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
                            ConstrainedBox(
                              constraints: BoxConstraints(

                                  minHeight: 30,

                              ),

                              child:

                              Container(
                                color: Color(0xFFffffff),
                                child:
                                Container(
                                  width: double.infinity,
                                  //and here
                                  child:
//                                  Text(
//                                    "Select Category",
//                                    style: TextStyle(color: Colors.black,  fontFamily: 'Noto Sans'),
//                                    textAlign: TextAlign.left,
//                                  ),

                                  FlatButton(
                                    onPressed: () => showAlert(context),
                                    child: Text( listcategory==','? 'Select Category':listcategory,style: TextStyle(color: Colors.black,  fontFamily: 'Noto Sans'),
                                   textAlign: TextAlign.left,),

                                    padding: EdgeInsets.only(top: 0, left: 0, right: 170),


                                    //padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                                  ),
                                ),
                              ),







                            ),
                          )

                      ),

                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15, bottom: 0),
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
                                  controller: gstno,
                                  keyboardType: TextInputType.text,
                                  style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.normal),//Enter content color and font size
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
                                    hintText: hintcontent_gstno,
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
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15, bottom: 0),
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
                                    controller: orgname,
                                    keyboardType: TextInputType.text,
                                    style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.normal),//Enter content color and font size
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
                                      hintText: ' Organization Name',
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

                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15, bottom: 0),
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
                                    controller: name,
                                    keyboardType: TextInputType.text,
                                    style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.normal),//Enter content color and font size
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
                                      hintText: 'Name',
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



                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15, bottom: 0),
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
                                    controller: email,
                                    keyboardType: TextInputType.text,
                                    style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.normal),//Enter content color and font size
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
                                      hintText: 'Email Address',
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



                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15, bottom: 0),
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
                                    style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.normal),//Enter content color and font size
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
                                      hintText: 'Mobile',
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


                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15, bottom: 0),
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
                                    controller: City,
                                    keyboardType: TextInputType.text,
                                    style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.normal),//Enter content color and font size
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
                                      hintText: 'City',
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



                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15, bottom: 0),
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
                                    controller: country,
                                    keyboardType: TextInputType.text,
                                    style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.normal),//Enter content color and font size
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
                                      hintText: 'Country',
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






                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 15, bottom: 0),
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



                                Padding(
                                    padding: const EdgeInsets.only(
                                    left: 0.0, right: 5.0, top: 0, bottom: 0),
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
                                                style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.normal),//Enter content color and font size
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
                                                  hintText: 'Password',
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

                                    ),




                                  ],
                                ),



                              ),


                              Expanded(
                                flex: 5,
                                child: Container(

                                  child:



                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, right: 0.0, top: 0, bottom: 0),
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
                                            controller: conpassword,
                                            keyboardType: TextInputType.text,
                                            style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.normal),//Enter content color and font size
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
                                              hintText: 'Repeat Password',
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
                                  ),
                                  ),

                                ),
                              )


                            ],
                          )

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
                                flex: 10,

                                child:



                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
//                                                            mainAxisAlignment: MainAxisAlignment.start,
//                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[



                                    Container(

                                      child:




                                      ButtonTheme(
                                        height: 45.0,
                                        minWidth: 200,
                                        child:
                                        RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(5.0),


                                          ),
                                          onPressed: isEnabled ? ()=> submitinquery1() : null,
                                          color:  Color(0xFF072331),
                                          textColor: Colors.white,
                                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                          child: Text('GET STARTED'),
                                        ),
                                      ),


                                    ),




                                  ],
                                ),



                              ),





                            ],
                          )

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






      )

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


