// @dart=2.9



import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itpcchennaiapp/about.dart';
import 'package:itpcchennaiapp/addproduct.dart';
import 'package:itpcchennaiapp/buyerdashboard.dart';
import 'package:itpcchennaiapp/changepassword.dart';
import 'package:itpcchennaiapp/contact.dart';
import 'package:itpcchennaiapp/editproduct.dart';
import 'package:itpcchennaiapp/exportnewsindonesia.dart';
import 'package:itpcchennaiapp/login.dart';
import 'package:itpcchennaiapp/marketbriefdetails.dart';
import 'package:itpcchennaiapp/marketbriefindia.dart';
import 'package:itpcchennaiapp/myprofile.dart';
import 'package:itpcchennaiapp/profile.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
import 'package:itpcchennaiapp/productdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Studentdata {
  String property_id;
  String property_category;
  String property_email;
  String property_title;

  String property_description;
  String property_company;
  String signup_mobile;
  String property_status;
  String property_image;

  Studentdata({
    this.property_id,
    this.property_category,
    this.property_email,
    this.property_title,

    this.property_description,
    this.property_company,
    this.signup_mobile,
    this.property_status,
    this.property_image,
  });

  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(
        property_id: json['property_id'],
        property_category: json['property_category'],
        property_email: json['property_email'],
        property_title: json['property_title'],

        property_description: json['property_description'],
        property_company: json['property_company'],
        signup_mobile: json['signup_mobile'],
        property_status:json['property_status'],
        property_image: json['property_image']


    );
  }
}

class myproducts extends StatefulWidget {


  myproducts({this.userid, this.Type, this.content, this.Name, this.signupid});

  var userid;
  var Type;
  var content;
  var Name;
  var signupid;

  @override

  UserFilterDemoState createState() => UserFilterDemoState();
}
class UserFilterDemoState extends State<myproducts> {


  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final TextEditingController _controller = TextEditingController();
  String selectedSpinnerItem = 'Banana';
  List data = List();
  Future myFuture;

  bool _isLoading = false;
  bool isEnabled = true;

  int _searchtype = 0;

  bool isdata=false;


  @override
  void initState() {
    super.initState();

    print('13032022');
    print(widget.userid);

    myFuture = fetchData();
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

    print('widget.userid');
    print(widget.userid);
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://itpcchennai.com/web_api/public/my_product_list'));
    request.fields.addAll({

      'Start': '0',
      'limit': '200',
      'property_email': widget.userid
    });
    print('3333');

    http.StreamedResponse response = await request.send();
    var decoded = await response.stream.bytesToString().then(json.decode);

    var usersData = decoded['data'];


    print(decoded['data'].toString());
    //   var response = await http.post(Uri.parse(apiURL));

    if (response.statusCode == 200) {
      print('xxxxx000');

      if (decoded['status']==1)
      {


        isdata=true;
      }
      else
      {
        isdata=false;

        Fluttertoast.showToast(
            msg: 'No data found',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,

            backgroundColor: Color(0xFF072331),
            textColor: Colors.white
        );



      }
      print('xxxxx000');



      final items = decoded['data'].cast<Map<String, dynamic>>();
      print('111');

      List<Studentdata> studentList;
      studentList  = items.map<Studentdata>((json) {
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


  Future<void> clearclick(BuildContext context) async {
    try {
      setState(() {
        _searchtype = 0;
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

  void _addproduct() async {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          addproducts(
              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

          )),
    );

  }

  Future<List<dynamic>> productdtls() async {



    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          productdetails(
              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name

          )),
    );



  }

  Future<List<dynamic>> launchedit(String ID,String category, String title, String image, String description) async {

    print('EDIT');
  print(ID);
  print(category);
  print(title);
  print(image);
  print(description);
  print('EDIT');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          editproducts(
              userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,returnProductID:ID.toString(),returncategory: category.toString(),returntitle: title.toString(),returnimage: image.toString(),returndescription: description.toString(),

          )),
    );



  }


  Future<List<dynamic>> launchdelete(String ID) async {


    showAlert(ID.toString());


  }



  Future<List<dynamic>> deleteproduct(String properid) async {


    print('///////**////////');
    print('DELETE');
    print(properid.toString());


    var request = http.MultipartRequest('POST',
        Uri.parse('https://itpcchennai.com/web_api/public/delete_product'));
    request.fields.addAll({

      'property_id': properid.toString()
    });


    http.StreamedResponse response = await request.send();


    print(response.statusCode);


    var decoded = await response.stream.bytesToString().then(json.decode);

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: 'Succes',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );


    }
    myFuture = fetchData();
    return List<Map<String, dynamic>>.from(
        json.decode(await response.stream.bytesToString()));


  }


  showAlert(String ID) {



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
                      height: 100,
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
                                          Text('Are you sure want to delete this product? ', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                                        ),

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
                                          child: Text("Ok", style: const TextStyle(fontSize: 15, color: Colors.blue,)),
                                          onPressed: () {
                                            //Put your code here which you want to execute on Cancel button click.
                                            setState(() {

                                              deleteproduct(ID.toString());
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
        backgroundColor: Color(0xFFE7ECEE),





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
                child: Text('My Products',
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
                    buyerdashbaord(
                        userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

                    )),
              );

            } ,
          ) ,
          backgroundColor: Color(0xFFE7ECEE),
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

            Padding(
              padding: const EdgeInsets.only(
                  left:20.0, right: 10.0, top: 10, bottom: 10),
              child:

              ButtonTheme(
                height: 30.0,
                minWidth: 100,
                child:
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),


                  ),
                  onPressed: isEnabled ? ()=> _addproduct() : null,
                  color:  Color(0xFF072331),
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Text('Add'),
                ),
              ),
            ),

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



                    Container(height: 20,),


                    FutureBuilder<List<Studentdata>>(
                      future: fetchStudents(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData )


                          return Center(
                            // child: CircularProgressIndicator()
                          );





                        return

                          Expanded(
                            child:


                            Padding(
                                padding: const EdgeInsets.only(
                                    left:5.0, right: 10.0, top: 5, bottom: 0),
                                child:

                                ListView(
                                  children: snapshot.data
                                      .map((data) =>




                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left:0.0, right: 0.0, top: 0, bottom: 0),
                                        child:
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child:
                                          ListTile(
                                            title:

                                            Container(
                                              child:

                                              Column(
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [


                                                  Row(

                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 3,
                                                        child:
                                                        Container(

                                                          //color:Color(0xFFD1D4D9),

                                                          child:

                                                          Image.network(

                                                            data.property_image == ''? 'http://ecorewick.com/moniespay_api/images/norecord.png' :  data.property_image == ''?'http://ecorewick.com/moniespay_api/images/norecord.png': data.property_image
                                                            ,  width: 150,
                                                            height: 100,
                                                            fit: BoxFit.cover,
                                                          ),


                                                        ),
                                                      ),


                                                      Expanded(
                                                        flex: 6,
                                                        child:

                                                        Align(
                                                          alignment: Alignment.topLeft,

                                                          child:
                                                          Container(

                                                            height: 100,

                                                            child:
                                                            Padding(
                                                              padding: const EdgeInsets.only(
                                                                  left:10.0, right: 0.0, top: 5, bottom: 0),
                                                              child:
                                                              Column(

                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [

                                                                  Align(
                                                                    alignment: Alignment.topLeft,

                                                                    child:




                                                                    Text(data.property_title,style: TextStyle(fontSize: 14,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,),),
                                                                  ),
                                                                  Container(
                                                                    width: 200,
                                                                    child: Text(
                                                                      data.property_status,
                                                                      overflow: TextOverflow.ellipsis,
                                                                      maxLines: 6,style: TextStyle(fontSize: 12,color: Color(0xFFF04B09),),
                                                                    ),
                                                                  ),

                                                                  ReadMoreText(
                                                                    data.property_description,
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





                                                                ],),
                                                            ),

                                                          ),
                                                        ),


                                                      ),


                                                      Expanded(
                                                        flex: 1,
                                                        child:
                                                        PopupMenuButton(
                                                          itemBuilder: (context) {
                                                            return [
                                                              PopupMenuItem(
                                                                value: 'edit',
                                                                child:


                                                                InkWell(
                                                                    child: new Text('Edit'),
                                                                    onTap: () => launchedit(data.property_id,data.property_category,data.property_title,data.property_image,data.property_description)
                                                                ),


                                                              ),
                                                              PopupMenuItem(
                                                                value: 'delete',
                                                                child:
                                                                InkWell(
                                                                    child: new Text('Delete'),
                                                                    onTap: () =>


                                                                        launchdelete(data.property_id)
                                                                ),
                                                              )
                                                            ];
                                                          },
                                                        ),
                                                      )

                                                    ],
                                                  ),



                                                  Row(

                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 5,
                                                        child:
                                                        Container(

                                                          //color:Color(0xFFD1D4D9),

                                                            child:


                                                            Row(
                                                              children: [
//                                                                Image.asset('images/trusted.png', width: 25, height: 25,),
//                                                                Text('Trusted Seller',style: const TextStyle(
//                                                                    color: Colors.black,
//                                                                    fontSize: 12.0,
//                                                                    fontWeight: FontWeight.bold,
//                                                                    fontFamily: 'Noto Sans'
//                                                                ),),
                                                              ],
                                                            )


                                                        ),
                                                      ),


                                                      Expanded(
                                                        flex: 5,
                                                        child:
                                                        Container(


                                                          child:
                                                          Image.asset('images/like.png',  height: 30,),

                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  Row(

                                                    children: <Widget>[



                                                      Expanded(
                                                        flex: 10,
                                                        child:
                                                        Container(


                                                          child:
                                                          Padding(
                                                            padding: const EdgeInsets.only(
                                                                left:10.0, right: 5.0, top: 0, bottom: 5),
                                                            child:

                                                            ButtonTheme(
                                                              height: 25.0,
                                                              minWidth: 150,
                                                              child:
                                                              RaisedButton(
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: new BorderRadius.circular(5.0),


                                                                ),
                                                                onPressed: isEnabled ? ()=> productdtls() : null,
                                                                color:  Color(0xFF072331),
                                                                textColor: Colors.white,
                                                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                                                child: Text('Send Inquiry'),
                                                              ),
                                                            ),
                                                          ),

                                                        ),
                                                      ),
                                                    ],
                                                  ),



                                                ],),


                                            ),

                                            // trailing:






                                          ),
                                          shadowColor: Colors.black,  //
                                          elevation: 4,  // Change this


                                        ),


                                      )

                                  )
                                      .toList(),
                                )
                            ),

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
}











