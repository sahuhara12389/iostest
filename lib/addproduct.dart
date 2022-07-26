// @dart=2.9


import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itpcchennaiapp/about_buyer.dart';
import 'package:itpcchennaiapp/buyerdashboard.dart';
import 'package:itpcchennaiapp/changepassword_buyer.dart';
import 'package:itpcchennaiapp/contact_buyer.dart';
import 'package:itpcchennaiapp/event_buyer.dart';
import 'package:itpcchennaiapp/exportnewindonesia_buyer.dart';
import 'package:itpcchennaiapp/marketbriefindia_buyer.dart';
import 'package:itpcchennaiapp/myproduct.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path/path.dart';

import 'myprofile_buyer.dart';



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
class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
  });
}
class addproducts extends StatefulWidget {

  addproducts({this.userid, this.Type, this.content, this.Name, this.signupid});

  var userid;
  var Type;
  var content;
  var Name;
  var signupid;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<addproducts> {


  bool isEnabled = true;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController controller = new TextEditingController();

  final TextEditingController _controller = TextEditingController();


  final TextEditingController producttitle = new TextEditingController();
  final TextEditingController companyname = new TextEditingController();
  final TextEditingController productdesc = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  final TextEditingController address = new TextEditingController();
  final TextEditingController city = new TextEditingController();
  final TextEditingController country = new TextEditingController();
  final TextEditingController about = new TextEditingController();
  final TextEditingController website = new TextEditingController();
  List data = List();
  String _mySelection;


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




  List<Asset> imagesList = <Asset>[];
  String _error = 'No Error Dectected';

  bool showSpinner = false  ;

  @override
  void initState() {
    fetchData();
    super.initState();
  }



  Widget buildGridView() {
    return


      GridView.count(
      crossAxisCount: 3,

      children: List.generate(imagesList.length, (index) {
        Asset asset = imagesList[index];
        return
          Padding(
            padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 10, bottom: 10),
        child:




        Container(
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(
              color: Colors.black12,
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.black12
                  ]
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey ,
                    blurRadius: 2.0,
                    offset: Offset(2.0,2.0)
                )
              ]
          ),
          child:AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          )

        ),


          );

      }),
    );


  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 200,
        enableCamera: true,
        selectedAssets: imagesList,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      imagesList = resultList;
      _error = error;
    });
  }

  Future uploadImageToServer(BuildContext context) async {


    print('Add product');
    print(producttitle.text);
    print(_mySelection.toString());
    print(productdesc.text);
    print(companyname.text);
    print(widget.userid);



    try{
      setState(() {
        showSpinner = true ;
      });

      var uri = Uri.parse('https://itpcchennai.com/web_api/public/add_product');
      http.MultipartRequest request = new http.MultipartRequest('POST', uri);

      request.fields['property_title'] = producttitle.text;
      request.fields['property_category'] = _mySelection.toString();
      request.fields['prop_desc'] = productdesc.text;
      request.fields['property_company'] = companyname.text;
      request.fields['signCateg'] = '1';
      request.fields['email'] = widget.userid;



      print('1111111111');


      List<http.MultipartFile> newList = new List<http.MultipartFile>();
      print('22222222');

      for (int i = 0; i < imagesList.length; i++) {
        print('3333333');
        var path = await FlutterAbsolutePath.getAbsolutePath(imagesList[i].identifier);

        print('44444444');
        File imageFile =  File(path);
        print('555555555');
        var stream = new http.ByteStream(imageFile.openRead());
        print('666666666');
        var length = await imageFile.length();
        print('777777777');
        var multipartFile = new http.MultipartFile("multiple_image[]", stream, length,
            filename: basename(imageFile.path));
        print(multipartFile);
        print('888888888');
        newList.add(multipartFile);
      }



      request.files.addAll(newList);
      var response = await request.send();
      print(response.toString()) ;

      String message;
      response.stream.transform(utf8.decoder).listen((value) {
        print('value') ;
        print(value);
        message=value;
      });

      if (response.statusCode == 200) {
        setState(() {
          showSpinner = false ;




        });

        print('uploaded');
        producttitle.text="";
        companyname.text="";
        productdesc.text="";

        Fluttertoast.showToast(
            msg: 'Product added successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,

            backgroundColor: Color(0xFF072331),
            textColor: Colors.white
        );

      } else {
        setState(() {
          showSpinner = false ;
        });
        print('failed');

      }

    }catch(e){
      setState(() {
        showSpinner = false ;
      });
      print(e.toString()) ;





    }


  }




  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child:

      Scaffold(
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
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          buyerdashbaord(
//                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid
//
//                          )),
//                    );
//
//
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
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          myproducts(
//                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid
//
//                          )),
//                    );
//
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
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          myprofile_buyer(
//                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid
//
//                          )),
//                    );
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
//                          event_buyer(
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
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          marketbriefindia_buyer(
//                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid
//
//                          )),
//                    );
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
//                          exportnewindonesia_buyer(
//                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid
//
//                          )),
//                    );
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
//
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          aboutus_buyer(
//                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid
//
//                          )),
//                    );
//
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
//
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          contactus_buyer(
//                              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid
//
//                          )),
//                    );
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
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) =>
//                          changepass_buyer(
//                            userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid,previouspage: 'buyerdashboard',
//
//                          )),
//                    );
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

          leading: GestureDetector(
            child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
            onTap: () {


              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    myproducts(
                        userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

                    )),
              );

            } ,
          ) ,
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



//    Column(
//              children: <Widget>[
//
//
//

//
//
//
//             // Center(child: Text('Error: $_error')),
//                Expanded(
//                  child: buildGridView(),
//                ),
////              ElevatedButton(
////                child: Text("Pick images"),
////                onPressed: loadAssets,
////              ),
////                Expanded(
////                  child: buildGridView(),
////                ),
////                Visibility(
////                  visible: imagesList.isEmpty ? false : true,
////                  child: ElevatedButton(
////                    child: Text("Upload"),
////                    onPressed: ()async {
////                      uploadImageToServer(context);
////                    },
////                  ),
////                ),
//              ],
//            ),
    Container(
    child:
    CustomScrollView(

          slivers: <Widget>[

            SliverList(
              delegate: SliverChildListDelegate(
                [

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




                        DropdownButtonHideUnderline(
                          child:
                          DropdownButton(
                            isExpanded: true,
                            hint: Text("Select Product Category"),
                            items: data.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item['category_type']),
                                value: item['category_id'].toString(),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                _mySelection = newVal;
                              });
                            },
                            value: _mySelection,
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
                    Text('Product Title', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
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
                            Radius.circular(4.0)), // Set rounded corner radius
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
                            controller: producttitle,
                            keyboardType: TextInputType.text,
                            style: new TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.normal),//Enter content color and font size
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
                Align(
                  alignment: Alignment.topLeft,
                  child:
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 15.0, top: 10, bottom: 0),

                    child:
                    Text('Company Name', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
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
                            Radius.circular(4.0)), // Set rounded corner radius
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
                            controller: companyname,
                            keyboardType: TextInputType.text,
                            style: new TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.normal),//Enter content color and font size
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

                Align(
                  alignment: Alignment.topLeft,
                  child:
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 15.0, top: 10, bottom: 0),

                    child:
                    Text('Product Description', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                  ),

                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10, bottom: 0),
                    child:
                    Container(
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(4),


                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color(0xFF072331), // Set border color
                            width: 1.0),   // Set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(4.0)), // Set rounded corner radius
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
                            controller: productdesc,
                            keyboardType: TextInputType.text,
                            style: new TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.normal),//Enter content color and font size
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

                Align(
                  alignment: Alignment.topLeft,
                  child:
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 15.0, top: 10, bottom: 20),

                      child:

                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child:
                            Text('Product Images', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                          ),
                          Expanded(
                            flex: 3,
                            child:

                            GestureDetector(
                              onTap: (){
                                loadAssets();
                              } ,
                              child: Container(
                                height: 30,
                                color: Colors.white,
                                child: DottedBorder(
                                  color: Colors.grey,
                                  strokeWidth: 2 ,
                                  radius: Radius.circular(8),
                                  dashPattern: [8,4],
                                  child:
                                  Center(
                                    child:
                                    ClipRect(
                                      child: Container(
                                          height: 30,
                                          width: 50,
                                          child:
                                          Center(
                                            child: Icon(Icons.add),
                                          )



                                      ),
                                    ),
                                  ),
                                ) ,
                              ),
                            ),
                          )
                        ],
                      )




                  ),

                ),









                ],
              ),
            ),


//            Column(
//              children: <Widget>[

//                Align(
//                  alignment: Alignment.topLeft,
//                  child:
//                  Padding(
//                    padding: const EdgeInsets.only(
//                        left: 20.0, right: 15.0, top: 0, bottom: 0),
//                    child:
//                    Text('Product Category', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
//                  ),
//
//                ),
//                Padding(
//                    padding: const EdgeInsets.only(
//                        left: 20.0, right: 20.0, top: 10, bottom: 0),
//                    child:
//                    Container(
//                      margin: EdgeInsets.all(0),
//                      padding: EdgeInsets.all(8),
//
//
//                      decoration: BoxDecoration(
//                        color: Colors.white,
//                        border: Border.all(
//                            color: Color(0xFF072331), // Set border color
//                            width: 1.0),   // Set border width
//                        borderRadius: BorderRadius.all(
//                            Radius.circular(10.0)), // Set rounded corner radius
//                        //  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
//                      ),
//                      child:
//                      SizedBox(
//                        height: 33.0,
//
//                        child:
//
//
//
//
//                        DropdownButtonHideUnderline(
//                          child:
//                          DropdownButton(
//                            isExpanded: true,
//                            hint: Text("Select Product Category"),
//                            items: data.map((item) {
//                              return new DropdownMenuItem(
//                                child: new Text(item['category_type']),
//                                value: item['category_id'].toString(),
//                              );
//                            }).toList(),
//                            onChanged: (newVal) {
//                              setState(() {
//                                _mySelection = newVal;
//                              });
//                            },
//                            value: _mySelection,
//                          ),
//
//                        ),
//
//
//                      ),
//                    )
//
//                ),
//
//                Align(
//                  alignment: Alignment.topLeft,
//                  child:
//                  Padding(
//                    padding: const EdgeInsets.only(
//                        left: 25.0, right: 15.0, top: 10, bottom: 0),
//
//                    child:
//                    Text('Product Title', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
//                  ),
//
//                ),
//                Padding(
//                    padding: const EdgeInsets.only(
//                        left: 20.0, right: 20.0, top: 10, bottom: 0),
//                    child:
//                    Container(
//                      margin: EdgeInsets.all(0),
//                      padding: EdgeInsets.all(8),
//
//
//                      decoration: BoxDecoration(
//                        color: Colors.white,
//                        border: Border.all(
//                            color: Color(0xFF072331), // Set border color
//                            width: 1.0),   // Set border width
//                        borderRadius: BorderRadius.all(
//                            Radius.circular(4.0)), // Set rounded corner radius
//                        //  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
//                      ),
//                      child:
//                      SizedBox(
//                        height: 33.0,
//
//                        child:
//
//                        Container(
//                          color: Color(0xFFffffff),
//                          child:
//                          TextFormField(
//                            controller: producttitle,
//                            keyboardType: TextInputType.text,
//                            style: new TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold),//Enter content color and font size
//                            obscureText: false,
////                                                        decoration: InputDecoration(
////                                                          filled: true,
////
////                                                          hintText: '10 Digit Mobile Number',
////                                                          hintStyle: TextStyle(color: Color(0xFFE6E9EB),fontSize: 20.0,fontWeight: FontWeight.bold),
////
////                                                        ),
//
//                            decoration: InputDecoration(
//                              border: InputBorder.none,
//                              filled: true,
//                              fillColor:Color(0xFFffffff),
//
//                              hintStyle: TextStyle(color: Color(0xFFC3C9CD),fontSize: 15.0,fontWeight: FontWeight.normal),
//                              //                                  enabledBorder: OutlineInputBorder(
//                              //                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                              //                                    borderSide: BorderSide(color: Colors.blue, width: 1),
//                            ),
//
////                                validator: MultiValidator([
////                                  RequiredValidator(errorText: "* Required"),
////
////
////                                ])
//                            //validatePassword,        //Function to check validation
//                          ),
//                        ),
//
//
//
//
//
//
//                      ),
//                    )
//
//                ),
//                Align(
//                  alignment: Alignment.topLeft,
//                  child:
//                  Padding(
//                    padding: const EdgeInsets.only(
//                        left: 25.0, right: 15.0, top: 10, bottom: 0),
//
//                    child:
//                    Text('Company Name', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
//                  ),
//
//                ),
//
//                Padding(
//                    padding: const EdgeInsets.only(
//                        left: 20.0, right: 20.0, top: 10, bottom: 0),
//                    child:
//                    Container(
//                      margin: EdgeInsets.all(0),
//                      padding: EdgeInsets.all(8),
//
//
//                      decoration: BoxDecoration(
//                        color: Colors.white,
//                        border: Border.all(
//                            color: Color(0xFF072331), // Set border color
//                            width: 1.0),   // Set border width
//                        borderRadius: BorderRadius.all(
//                            Radius.circular(4.0)), // Set rounded corner radius
//                        //  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
//                      ),
//                      child:
//                      SizedBox(
//                        height: 33.0,
//
//                        child:
//
//                        Container(
//                          color: Color(0xFFffffff),
//                          child:
//                          TextFormField(
//                            controller: companyname,
//                            keyboardType: TextInputType.text,
//                            style: new TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold),//Enter content color and font size
//                            obscureText: false,
////                                                        decoration: InputDecoration(
////                                                          filled: true,
////
////                                                          hintText: '10 Digit Mobile Number',
////                                                          hintStyle: TextStyle(color: Color(0xFFE6E9EB),fontSize: 20.0,fontWeight: FontWeight.bold),
////
////                                                        ),
//
//                            decoration: InputDecoration(
//                              border: InputBorder.none,
//                              filled: true,
//                              fillColor:Color(0xFFffffff),
//
//                              hintStyle: TextStyle(color: Color(0xFFC3C9CD),fontSize: 15.0,fontWeight: FontWeight.normal),
//                              //                                  enabledBorder: OutlineInputBorder(
//                              //                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                              //                                    borderSide: BorderSide(color: Colors.blue, width: 1),
//                            ),
//
////                                validator: MultiValidator([
////                                  RequiredValidator(errorText: "* Required"),
////
////
////                                ])
//                            //validatePassword,        //Function to check validation
//                          ),
//                        ),
//
//
//
//
//
//
//
//                      ),
//                    )
//
//                ),
//
//                Align(
//                  alignment: Alignment.topLeft,
//                  child:
//                  Padding(
//                    padding: const EdgeInsets.only(
//                        left: 25.0, right: 15.0, top: 10, bottom: 0),
//
//                    child:
//                    Text('Product Description', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
//                  ),
//
//                ),
//                Padding(
//                    padding: const EdgeInsets.only(
//                        left: 20.0, right: 20.0, top: 10, bottom: 0),
//                    child:
//                    Container(
//                      margin: EdgeInsets.all(0),
//                      padding: EdgeInsets.all(8),
//
//
//                      decoration: BoxDecoration(
//                        color: Colors.white,
//                        border: Border.all(
//                            color: Color(0xFF072331), // Set border color
//                            width: 1.0),   // Set border width
//                        borderRadius: BorderRadius.all(
//                            Radius.circular(4.0)), // Set rounded corner radius
//                        //  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
//                      ),
//                      child:
//                      SizedBox(
//                        height: 75.0,
//
//                        child:
//
//                        Container(
//                          color: Color(0xFFffffff),
//                          child:
//                          TextFormField(
//                            controller: productdesc,
//                            keyboardType: TextInputType.text,
//                            style: new TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),//Enter content color and font size
//                            obscureText: false,
////                                                        decoration: InputDecoration(
////                                                          filled: true,
////
////                                                          hintText: '10 Digit Mobile Number',
////                                                          hintStyle: TextStyle(color: Color(0xFFE6E9EB),fontSize: 20.0,fontWeight: FontWeight.bold),
////
////                                                        ),
//
//                            decoration: InputDecoration(
//                              border: InputBorder.none,
//                              filled: true,
//                              fillColor:Color(0xFFffffff),
//
//                              hintStyle: TextStyle(color: Color(0xFFC3C9CD),fontSize: 15.0,fontWeight: FontWeight.normal),
//                              //                                  enabledBorder: OutlineInputBorder(
//                              //                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                              //                                    borderSide: BorderSide(color: Colors.blue, width: 1),
//                            ),
//
////                                validator: MultiValidator([
////                                  RequiredValidator(errorText: "* Required"),
////
////
////                                ])
//                            //validatePassword,        //Function to check validation
//                          ),
//                        ),
//
//
//
//
//
//
//
//                      ),
//                    )
//
//                ),
//
//                Align(
//                  alignment: Alignment.topLeft,
//                  child:
//                  Padding(
//                      padding: const EdgeInsets.only(
//                          left: 25.0, right: 15.0, top: 10, bottom: 20),
//
//                      child:
//
//                      Row(
//                        children: [
//                          Expanded(
//                            flex: 7,
//                            child:
//                            Text('Product Images', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
//                          ),
//                          Expanded(
//                            flex: 3,
//                            child:
//
//                            GestureDetector(
//                              onTap: (){
//                                loadAssets();
//                              } ,
//                              child: Container(
//                                height: 30,
//                                color: Colors.white,
//                                child: DottedBorder(
//                                  color: Colors.grey,
//                                  strokeWidth: 2 ,
//                                  radius: Radius.circular(8),
//                                  dashPattern: [8,4],
//                                  child:
//                                  Center(
//                                    child:
//                                    ClipRect(
//                                      child: Container(
//                                          height: 30,
//                                          width: 50,
//                                          child:
//                                          Center(
//                                            child: Icon(Icons.add),
//                                          )
//
//
//
//                                      ),
//                                    ),
//                                  ),
//                                ) ,
//                              ),
//                            ),
//                          )
//                        ],
//                      )
//
//
//
//
//                  ),
//
//                ),
        SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
           // crossAxisCount: 1

          crossAxisCount: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 150, // here set custom Height You Want

        ),
          delegate: SliverChildListDelegate(
            [
                buildGridView(),


            ],
          ),
        ),



            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 0.0, top: 10, bottom: 0),
                    child:
                    Center(child:ButtonTheme(
                      height: 45.0,
                      minWidth: 150,
                      child:
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),


                        ),

                        onPressed: ()async {
                          uploadImageToServer(context);
                        },
                        color:  Color(0xFF072331),
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Text('Submit'),
                      ),
                    )),
                  ),



                ],
              ),
            ),










//              ],
//            )


            ],
        )
   // ),
    ),

      ),
    );
  }
}