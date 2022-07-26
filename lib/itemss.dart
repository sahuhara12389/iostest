// @dart=2.9



import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';


void main() => runApp(items());


class Student {
  final String property_category;
  final int property_id;

  Student({this.property_category, this.property_id});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(property_category: json['property_category'], property_id: json['property_id']);
  }

  // Override toString to have a beautiful log of student object
  @override
  String toString() {
    return 'Student: {property_category = $property_category, property_id = $property_id}';
  }
}

class items extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('JSON ListView with Multiple Text Items')
        ),
        body:


        JsonListView(),
      ),
    );
  }
}



class Studentdata {
  String property_id;
  String property_category;
  String property_email;
  String property_title;

  String property_description;
  String property_company;
  String signup_mobile;
  String image_prop;

  Studentdata({
    this.property_id,
    this.property_category,
    this.property_email,
    this.property_title,

    this.property_description,
    this.property_company,
    this.signup_mobile,
    this.image_prop,
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
        image_prop: json['image_prop']


    );
  }
}


class Data {
//  String property_id;
//  String image_prop;
//  String property_category;
//  String signup_category;
//
//  String property_title;
//  String property_description;
//  String property_image;
//  String property_company;
//
//  String signup_choose;
//  String signup_img;
//  String signup_gst_number;
//  String signup_organation;
//  String signup_name;
//  String signup_email;
//  String signup_mobile;
//  String signup_city;
//
//  String signup_country;
//  String signup_address;
//  String signup_count;
//  String signup_establishment;
//
//  String signup_wdays;
//  String signup_whours;
//  String signup_about;
//  String signup_website;


  String signup_id;
  String signup_choose;

  Data({

    this.signup_id,
  this.signup_choose,
//    this.property_id,
//    this.property_category,
//    this.signup_category,
//
//    this.property_title,
//    this.property_description,
//    this.property_image,
//    this.property_company,
//
//
//
//    this.signup_choose,
//    this.signup_img,
//    this.signup_gst_number,
//    this.signup_organation,
//
//
//    this.signup_name,
//    this.signup_email,
//    this.signup_mobile,
//    this.signup_city,
//
//
//    this.signup_country,
//    this.signup_address,
//    this.signup_count,
//    this.signup_establishment,
//
//
//    this.signup_wdays,
//    this.signup_whours,
//    this.signup_about,
//    this.signup_website,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      signup_id: json['signup_id'],
      signup_choose: json['signup_choose'],
//      property_id: json['property_id'],
//      property_category: json['property_category'],
//
//      signup_category: json['signup_category'],
//
//      property_title: json['property_title'],
//      property_description: json['property_description'],
//      property_image: json['property_image'],
//      property_company: json['property_company'],
//
//
//      signup_choose: json['signup_choose'],
//      signup_img: json['signup_img'],
//      signup_gst_number: json['signup_gst_number'],
//      signup_organation: json['signup_organation'],
//
//      signup_name: json['signup_name'],
//      signup_email: json['signup_email'],
//      signup_mobile: json['signup_mobile'],
//      signup_city: json['signup_city'],
//
//
//
//      signup_country: json['signup_country'],
//      signup_address: json['signup_address'],
//      signup_count: json['signup_count'],
//      signup_establishment: json['signup_establishment'],
//
//
//      signup_wdays: json['signup_wdays'],
//      signup_whours: json['signup_whours'],
//      signup_about: json['signup_about'],
//      signup_website: json['signup_website'],


    );
  }
}
class JsonListView extends StatefulWidget {

  JsonListViewWidget createState() => JsonListViewWidget();

}

class JsonListViewWidget extends State {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final TextEditingController _controller = TextEditingController();
  String selectedSpinnerItem = 'Banana';
  List data = List();
  Future myFuture;

  bool _isLoading = false;
  bool isEnabled = true;

  int _searchtype = 0;












  @override
  void initState() {
    super.initState();


  }


  @override
  void dispose() {
    _controller.dispose();
    EasyLoading.dismiss();
    super.dispose();
  }





  Future<List<Data>> fetchStudents() async {


    var request = http.MultipartRequest('POST', Uri.parse('https://itpcchennai.com/web_api/public/user_profile'));
    request.fields.addAll({

      'signup_id': '415'
    });
    print('3333');

    http.StreamedResponse response = await request.send();
    var decoded = await response.stream.bytesToString().then(json.decode);




    var usersData = decoded['data'];
    print('ppppppp');
    print(usersData);
    String strdata=usersData.toString();
    print('bbbbbbbbb');
    print(strdata);
    strdata= '['+strdata+']';
    print('qqqqqq');
    print(strdata);
    print(usersData);
    print('eeeeeee');
    print(decoded['data'].toString());

    if (response.statusCode == 200) {
      print('zzzzzzzz');





       final items = decoded['data'].cast<Map<String, dynamic>>();

     // final Map<String, dynamic> _result = Uri.splitQueryString(strdata);


      print('RRRRRRRRRRRRR');


      List<Data> studentList = items.map<Data>((json) {
        return Data.fromJson(json);
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
      _searchtype=1;
      EasyLoading.show();
      //Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      fetchStudents();

      EasyLoading.dismiss();
    } catch (error) {
      print(error);
    }
  }


//  void buttonclick() {
//    _searchtype=1;
//    Dialogs.showLoadingDialog(context, _keyLoader);
//
//
//
//  }
  Future<void> dropclick(BuildContext context) async {
    try {
      _searchtype=2;
      EasyLoading.show();
      //Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      fetchStudents();

      EasyLoading.dismiss();

    } catch (error) {
      print(error);
    }
  }
//  void dropclick() {
//    _searchtype=2;
//    Dialogs.showLoadingDialog(context, _keyLoader);
//    fetchStudents();
//
//  }

//  void clearclick() {
//    _searchtype=0;
//    Dialogs.showLoadingDialog(context, _keyLoader);
//    fetchStudents();
//
//  }

  Future<void> clearclick(BuildContext context) async {
    try {
      _searchtype=0;
      EasyLoading.show();
      //Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      fetchStudents();

      EasyLoading.dismiss();
    } catch (error) {
      print(error);
    }
  }


  @override
  Widget build(BuildContext context) {
    return




      Container(

        child:
        Stack(
          children: <Widget>[



            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [




                Container(
                  color:Colors.orange,
                  height: 80,
                  child:
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(
                              left:15.0, right: 0.0, top: 0, bottom: 0),
                          child:
                          Container(
                            height: 40,
                            child:TextField(
                              controller: _controller,

                              onChanged: (value) {
                                // Call setState to update the UI
                                setState(() {});
                              },
                              decoration: InputDecoration(

                                hintText: 'Search here' ,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey
                                    )
                                ),
                                border:  OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors.grey)
                                ),


                                prefixIcon: const Icon(Icons.search,color: Colors.grey,  ),



                              ),
                            ),



                          ),
                        ),
                      ),

                      Expanded(
                        flex: 3,
                        child: Container(

                          child:
                          Padding(
                            padding: const EdgeInsets.only(
                                left:5.0, right: 5.0, top: 0, bottom: 0),
                            child:
                            ButtonTheme(
                              height: 40.0,
                              minWidth: 75,
                              child:
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0),


                                ),
                                onPressed: isEnabled ? ()=> buttonclick(context): null,
                                color:  Color(0xFF072331),
                                textColor: Colors.white,
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text('SEARCH', style: const TextStyle(fontSize: 12, color: Colors.white,)),
                              ),
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),



                Container(
                  color:Colors.green,
                  height: 80,
                  child:
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(
                              left:15.0, right: 0.0, top: 0, bottom: 0),
                          child:
                          Container(
                            height: 48,
                            child:



                            FutureBuilder<String>(
                                future: myFuture,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData)
                                    return
                                      Center(
                                          child:
                                          Container()
                                      );
                                  return

//                                        Scaffold(
//                                        body:

                                    Center(
                                        child:


                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              DropdownButton(
                                                items: data.map((item) {
                                                  return
                                                    DropdownMenuItem(
                                                      child:

                                                      Container(
                                                        width: 200,
                                                        child: Text(
                                                          item['category_type'],
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                        ),
                                                      ),
//                                                        Text(item['category_type'], style: const TextStyle(fontSize: 13, color: Colors.black,),maxLines: 2,
//                                                          overflow: TextOverflow.ellipsis,),


                                                      value: item['category_type'],
                                                    );
                                                }).toList(),
                                                onChanged: (newVal) {
                                                  setState(() {
                                                    selectedSpinnerItem = newVal;
                                                    print('WWWWWWWWWWWWWWWWWW');


                                                    setState(() {
                                                      dropclick(context);
                                                    });

                                                  });
                                                },
                                                value: selectedSpinnerItem,
                                              ),

                                            ]));
                                  // );
                                }),




                          ),
                        ),
                      ),

                      Expanded(
                        flex: 3,
                        child: Container(

                          child:
                          Padding(
                            padding: const EdgeInsets.only(
                                left:5.0, right: 5.0, top: 0, bottom: 0),
                            child:
                            ButtonTheme(
                              height: 45.0,
                              minWidth: 75,
                              child:
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0),


                                ),
                                onPressed: isEnabled ? ()=> clearclick(context) : null,
                                color:  Color(0xFF072331),
                                textColor: Colors.white,
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text('CLEAR FILTER',style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,

                                    fontFamily: 'Noto Sans'
                                ),),
                              ),
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),

                FutureBuilder<List<Data>>(
                  future: fetchStudents(),
                  builder: (context, snapshot) {

                    if (!snapshot.hasData) return Center(
                        child: CircularProgressIndicator()
                    );

                    return

                      Expanded(
                          child:
                          ListView(
                            children: snapshot.data
                                .map((data) => Column(children: <Widget>[
                              GestureDetector(
                                onTap: (){selectedItem(context, data.signup_choose);},
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Padding(
                                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                          child: Text('ID = ' + data.signup_id.toString(),
                                              style: TextStyle(fontSize: 21))),

                                      Padding(
                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                          child: Text('Name = ' + data.signup_choose,
                                              style: TextStyle(fontSize: 21))),



                                    ]),),

                              Divider(color: Colors.black),
                            ],))
                                .toList(),
                          )

                      );

                  },
                )








              ],
            ),



          ],
        ),
      );











  }




}




