// @dart=2.9

import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itpcchennaiapp/dashboard.dart';
//import 'package:realhappyindiaapp/drop.dart';
//import 'package:realhappyindiaapp/dropdown.dart';
import 'package:itpcchennaiapp/loader.dart';
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

class Studentdata {
  String signup_id;
  String signup_choose;
  String signup_img;
  String signup_img1;
  String signup_pdf;

  String signup_pdf1;
  String signup_pdf2;
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



  Studentdata({
    this.signup_id,
    this.signup_choose,
    this.signup_img,
    this.signup_img1,
    this.signup_pdf,

    this.signup_pdf1,
    this.signup_pdf2,
    this.signup_gst_number,

    this.signup_organation,
    this.signup_name,
    this.signup_email,
    this.signup_mobile,
    this.signup_city,
    this.signup_country,

    this.signup_address,
    this.signup_count,
    this.signup_establishment,
    this.signup_wdays,
    this.signup_whours,
    this.signup_about,
    this.signup_website,


  });

  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(
      signup_id: json['signup_id'],
      signup_choose: json['signup_choose'],
      signup_img: json['signup_img'],
      signup_img1: json['signup_img1'],
      signup_pdf: json['signup_pdf'],

      signup_pdf1: json['signup_pdf1'],
      signup_pdf2: json['signup_pdf2'],
      signup_gst_number: json['signup_gst_number'],

      signup_organation: json['signup_organation'],
      signup_name: json['signup_name'],
      signup_email: json['signup_email'],
      signup_mobile: json['signup_mobile'],
      signup_city: json['signup_city'],
      signup_country: json['signup_country'],


      signup_address: json['signup_address'],
      signup_count: json['signup_count'],
      signup_establishment: json['signup_establishment'],
      signup_wdays: json['signup_wdays'],
      signup_whours: json['signup_whours'],
      signup_about: json['signup_about'],
      signup_website: json['signup_website'],



    );
  }
}

class profile extends StatefulWidget {

  profile({this.userid, this.Type, this.content, this.Name, this.signupid});

  var userid;
  var Type;
  var content;
  var Name;
  var signupid;

  @override
  _LoginFormValidationState createState() => _LoginFormValidationState();
}

class _LoginFormValidationState extends State<profile> {

  final Connectivity _connectivity = Connectivity();
  StreamSubscription< ConnectivityResult > _connectivitySubscription;

  List<Map> _myJsontitle = [{"id":'Choose Type',"name":"Choose Type"},{"id":'Indonesian Seller/Exporter/Manufacture',"name":"Indonesian Seller/Exporter/Manufacture"},{"id":'Indian Importer/Buyer/Trader',"name":"Indian Importer/Buyer/Trader"},{"id":'Indian local Distributor',"name":"Indian local Distributor"},{"id":'Indonesian Investor',"name":"Indonesian Investor"}];
  String _mySelection_title="Choose Type";




  String signup_id;
  String signup_choose;
  String signup_img="http://ecorewick.com/moniespay_api/images/default_profile.png";
  String signup_img1="http://ecorewick.com/moniespay_api/images/default_profile.png";
  String signup_pdf="http://ecorewick.com/moniespay_api/images/default_profile.png";

  String signup_pdf1="http://ecorewick.com/moniespay_api/images/default_profile.png";
  String signup_pdf2="http://ecorewick.com/moniespay_api/images/default_profile.png";
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

  DeviceInfoPlugin deviceInfo =
  DeviceInfoPlugin(); // instantiate device info plugin
  AndroidDeviceInfo androidDeviceInfo;


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
        getDeviceinfo();

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
  final TextEditingController name = new TextEditingController();
  final TextEditingController City = new TextEditingController();




  List _selecteCategorys = List();

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
    fetchStudents();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_UpdateConnectionState);
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

  void getDeviceinfo() async {
    androidDeviceInfo = await deviceInfo
        .androidInfo; // instantiate Android Device Infoformation
    setState(() {
      board = androidDeviceInfo.board;
      brand = androidDeviceInfo.brand;
      device = androidDeviceInfo.device;
      hardware = androidDeviceInfo.hardware;
      host = androidDeviceInfo.host;
      id = androidDeviceInfo.id;
      manufacture = androidDeviceInfo.manufacturer;
      model = androidDeviceInfo.model;
      product = androidDeviceInfo.product;
      type = androidDeviceInfo.type;
      isphysicaldevice = androidDeviceInfo.isPhysicalDevice;
      androidid = androidDeviceInfo.androidId;
      print('04-02-2022');
      print(board);
      print(brand);
      print(device);
      print(hardware);
      print(manufacture);
      print(id);
      print(model);
      print(product);
      print(androidid);

    });
  }






  Future< void > initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("Error Occurred: ${e.toString()} ");
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _UpdateConnectionState(result);
  }

  Future<void> _UpdateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      isEnabled = true;
      showStatus(result, true);

    } else {
      isEnabled = false;
      showStatus(result, false);
    }
  }

  void showStatus(ConnectivityResult result, bool status) {
    final snackBar = SnackBar(
        content:
        Text("${status ? 'ONLINE\n' : 'OFFLINE\n'}${result.toString()} "),
        backgroundColor: status ? Colors.green : Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

                                      value: _userDetails[index].selected,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _onCategorySelected(_userDetails[index].selected,_userDetails[index].id);

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
                                        Navigator.of(context).pop();
                                      },
                                    ),

                                    FlatButton(
                                      child: Text("CLOSE & CLEAR", style: const TextStyle(fontSize: 10, color: Colors.blue,)),
                                      onPressed: () {
                                        //Put your code here which you want to execute on Cancel button click.
                                        Navigator.of(context).pop();
                                      },
                                    ),

                                    FlatButton(
                                      child: Text("SELECT ALL", style: const TextStyle(fontSize: 10, color: Colors.blue,)),
                                      onPressed: () {
                                        //Put your code here which you want to execute on Cancel button click.
                                        Navigator.of(context).pop();
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




  Future<List<dynamic>> register() async {

    print('///////**////////');
    print(category.toString());
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
      gstno.text="";



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

  Future<List<Studentdata>> fetchStudents() async {

    String searchfiled;



    print('SEARCH');
    print(widget.signupid);

    print('SEARCH');
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://itpcchennai.com/web_api/public/user_profile'));
    request.fields.addAll({

      'signup_id': '416',

    });
    print('3333');

    http.StreamedResponse response = await request.send();
    var decoded = await response.stream.bytesToString().then(json.decode);

    var usersData = decoded['data'];


    print(decoded['data'].toString());
    //   var response = await http.post(Uri.parse(apiURL));

    if (response.statusCode == 200) {
      print('8888888888');
      String strst=decoded['data'].toString();

      List<String> stri = strst.split(",");
      print('2222');
      signup_id = stri[0].replaceAll("signup_id", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      signup_choose = stri[1].replaceAll("signup_choose", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      signup_img = stri[2].replaceAll("signup_img", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "").replaceAll("https://itpcchennai.com/", "");

      print('signup_img');
      print(signup_img);
      signup_img1 = stri[3].replaceAll("signup_img1", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "").replaceAll("https://itpcchennai.com/", "");

      print('signup_img1');
      print(signup_img1);
      signup_pdf = stri[4].replaceAll("signup_pdf", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "").replaceAll("https://itpcchennai.com/", "");
print(signup_pdf);
print('signup_pdf');
      signup_pdf1 = stri[5].replaceAll("signup_pdf1", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "").replaceAll("https://itpcchennai.com/", "");
      print(signup_pdf1);
      print('signup_pdf1');
      signup_pdf2 = stri[6].replaceAll("signup_pdf2", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "").replaceAll("https://itpcchennai.com/", "");



      print(signup_pdf2);
      print('signup_pdf2');
      signup_gst_number = stri[7].replaceAll("signup_gst_number", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      gstno.text=signup_gst_number.toString();
      print('GST');
      print(signup_gst_number.toString());

      signup_organation = stri[8].replaceAll("signup_organation", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      print('organation');
      print(signup_organation.toString());
      organization.text=signup_organation.toString();

      signup_name = stri[9].replaceAll("signup_name", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");



      signup_email = stri[10].replaceAll("signup_email", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");
      email.text=signup_email.toString();

      print('email');
      print(signup_email.toString());



      signup_mobile = stri[11].replaceAll("signup_mobile", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      mobile.text=signup_mobile.toString();
      signup_city = stri[12].replaceAll("signup_city", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      city.text=signup_city.toString();

      signup_country = stri[13].replaceAll("signup_country", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      country.text=signup_country.toString();
      signup_address = stri[14].replaceAll("signup_address", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      address.text=signup_address.toString();
      signup_count = stri[15].replaceAll("signup_count", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");


      signup_establishment = stri[16].replaceAll("signup_establishment", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      signup_wdays = stri[17].replaceAll("signup_wdays", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      signup_whours = stri[18].replaceAll("signup_whours", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      signup_about = stri[19].replaceAll("signup_about", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");
      about.text=signup_about.toString();
      signup_website = stri[20].replaceAll("signup_website", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");
      website.text=signup_website.toString();

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

  @override
  Widget build(BuildContext context) {
    return


      Scaffold(

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

              DrawerHeader(
                decoration:
                BoxDecoration(
                  color: Color(0xFFFAFAFA),
                ),
                child:

                Container(
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left:5.0, right: 15.0, top: 5, bottom: 0),
                        child:
                        Text('Welcome '+widget.Name,style: const TextStyle(
                            color: Color(0xFF082130),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Noto Sans'
                        ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left:5.0, right: 15.0, top: 5, bottom: 0),
                        child:
                        Text('('+widget.content+' )',style: const TextStyle(
                            color: Color(0xFF082130),
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Noto Sans'
                        ),),
                      ),
                    ],
                  ),

                ),
              ),
              ListTile(
                title: Text("Home",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/home_nx.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {

                  });
                },
              ),

              ListTile(
                title: Text("My Product",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/product.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {

                  });
                },
              ),
              ListTile(
                title: Text("My Profile",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/contact.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {

                  });
                },
              ),

              ListTile(
                title: Text("Event",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/event.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {

                  });
                },
              ),

              ListTile(
                title: Text("Market Brief-India",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/marketbf.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {

                  });
                },
              ),

              ListTile(
                title: Text("Market Brief-Indonesia",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/exportnews.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {

                  });
                },
              ),
              ListTile(
                title: Text("About Us",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/about.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {

                  });
                },
              ),
              ListTile(
                title: Text("Contact Us",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/contact.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {

                  });
                },
              ),
              ListTile(
                title: Text("Change Password",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/changepassword.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {

                  });
                },
              ),

              ListTile(
                title: Text("Logout",style: const TextStyle(
                    color: Color(0xFF082130),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Noto Sans'
                ),),
                leading: Image.asset( "images/logout.png", height: 25,),
                selectedTileColor:Colors.black,
                onTap: () {
                  setState(() {

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[




                    Container(

                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(

                              signup_img == 'https://itpcchennai.com/profile_img/'? 'http://ecorewick.com/moniespay_api/images/default_profile.png' :   signup_img
                              ,  width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            Text('Profile picture' , style: TextStyle(fontSize: 12,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,)),
                            Text('*Below 1 MB' , style: TextStyle(fontSize: 12,color: Color(0xFFD1D4D9), fontWeight: FontWeight.bold,)),

                          ],
                        )

                    ),

                    Container(

                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(

                              signup_img1 == 'https://itpcchennai.com/profile_icon/'? 'http://ecorewick.com/moniespay_api/images/default_profile.png' :   signup_img1
                              ,  width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            Text('Organization icon' , style: TextStyle(fontSize: 12,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,)),
                            Text('*Below 1 MB' , style: TextStyle(fontSize: 12,color: Color(0xFFD1D4D9), fontWeight: FontWeight.bold,)),

                          ],
                        )

                    ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 15.0, top: 0, bottom: 0),
                          child:
                          Text('Product Category', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                        ),

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
                            SizedBox(
                              height: 33.0,

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
                                    child: Text('Select Category',style: TextStyle(color: Colors.black,  fontFamily: 'Noto Sans'),
                                      textAlign: TextAlign.left,),

                                    padding: EdgeInsets.only(top: 0, left: 0, right: 170),


                                    //padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                                  ),
                                ),
                              ),







                            ),
                          )

                      ),

                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 15.0, top: 10, bottom: 0),

                          child:
                          Text('GST NUMBER', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
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
                                  controller: gstno,
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
                                    hintText: ' GST NUMBER',
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
                        alignment: Alignment.topLeft,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 15.0, top: 10, bottom: 0),

                          child:
                          Text('Organization', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
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
                                  controller: organization,
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
                                    hintText: ' Organization',
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
                        alignment: Alignment.topLeft,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 15.0, top: 10, bottom: 0),

                          child:
                          Text('Email', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
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

                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 15.0, top: 10, bottom: 0),


                          child:
                          Text('Address', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
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
                                  controller: address,
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
                                    hintText: 'Address',
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


                      Align(
                        alignment: Alignment.topLeft,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 15.0, top: 10, bottom: 0),

                          child:
                          Text('City', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
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
                                  controller: city,
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
                        alignment: Alignment.topLeft,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 15.0, top: 10, bottom: 0),

                          child:
                          Text('Country', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
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
                                  controller: country,
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
                        alignment: Alignment.topLeft,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 15.0, top: 10, bottom: 0),

                          child:
                          Text('About', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
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
                              height: 75.0,

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
                                    hintText: 'About',
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
                        alignment: Alignment.topLeft,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 15.0, top: 10, bottom: 0),

                          child:
                          Text('Website', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
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
                                  controller: website,
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
                                    hintText: 'Website',
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



                    Container(

                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              signup_pdf == 'https://itpcchennai.com/profile_pdf/'? 'http://ecorewick.com/moniespay_api/images/default_profile.png' :  signup_pdf

                              ,  width: 120,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                            Text('Company Profile' , style: TextStyle(fontSize: 12,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,)),
                            Text('*Below 5 MB' , style: TextStyle(fontSize: 12,color: Color(0xFFD1D4D9), fontWeight: FontWeight.bold,)),

                          ],
                        )

                    ),
                    Container(

                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(

                              signup_pdf == 'https://itpcchennai.com/profile_pdf/'? 'http://ecorewick.com/moniespay_api/images/default_profile.png' :   signup_pdf
                              ,  width: 120,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                            Text('Product Profile' , style: TextStyle(fontSize: 12,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,)),
                            Text('*Below 5 MB' , style: TextStyle(fontSize: 12,color: Color(0xFFD1D4D9), fontWeight: FontWeight.bold,)),

                          ],
                        )

                    ),
                    Container(

                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              signup_pdf1 == 'https://itpcchennai.com/product_pdf/'? 'http://ecorewick.com/moniespay_api/images/default_profile.png' :   signup_pdf1
                              ,  width: 120,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                            Text('Company Documents' , style: TextStyle(fontSize: 12,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,)),
                            Text('*Below 5 MB' , style: TextStyle(fontSize: 12,color: Color(0xFFD1D4D9), fontWeight: FontWeight.bold,)),

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


