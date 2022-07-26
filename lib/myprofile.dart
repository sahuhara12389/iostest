// @dart=2.9




import 'dart:io';
import 'dart:async';


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
import 'package:itpcchennaiapp/exportnewindonesia_buyer.dart';
import 'package:itpcchennaiapp/login.dart';
import 'package:itpcchennaiapp/marketbriefindia.dart';
import 'package:itpcchennaiapp/marketbriefindia_buyer.dart';
import 'package:itpcchennaiapp/myproduct.dart';
import 'package:itpcchennaiapp/sellerdashboard.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class myprofile extends StatefulWidget {


  myprofile({this.userid, this.Type, this.content, this.Name, this.signupid});

  var userid;
  var Type;
  var content;
  var Name;
  var signupid;

  @override

  UserFilterDemoState createState() => UserFilterDemoState();
}
class UserFilterDemoState extends State<myprofile> {


  bool _isChecked = false;
  String checkall="0";
  String checkalldata="";


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
  String signup_category;



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
  String listcategory=",";

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

    super.initState();
    getUserDetails();
    myFuture = fetchData();
    fetchStudents();
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



    print('SEARCH');
    print(widget.signupid);

    print('SEARCH');
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://itpcchennai.com/web_api/public/user_profile'));
    request.fields.addAll({

      'signup_id': widget.signupid,

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


      List<String> strilist = strst.split("signup_category");

    String  signup_Cat= strilist[1].replaceAll("name", "").replaceAll(
        "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "").replaceAll(":", "").replaceAll(" ", "").toString();

    print(signup_Cat);




      List<String> stri = strst.split(",");
      print('2222');
      signup_id = stri[0].replaceAll("signup_id", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");
      print('signup_id');
      print(signup_id);
      signup_choose = stri[1].replaceAll("signup_choose", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      signup_img = stri[2].replaceAll("signup_img", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "").replaceAll("/", "");

      signup_img_1= stri[2].replaceAll("signup_img", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(" ", "");

      signup_img_1 = signup_img_1.substring(1);

      print(signup_img);
      print('signup_img');
      print(signup_img_1);



      signup_img1 = stri[3].replaceAll("signup_img1", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "").replaceAll("/", "");


      signup_img1_1= stri[3].replaceAll("signup_img1", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(" ", "");

      signup_img1_1 = signup_img1_1.substring(1);





      print('signup_img1');
      print(signup_img1);

      signup_pdf = stri[4].replaceAll("signup_pdf", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "").replaceAll("/", "");


      signup_pdf_1 = stri[4].replaceAll("signup_pdf", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(" ", "");

      signup_pdf_1 = signup_pdf_1.substring(1);

      print('signup_pdf');
      print(signup_pdf);


      signup_pdf1 = stri[5].replaceAll("signup_pdf1", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "").replaceAll("/", "");

      signup_pdf1_1 = stri[5].replaceAll("signup_pdf1", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(" ", "");

      signup_pdf1_1 = signup_pdf1_1.substring(1);
      print('signup_pdf1');
      print(signup_pdf1);




      signup_pdf2 = stri[6].replaceAll("signup_pdf2", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "").replaceAll("/", "");


      signup_pdf2_1 = stri[6].replaceAll("signup_pdf2", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(" ", "");

      signup_pdf2_1 = signup_pdf2_1.substring(1);





      print('signup_pdf2');
      print(signup_pdf2);




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


//     String sign_category = stri[21];
//      print('UYUxxxY');
//     print(sign_category);
//      List<String> stri2cat = sign_category.split("signup_category");
//      signup_category = stri2cat[1].replaceAll("name", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(":", "").replaceAll(" ", "");

      print('UYUY');
     // print(signup_category);
      listcategory=signup_Cat;
      website.text=signup_website.toString();

      final items = decoded['data'].cast<Map<String, dynamic>>();
//      print('111');
//      List<String> signup_categoryxdata = strst.split("signup_category");
//      String ssss= signup_categoryxdata[1];
//    //  final signup_categoryxdata = decoded['signup_category'].cast<Map<String, dynamic>>();
//
//     print(ssss);
//      print('11xxx1');
//      print(signup_categoryxdata);




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

  Future<List<dynamic>> updateprofile() async {

    print('UPDATE');

    print(selectedSpinnerItem);
    print(organization.text);
    print(city.text);
    print(country.text);
    print(gstno.text);
    print(about.text);
    print(website.text);
    print(widget.signupid);

    print('UPDATE');




    var request = http.MultipartRequest('POST', Uri.parse('https://itpcchennai.com/web_api/public/edit_profile'));
    request.fields.addAll({

      'signup_category': listcategory.toString(),
      'signup_organation': organization.text,
      'signup_city': city.text,
      'signup_country': country.text,
      'signup_gst_number': gstno.text,
      'about': about.text,
      'website': website.text,
      'signup_id': widget.signupid,

    });


    http.StreamedResponse response = await request.send();


    print(response.statusCode);


    var decoded = await response.stream.bytesToString().then(json.decode);

    if (response.statusCode == 200) {



      Fluttertoast.showToast(
          msg: 'Updated',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );


    }
    return List<Map<String, dynamic>>.from(json.decode(await response.stream.bytesToString()));

  }


  ImagePicker picker = ImagePicker();

  _pickImageFromGallery() async {


    print('widget.signupid');
    print(widget.signupid);
    print(widget.Name);

    PickedFile pickedFile =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    File image = File(pickedFile.path);

    setState(() {
      _image = image;


      print(_image);
      print('PICTURE');
    });



    var request = http.MultipartRequest('POST', Uri.parse('https://itpcchennai.com/web_api/public/uploadProfileImage'));
    request.fields.addAll({
      'username': widget.Name,
      'signup_id': widget.signupid
    });
    request.files.add(await http.MultipartFile.fromPath('multiple_image', _image.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Success');
      Fluttertoast.showToast(
          msg: 'Updated',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
      print(await response.stream.bytesToString());
    }
    else {
      print('failure');
      print(response.reasonPhrase);
    }




  }

  ImagePicker picker_organ = ImagePicker();
  _pickImageFromGallery_organize() async {


    print('widget.signupid');
    print(widget.signupid);
    print(widget.Name);

    PickedFile pickedFile =
    await picker_organ.getImage(source: ImageSource.gallery, imageQuality: 50);

    File image_organ = File(pickedFile.path);

    setState(() {
      _image_organ = image_organ;


      print(_image_organ);
      print('PICTURE');
    });



    var request = http.MultipartRequest('POST', Uri.parse('https://itpcchennai.com/web_api/public/uploadOrganizationImage'));
    request.fields.addAll({
      'username': widget.Name,
      'signup_id': widget.signupid
    });
    request.files.add(await http.MultipartFile.fromPath('multiple_image', _image_organ.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Success');
      print(await response.stream.bytesToString());
    }
    else {
      print('failure');
      print(response.reasonPhrase);
    }




  }



  ImagePicker picker_company = ImagePicker();
  _pickImageFromGallery_company() async {


    print('widget.signupid');
    print(widget.signupid);
    print(widget.Name);

    PickedFile pickedFile =
    await picker_company.getImage(source: ImageSource.gallery, imageQuality: 50);

    File image_company = File(pickedFile.path);

    setState(() {
      _image_company = image_company;


      print(_image_company);
      print('PICTURE');
    });



    var request = http.MultipartRequest('POST', Uri.parse('https://itpcchennai.com/web_api/public/uploadCompanyImage'));
    request.fields.addAll({
      'username': widget.Name,
      'signup_id': widget.signupid
    });
    request.files.add(await http.MultipartFile.fromPath('multiple_image', _image_company.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Success');
      Fluttertoast.showToast(
          msg: 'Updated',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
      print(await response.stream.bytesToString());
    }
    else {
      print('failure');
      print(response.reasonPhrase);
    }




  }



  ImagePicker picker_product = ImagePicker();
  _pickImageFromGallery_product() async {


    print('widget.signupid');
    print(widget.signupid);
    print(widget.Name);

    PickedFile pickedFile =
    await picker_product.getImage(source: ImageSource.gallery, imageQuality: 50);

    File image_product = File(pickedFile.path);

    setState(() {
      _image_product = image_product;


      print(_image_product);
      print('PICTURE');
    });



    var request = http.MultipartRequest('POST', Uri.parse('https://itpcchennai.com/web_api/public/uploadProductProfileImage'));
    request.fields.addAll({
      'username': widget.Name,
      'signup_id': widget.signupid
    });
    request.files.add(await http.MultipartFile.fromPath('multiple_image', _image_product.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Success');
      Fluttertoast.showToast(
          msg: 'Updated',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
      print(await response.stream.bytesToString());
    }
    else {
      print('failure');
      print(response.reasonPhrase);
    }




  }


  ImagePicker picker_document = ImagePicker();
  _pickImageFromGallery_document() async {


    print('widget.signupid');
    print(widget.signupid);
    print(widget.Name);

    PickedFile pickedFile =
    await picker_document.getImage(source: ImageSource.gallery, imageQuality: 50);

    File image_document = File(pickedFile.path);

    setState(() {
      _image_product = image_document;


      print(_image_document);
      print('PICTURE');
    });



    var request = http.MultipartRequest('POST', Uri.parse('https://itpcchennai.com/web_api/public/uploadCompanyDocument'));
    request.fields.addAll({
      'username': widget.Name,
      'signup_id': widget.signupid
    });
    request.files.add(await http.MultipartFile.fromPath('multiple_image', _image_document.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print('Success');
      Fluttertoast.showToast(
          msg: 'Updated',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
      print(await response.stream.bytesToString());
    }
    else {
      print('failure');
      print(response.reasonPhrase);
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

//  Future<void> uploadprofile(File strprofile) async {
//
//
//    var request = http.MultipartRequest('POST', Uri.parse('https://itpcchennai.com/web_api/public/uploadProfileImage'));
//    request.fields.addAll({
//      'username': signup_name.toString(),
//      'signup_id': widget.signupid.toString()
//    });
//    request.files.add(await http.MultipartFile.fromPath('multiple_image', strprofile.path));
//
//    http.StreamedResponse response = await request.send();
//
//    if (response.statusCode == 200) {
//      print('Success');
//      print(await response.stream.bytesToString());
//    }
//    else {
//      print('failure');
//      print(response.reasonPhrase);
//    }
//
//
//
//  }


//  Future<String> uploadImage(filepath, url) async {
//
//
//    var request = http.MultipartRequest('POST', Uri.parse(url));
//    request.files.add(http.MultipartFile('image',
//        File(filepath).readAsBytes().asStream(), File(filepath).lengthSync(),
//        filename: filepath.split("/").last));
//    var res = await request.send();
//  }


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
            SingleChildScrollView(
              child:
              Stack(
                children: <Widget>[


                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [





                      Container(

                        child:
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 0.0, top: 5, bottom: 0),
                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [





                                GestureDetector(
                                  onTap: () {
                                    _pickImageFromGallery();
                                  }, // Image tapped
                                  child:

                                  Image.network(

                                    signup_img == 'httpsitpcchennai.comprofile_img'? 'http://ecorewick.com/moniespay_api/images/default_profile.png' : signup_img_1
                                    ,  width: 80,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),



                                ),




                                Text('Profile picture' , style: TextStyle(fontSize: 12,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,)),
                                Text('*Below 1 MB' , style: TextStyle(fontSize: 12,color: Color(0xFFD1D4D9), fontWeight: FontWeight.bold,)),

                              ],
                            )
                        ),

                      ),

                      Container(

                        child:
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 0.0, top: 5, bottom: 0),
                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                GestureDetector(
                                  onTap: () {
                                    _pickImageFromGallery_organize();
                                  }, // Image tapped
                                  child:

                                  Image.network(

                                    signup_img1 == 'httpsitpcchennai.comprofile_icon'? 'http://ecorewick.com/moniespay_api/images/default_profile.png' :  signup_img1_1
                                    ,  width: 80,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),



                                ),


                                Text('Organization icon' , style: TextStyle(fontSize: 12,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,)),
                                Text('*Below 1 MB' , style: TextStyle(fontSize: 12,color: Color(0xFFD1D4D9), fontWeight: FontWeight.bold,)),

                              ],
                            )
                        ),

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

//                                  FlatButton(
//                                    onPressed: () => showAlert(context),
//                                    child: Text('Select Category',style: TextStyle(color: Colors.black,  fontFamily: 'Noto Sans'),
//                                      textAlign: TextAlign.left,),
//
//                                    padding: EdgeInsets.only(top: 0, left: 0, right: 170),
//
//
//                                    //padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
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
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 0.0, top: 5, bottom: 0),
                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                GestureDetector(
                                  onTap: () {
                                    _pickImageFromGallery_company();
                                  }, // Image tapped
                                  child:

                                  Image.network(

                                    signup_pdf == 'httpsitpcchennai.comprofile_pdf'? 'http://ecorewick.com/moniespay_api/images/default_profile.png' : signup_pdf_1
                                    ,  width: 80,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),



                                ),





                                Text('Company Profile' , style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,)),
                                Text('*Below 5 MB' , style: TextStyle(fontSize: 12,color: Color(0xFFD1D4D9), fontWeight: FontWeight.bold,)),

                              ],
                            )
                        ),

                      ),
                      Container(

                        child:
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 0.0, top: 5, bottom: 0),
                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                GestureDetector(
                                  onTap: () {
                                    _pickImageFromGallery_product();
                                  }, // Image tapped
                                  child:

                                  Image.network(

                                    signup_pdf1 == 'httpsitpcchennai.comproduct_pdf'? 'http://ecorewick.com/moniespay_api/images/default_profile.png' :  signup_pdf1_1
                                    ,  width: 80,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),



                                ),






                                Text('Product Profile' , style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,)),
                                Text('*Below 5 MB' , style: TextStyle(fontSize: 12,color: Color(0xFFD1D4D9), fontWeight: FontWeight.bold,)),

                              ],
                            )
                        ),

                      ),
                      Container(

                          child:

                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 0.0, top: 5, bottom: 0),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [


                                  GestureDetector(
                                    onTap: () {
                                      _pickImageFromGallery_document();
                                    }, // Image tapped
                                    child:

                                    Image.network(

                                      signup_pdf2 == 'httpsitpcchennai.comcompanydocument_pdf'? 'http://ecorewick.com/moniespay_api/images/default_profile.png' : signup_pdf2_1
                                      ,  width: 80,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    ),



                                  ),

                                  Text('Company Documents' , style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,)),
                                  Text('*Below 5 MB' , style: TextStyle(fontSize: 12,color: Color(0xFFD1D4D9), fontWeight: FontWeight.bold,)),

                                ],
                              )
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
                            onPressed: isEnabled ? ()=> updateprofile() : null,
                            color:  Color(0xFF072331),
                            textColor: Colors.white,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text('Update'),
                          ),
                        )),
                      ),

                    ],
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
