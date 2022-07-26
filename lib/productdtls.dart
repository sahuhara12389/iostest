// @dart=2.9



import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:itpcchennaiapp/sellerdashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'package:path/path.dart' as p;




class productdls extends StatefulWidget {
  productdls({this.userid, this.Type, this.content, this.Name, this.signupid, this.CatID});

  var userid;
  var Type;
  var content;
  var Name;
  var signupid;
  var CatID;

  @override

  UserFilterDemoState createState() => UserFilterDemoState();
}
class UserFilterDemoState extends State<productdls> {

  bool rememberMe = true;
  bool rememberMe2 = true;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final TextEditingController _controller = TextEditingController();





  String property_company1="";
  String signup_organation1="";
  String signup_city1="";
  String signup_country1="";
  String property_title1="";
  String property_category1="";
  String signup_count1="";
  String signup_establishment1="";
  String signup_wdays1="";
  String signup_whours1="";
  String signup_mobile1="";
  String signup_email1="";
  String signup_address1="";
  String signup_category1="";
  String signup_name1="";

  String ondate;

  final TextEditingController about = new TextEditingController();
  final TextEditingController mobile = new TextEditingController();
  final TextEditingController commodityname = new TextEditingController();
  final TextEditingController hscode = new TextEditingController();
  final TextEditingController quantity = new TextEditingController();
  final TextEditingController email = new TextEditingController();

  Future<List<Studentdata>> futureAlbum;


  void _onRememberMeChanged(bool newValue) => setState(() {
    rememberMe = newValue;

    if (rememberMe) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
  });
  void _onRememberMeChanged2(bool newValue) => setState(() {
    rememberMe2 = newValue;

    if (rememberMe2) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
  });
  String selectedSpinnerItem = 'Banana';
  List data = List();
  Future myFuture;

  bool _isLoading = false;
  bool isEnabled = true;

  int _searchtype = 0;
  bool isPerformingRequest = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {

    super.initState();
    var now = new DateTime.now();
    ondate=now.toString();
    print('ondate');
    String result = "Activated carbon,";
    result= result.substring(0, result.length - 1);
    print(result);


    print(ondate);
    futureAlbum = fetchStudentsdata();

  }


  @override
  void dispose() {

    EasyLoading.dismiss();
    super.dispose();
  }

  Future<List<Studentdata>> fetchStudents() async {


    var request = http.MultipartRequest(
        'POST', Uri.parse('https://itpcchennai.com/web_api/public/SingleProduct'));
    request.fields.addAll({
      'property_id': widget.CatID

    });
    print('3333');

    http.StreamedResponse response = await request.send();
    var decoded = await response.stream.bytesToString().then(json.decode);


    if (response.statusCode == 200) {




      print('000');
      final items = decoded['postimage'].cast<Map<String, dynamic>>();
      print(decoded['postimage']);
      print('111');

      // images=items;

     // final dataitem = decoded['data'].cast<Map<String, dynamic>>();

      List<Studentdata> studentList = items.map<Studentdata>((json) {
        return Studentdata.fromJson(json);
      }).toList();


//
//
//
//      List<Data> DataList = dataitem.map<Data>((json) {
//        return Data.fromJson(json);
//      }).toList();
//
//
//
//      print('66666');
//      String data2 = usersDataFromJson.toString();
//      print(data2.toString());
//      print('777');
//      List<String> stri = usersDataFromJson.split(':');
//
//      String  property_id = stri[0].replaceAll("property_id", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      print(property_id);
//
////      String  part1 = stri[0];
//      print('QQQQQQ');
//      print(part1);
//      List<String> part1_Array = part1.split(",");
//
//      String  property_id = part1_Array[0].replaceAll("property_id", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//      print('property_id');
//      print(property_id);
//      String  property_category = part1_Array[1].replaceAll("property_category", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//      print('property_category');
//      print(property_category);
//
//      String  property_email = part1_Array[2].replaceAll("property_email", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//      print('property_email');
//      print(property_email);

//
//      print('property_id');
//      print(property_id);
//      String  property_category = stri[0].replaceAll("property_category", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//      print('property_category');
//      print(property_category);
//      signup_category.text=property_category.toString();
//
//      String  property_email = stri[5].replaceAll("property_email", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//      print('property_email');
//      print(property_email);
//      signup_email.text=property_email.toString();

//      String  signup_category = stri[7].replaceAll("signup_category", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  property_title = stri[9].replaceAll("property_title", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  property_description = stri[11].replaceAll("property_description", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  property_image = stri[13].replaceAll("property_image", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  property_company = stri[15].replaceAll("property_company", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_choose = stri[17].replaceAll("signup_choose", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_img = stri[19].replaceAll("signup_img", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_gst_number = stri[21].replaceAll("signup_gst_number", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_organation = stri[23].replaceAll("signup_organation", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_name = stri[25].replaceAll("signup_name", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_email = stri[27].replaceAll("signup_email", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_mobile = stri[29].replaceAll("signup_mobile", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_city = stri[31].replaceAll("signup_city", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_country = stri[33].replaceAll("signup_country", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_address = stri[35].replaceAll("signup_address", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//
//      String  signup_count = stri[37].replaceAll("signup_count", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_establishment = stri[39].replaceAll("signup_establishment", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_wdays = stri[41].replaceAll("signup_wdays", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_whours = stri[43].replaceAll("signup_whours", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_about = stri[45].replaceAll("signup_about", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_website = stri[47].replaceAll("signup_website", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");




      return studentList;
    }
    else {
      throw Exception('Failed to load data from Server.');
    }
  }



  Future<List<Studentdata>> fetchStudentsdata() async {


    var request = http.MultipartRequest(
        'POST', Uri.parse('https://itpcchennai.com/web_api/public/SingleProduct'));
    request.fields.addAll({
      'property_id': widget.CatID

    });
    print('3333');

    http.StreamedResponse response = await request.send();
    var decoded = await response.stream.bytesToString().then(json.decode);


    if (response.statusCode == 200) {





      print('E111111');

      List<Studentdata> studentList;



      var usersDataFromJson = {decoded['data']};
      print('66666');
      String data2 = usersDataFromJson.toString();
      print(data2.toString());
      print('777');
      List<String> stri = data2.split("property_description");

      String  temp0 = stri[0].replaceAll("property_category", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "");

      print(temp0);
      print('temp0');

      List<String> Rtemp0 = temp0.split(":");


      String  property_id = Rtemp0[1].replaceAll("property_id", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(",", "");
      property_id= property_id.substring(1);
      print(property_id);
      print('property_id');


      String  property_category = Rtemp0[2].replaceAll("property_email", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "");
      property_category= property_category.substring(1);
      property_category1=property_category.toString();


      String result = property_category1.toString();
      property_category1= result.substring(0, result.length - 2);
      print('property_category---1');
      print(property_category1);

      print(property_category);
      print('property_category');

      String  property_email = Rtemp0[3].replaceAll("signup_category", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(",", "");
      property_email= property_email.substring(1);
      print(property_email);
      print('property_email');


      String  signup_category = Rtemp0[4].replaceAll("property_title", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "");
      signup_category= signup_category.substring(1);
      signup_category1=signup_category;





      print(signup_category1);
      print('signup_category');


      String  property_title = Rtemp0[5].replaceAll("property_title", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(",", "");

      print(property_title);
      print('property_title');





      String  temp1 = stri[1].replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "");


      print(temp1);
      print('temp1');





//

//      String  property_image = Npart2[1].replaceAll("signup_category", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "");
//
//      print(property_image);
//      print('property_image');


      List<String> Npart3 = temp1.split("property_company");

      String  tempproperty_image1 = Npart3[0].replaceAll("signup_category", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "");

      print(tempproperty_image1);
      print('tempproperty_image1');

      List<String> Npart4 = tempproperty_image1.split("property_image");

      String  property_image = Npart4[1].replaceAll("signup_category", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "");

      print(property_image);
      print('property_image');

      List<String> Npart2 = temp1.split("property_company");

      String  property_company_temp = Npart2[1].replaceAll("property_company", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "");

      print(property_company_temp);
      print('property_company_temp');

      List<String> Npart5 = property_company_temp.split(":");
//
//
      String  property_company = Npart5[1].replaceAll("signup_choose", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(",", "");
      property_company= property_company.substring(1);
      property_company1=property_company;
      print(property_company);
       print('property_company');



      String  signup_choose = Npart5[2].replaceAll("signup_img", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "");
      signup_choose= signup_choose.substring(1);
      print(signup_choose);
      print('signup_choose');

      String  signup_img = Npart5[4].replaceAll("signup_gst_number", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "");
      signup_img="https:"+signup_img;
      print(signup_img);
      print('signup_img');



      String  signup_gst_number = Npart5[5].replaceAll("signup_organation", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(",", "");
      signup_gst_number= signup_gst_number.substring(1);
      print(signup_gst_number);
      print('signup_gst_number');



      String  signup_organation = Npart5[6].replaceAll("signup_name", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(",", "");
      signup_organation= signup_organation.substring(1);
      print(signup_organation);
      print('signup_organation');


      String  signup_name = Npart5[7].replaceAll("signup_email", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(",", "");
      signup_name= signup_name.substring(1);
      signup_name1=signup_name;
      print(signup_name);
      print('signup_name');



      String  signup_email = Npart5[8].replaceAll("signup_mobile", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(",", "");
      signup_email= signup_email.substring(1);
      signup_email1=signup_email;
      print(signup_email);
      print('signup_email');


      String  signup_mobile = Npart5[9].replaceAll("signup_city", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(",", "");
      signup_mobile= signup_mobile.substring(1);
      signup_mobile1=signup_mobile;
      print(signup_mobile);
      print('signup_mobile');


      String  signup_city = Npart5[10].replaceAll("signup_country", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(",", "");
      signup_city= signup_city.substring(1);
      print(signup_city);
      print('signup_city');



      String  signup_country = Npart5[11].replaceAll("signup_address", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "");
      signup_country= signup_country.substring(1);
      print(signup_country);
      print('signup_country');



      String  signup_address = Npart5[12].replaceAll("signup_count", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "");
      signup_address= signup_address.substring(1);
      signup_address1=signup_address;
      print(signup_address);
      print('signup_address');



      String  signup_count = Npart5[13].replaceAll("signup_establishment", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(",", "");
      signup_count= signup_count.substring(1);
      signup_count1=signup_count;
      print(signup_count);
      print('signup_count');


      String  signup_establishment = Npart5[14].replaceAll("signup_wdays", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(",", "");
      signup_establishment= signup_establishment.substring(1);
      signup_establishment1=signup_establishment;
      print(signup_establishment);
      print('signup_establishment');


      String  signup_wdays = Npart5[15].replaceAll("signup_whours", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(",", "");


      signup_wdays= signup_wdays.substring(1);
      signup_wdays1=signup_wdays;
      print(signup_wdays);
      print('signup_wdays');



      String  signup_whours = Npart5[16].replaceAll("signup_about", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(",", "");
      signup_whours= signup_whours.substring(1);
      signup_whours1=signup_whours;
      print(signup_whours);
      print('signup_whours');



      String  signup_about = Npart5[17].replaceAll("signup_website", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(" ", "");

      print(signup_about);
      print('signup_about');

      String  signup_website = Npart5[18].replaceAll("signup_website", "").replaceAll(
          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "").replaceAll(" ", "").replaceAll(",", "");

      print(signup_website);
      print('signup_website');





//
//
//      String  signup_count = Npart5[12].replaceAll("signup_count", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "");
//
//      print(signup_count);
//      print('signup_count');
//
//
//
//      String  signup_establishment = Npart5[13].replaceAll("signup_wdays", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "");
//
//      print(signup_establishment);
//      print('signup_establishment');
//
//      String  signup_wdays = Npart5[14].replaceAll("signup_whours", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "");
//
//      print(signup_wdays);
//      print('signup_wdays');
//
//
//      String  signup_whours = Npart5[15].replaceAll("signup_about", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "");
//
//      print(signup_whours);
//      print('signup_whours');
//
//      String  signup_website = Npart5[16].replaceAll("signup_about", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "");
//
//      print(signup_website);
//      print('signup_website');























//
//
//      String  property_description = stri[6].replaceAll("property_image", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "");
//
//      print(property_description);
//      print('property_description');
//
//
//
//
//      String  property_image = stri[8].replaceAll("property_company", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "");
//
//      print(property_image);
//      print('property_image');


//      print('E222222');
//     String usersDataFromJson= decoded['data'];
//      print(usersDataFromJson.toString());
//      print('E333333');
//      List<String> stri = usersDataFromJson.split(":");
//      print('E444444');
//      String  property_id = stri[0].replaceAll("property_id", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      print(property_id);
//      print('E55555');

//
//
//
//      List<Data> DataList = dataitem.map<Data>((json) {
//        return Data.fromJson(json);
//      }).toList();
//
//
//
//      print('66666');
//      String data2 = usersDataFromJson.toString();
//      print(data2.toString());
//      print('777');
//      List<String> stri = usersDataFromJson.split(':');
//
//      String  property_id = stri[0].replaceAll("property_id", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      print(property_id);
//
////      String  part1 = stri[0];
//      print('QQQQQQ');
//      print(part1);
//      List<String> part1_Array = part1.split(",");
//
//      String  property_id = part1_Array[0].replaceAll("property_id", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//      print('property_id');
//      print(property_id);
//      String  property_category = part1_Array[1].replaceAll("property_category", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//      print('property_category');
//      print(property_category);
//
//      String  property_email = part1_Array[2].replaceAll("property_email", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//      print('property_email');
//      print(property_email);

//
//      print('property_id');
//      print(property_id);
//      String  property_category = stri[0].replaceAll("property_category", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//      print('property_category');
//      print(property_category);
//      signup_category.text=property_category.toString();
//
//      String  property_email = stri[5].replaceAll("property_email", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//      print('property_email');
//      print(property_email);
//      signup_email.text=property_email.toString();

//      String  signup_category = stri[7].replaceAll("signup_category", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  property_title = stri[9].replaceAll("property_title", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  property_description = stri[11].replaceAll("property_description", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  property_image = stri[13].replaceAll("property_image", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  property_company = stri[15].replaceAll("property_company", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_choose = stri[17].replaceAll("signup_choose", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_img = stri[19].replaceAll("signup_img", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_gst_number = stri[21].replaceAll("signup_gst_number", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_organation = stri[23].replaceAll("signup_organation", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_name = stri[25].replaceAll("signup_name", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_email = stri[27].replaceAll("signup_email", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_mobile = stri[29].replaceAll("signup_mobile", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_city = stri[31].replaceAll("signup_city", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_country = stri[33].replaceAll("signup_country", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_address = stri[35].replaceAll("signup_address", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//
//      String  signup_count = stri[37].replaceAll("signup_count", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_establishment = stri[39].replaceAll("signup_establishment", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//
//      String  signup_wdays = stri[41].replaceAll("signup_wdays", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_whours = stri[43].replaceAll("signup_whours", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_about = stri[45].replaceAll("signup_about", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");
//
//      String  signup_website = stri[47].replaceAll("signup_website", "").replaceAll(
//          "{", "").replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "").replaceAll(" ", "");




      return studentList;
    }
    else {
      throw Exception('Failed to load data from Server.');
    }
  }

  void submitinquery1() async {
    if(about.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter Description',
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
    else  if(commodityname.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter Commodity',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
    }
    else  if(hscode.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter Hs Code',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
    }
    else  if(quantity.text == '') {
      Fluttertoast.showToast(
          msg: 'Enter Quantity',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,

          backgroundColor: Color(0xFF072331),
          textColor: Colors.white
      );
    }
    else
      {

        submitinquery();
      }
  }

  Future<List<dynamic>> submitinquery() async {



    print('///////**////////');

      print(property_category1.toString());
      print(about.text);
      print(email.text);
      print(signup_email1.toString());
      print(ondate.toString());
      print(commodityname.text);
      print(hscode.text);
      print(quantity.text);
      print(mobile.text);
      print('///////**////////');

      var request = http.MultipartRequest('POST', Uri.parse('https://itpcchennai.com/web_api/public/enquiry_insert'));
      request.fields.addAll({
        'user_category': property_category1.toString(),
        'msg': about.text,
        'email': email.text,
        'mailto': signup_email1.toString(),
        'mob': mobile.text,
        'date': ondate.toString(),
        'commodity_name': commodityname.toString(),
        'hs_code': hscode.text,
        'quantity': quantity.text,
        'mob': mobile.text
      });


      http.StreamedResponse response = await request.send();


      print(response.statusCode);


      var decoded = await response.stream.bytesToString().then(json.decode);

      if (response.statusCode == 200) {


        print({decoded['status']});
        print({decoded['message']});
        String strmsg= decoded['message'];

          if(decoded['status']=="1") {


            about.text="";
            email.text="";
            commodityname.text="";
            hscode.text="";
            quantity.text="";
            mobile.text="";



            Fluttertoast.showToast(
                msg: 'Inquiery Mail Sent',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,

                backgroundColor: Color(0xFF072331),
                textColor: Colors.white
            );
          }
          else{
            Fluttertoast.showToast(
                msg: decoded['message'],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,

                backgroundColor: Color(0xFF072331),
                textColor: Colors.white
            );
          }

      }


      return List<Map<String, dynamic>>.from(json.decode(await response.stream.bytesToString()));





  }


  // to show progressbar while loading data in background
  Widget _buildProgressIndicator() {
    return new

    BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Center(
            child: new Opacity(
              opacity: isPerformingRequest ? 1.0 : 0.0,
              child: new CircularProgressIndicator(),
            ),
          ),
        )
    );

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
    return MaterialApp(
      home: Scaffold(
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
                child: Text('Product Details',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.left,),
              )



            ],
          ),
          backgroundColor: Colors.white,
          leading: GestureDetector(
            child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
            onTap: () {


              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    sellerdashbaord(
                        userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

                    )),
              );

            } ,
          ) ,
        ),
        body: new

        FutureBuilder<List<Studentdata>>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return



                ListView(
                  children: [

                    Padding(
                        padding: const EdgeInsets.only(
                            left:15.0, right: 15.0, top: 5, bottom: 0),
                        child:

                        Container(
                          height: 100,
                          child: Row(

                            children: [
                              Expanded(
                                flex: 3,
                                child:
                                Container(
                                  child:  Image.asset('images/norecord.png',),

                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child:

                                Padding(
                                  padding: const EdgeInsets.only(
                                      left:15.0, right: 0.0, top: 10, bottom: 0),
                                  child:

                                  Container(
                                    child: Column(

                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(property_company1,style: TextStyle(fontSize: 18,color: Color(0xFF4689F6), fontWeight: FontWeight.bold,),),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left:0.0, right: 0.0, top: 5, bottom: 0),
                                          child:
                                          Row(
                                            children: [

                                              Icon(Icons.location_on),
                                              Text(signup_address1 ,style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,),),


                                            ],
                                          ),
                                        ),

                                        Row(
                                          children: [

                                            Text('Categories: ',style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                                            Text(

                                               property_category1

                                               ,style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),

                                          ],
                                        ),

                                      ],
                                    ),

                                  ),
                                ),

                              ),

                            ],
                          ),

                        )



                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left:15.0, right: 15.0, top: 5, bottom: 0),
                        child:
                        Container(
                          height: 50,
                          child:

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Icon(Icons.account_circle),
                              Text('Seller Profile',style: TextStyle(fontSize: 18,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,),),


                            ],
                          ),


                        )
                    ),



                    Padding(
                      padding: const EdgeInsets.only(
                          left:5.0, right: 1.0, top: 10, bottom: 0),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 70,
                            width: 120,
                            child:  Text("Business Type:"),
                          ),
                          Expanded(
                            child: Text(signup_category1,style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                          ),
                        ],
                      ),




                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left:5.0, right: 1.0, top: 10, bottom: 0),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left:5.0, right: 1.0, top: 0, bottom: 0),
                            child:
                            SizedBox(
                              height: 20,
                              width: 120,
                              child:  Text("Employee Count: "),
                            ),
                          ),

                          Expanded(
                            child: Text(signup_count1),
                          ),
                        ],
                      ),




                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left:5.0, right: 1.0, top: 10, bottom: 0),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left:5.0, right: 1.0, top: 0, bottom: 0),
                            child:
                            SizedBox(
                              height: 20,
                              width: 120,
                              child:  Text("Working Days: "),
                            ),
                          ),
                          Expanded(
                            child: Text(signup_wdays1),
                          ),
                        ],
                      ),




                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left:5.0, right: 1.0, top: 10, bottom: 0),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left:5.0, right: 1.0, top: 0, bottom: 0),
                            child:
                            SizedBox(
                              height: 20,
                              width: 120,
                              child:  Text("Working Hours: "),
                            ),
                          ),
                          Expanded(
                            child: Text(signup_whours1),
                          ),
                        ],
                      ),




                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left:5.0, right: 1.0, top: 10, bottom: 0),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left:5.0, right: 1.0, top: 0, bottom: 0),
                            child:
                            SizedBox(
                              height: 20,
                              width: 120,
                              child:  Text("Contact Number: "),
                            ),
                          ),
                          Expanded(
                              child:

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[

                                  Icon(Icons.call),
                                  Text(signup_mobile1)
                                ],
                              )

                          ),
                        ],
                      ),




                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left:15.0, right: 15.0, top: 5, bottom: 0),
                        child:
                        Container(
                          height: 50,
                          child:

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Icon(Icons.work),
                              Text('Products & Services',style: TextStyle(fontSize: 18,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,),),


                            ],
                          ),


                        )
                    ),

                    Expanded(
                        child:

                        FutureBuilder<List<Studentdata>>(
                          future: fetchStudents(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return

                              Center(
                                 child: _buildProgressIndicator()
                              );

                            return


                              GridView.builder(
                                itemCount: snapshot.data.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true, // use it
                                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                                itemBuilder: (BuildContext context, int index) {
                                  return new

                                  // Text('c');
                                  GestureDetector(
                                      child: Cell(snapshot.data[index]),
                                      onTap: () => {}
                                    //gridClicked(index),
                                  );
                                },
                              );









                          },
                        )



                    ),


                    Padding(
                        padding: const EdgeInsets.only(
                            left:15.0, right: 15.0, top: 5, bottom: 0),
                        child:
                        Container(
                          height: 50,
                          child:

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Icon(Icons.markunread),
                              Text('Contact Details',style: TextStyle(fontSize: 18,color: Color(0xFF0F1C51), fontWeight: FontWeight.bold,),),


                            ],
                          ),


                        )
                    ),



                    Padding(
                        padding: const EdgeInsets.only(
                            left:15.0, right: 15.0, top: 5, bottom: 0),
                        child: Container(

                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(property_company1,style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                              Text(signup_name1,style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                              Text(signup_mobile1,style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                              Text(signup_email1,style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                              Text(signup_address1,style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),

                            ],
                          ),
                        )

                    ),



                    Padding(
                      padding: const EdgeInsets.only(
                          left:15.0, right: 15.0, top: 15, bottom: 10),
                      child: Text("Categories",style: TextStyle(fontSize: 15,color: Color(0xFFEF5545), fontWeight: FontWeight.normal,),),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left:15.0, right: 15.0, top: 5, bottom: 0),
                        child: Container(

                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Glycerine",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                              Text("Indonesian",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                              Text("Exports",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                              Text("Palm Oil",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                              Text("Rubber",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                              Text("Soap Noodles",style: TextStyle(fontSize: 15,color: Color(0xFF0F1C51), fontWeight: FontWeight.normal,),),
                            ],
                          ),
                        )

                    ),

                    Padding(
                        padding: const EdgeInsets.only(
                            left:15.0, right: 15.0, top: 5, bottom: 0),
                        child:
                        Container(
                          color: Colors.black,
                          width: double.infinity,
                          height: 40,
                          child:


                          Padding(
                            padding: const EdgeInsets.only(
                                left:15.0, right: 10.0, top: 10, bottom: 0),
                            child:

                            Text('INQUIRE DIRECTLY WITH SUPPLIER',style: TextStyle(fontSize: 15,color: Color(0xFFffffff), fontWeight: FontWeight.normal,),),

                          ),


                        )
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left:15.0, right: 15.0, top: 15, bottom: 10),
                      child: Text(property_company1,style: TextStyle(fontSize: 15,color: Color(0xFF000000), fontWeight: FontWeight.normal,),),
                    ),


                    Align(
                      alignment: Alignment.topLeft,
                      child:
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 15.0, top: 10, bottom: 0),

                        child:
                        Text('Describe your buying requirement', style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal,decoration: TextDecoration.none, color: Colors.black,  fontFamily: 'Noto Sans'),),
                      ),

                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 5, bottom: 0),
                        child:
                        Container(
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(2),


                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Color(0xFF072331), // Set border color
                                width: 1.0),   // Set border width
                            borderRadius: BorderRadius.all(
                                Radius.circular(5.0)), // Set rounded corner radius
                            //  boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))] // Make rounded corner of border
                          ),
                          child:
                          SizedBox(
                            height:100.0,

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
                                  hintText: 'Please include product name,order quantity,usage,special requests if any in your inquiry.',
                                  hintMaxLines: 3,
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
                          left: 20.0, right: 20.0, top: 5, bottom: 0),
                      child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left:5.0, right: 1.0, top: 0, bottom: 0),
                            child:
                            SizedBox(
                              height: 20,
                              width: 20,
                              child:    Checkbox(value: rememberMe,  onChanged: _onRememberMeChanged),
                            ),
                          ),
                          Expanded(
                              child:


                              Text('Send this enquiry to other Suppliers or Similar products(?)')


                          ),
                        ],
                      ),

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
                                  hintText: ' Email Address',
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
                                keyboardType: TextInputType.number,
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
                                controller: commodityname,
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
                                  hintText: 'Commodity Name',
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
                            height: 33.0,

                            child:

                            Container(
                              color: Color(0xFFffffff),
                              child:
                              TextFormField(
                                controller: hscode,
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
                                  hintText: 'Hs Code',
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
                            height: 33.0,

                            child:

                            Container(
                              color: Color(0xFFffffff),
                              child:
                              TextFormField(
                                controller: quantity,
                                keyboardType: TextInputType.number,
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
                                  hintText: 'Quantity',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left:5.0, right: 1.0, top: 0, bottom: 0),
                            child:
                            SizedBox(
                              height: 20,
                              width: 20,
                              child:    Checkbox(value: rememberMe2,  onChanged: _onRememberMeChanged2),
                            ),
                          ),
                          Expanded(
                              child:


                              Text('I agree to the Terms and Conditions')


                          ),
                        ],
                      ),

                    ),



                    Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10, bottom: 0),
                        child:Text('User Disclaimer:',textAlign: TextAlign.center, style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal, color: Color(0xFF868686),  fontFamily: 'Noto Sans')
                          ,)),

                    Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10, bottom: 0),
                        child:Text('Before Proceeding with any kind of business transactions/signing of contract with any of the listed companies in this platform, we request you to intimate our office in advance. Write us:inquiry@itpcchennai.com ',textAlign: TextAlign.left, style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal, color: Color(0xFF868686),  fontFamily: 'Noto Sans')
                          ,)),

                    Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 50, bottom: 50),
                        child:
                        Center(
                          child: ButtonTheme(
                            height: 30.0,
                            minWidth: 150,
                            child:
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),


                              ),
                              onPressed: isEnabled ? ()=> submitinquery1() : null,
                              color:  Color(0xFFE9FF54),
                              textColor: Colors.black,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Text('Send Inquiry'),
                            ),
                          ),
                        )




                    ),









                  ],
                );








            } else if (snapshot.hasError) {

            }

            // By default, show a loading spinner.

          },
        ),





      ),
    );
  }

}



class Studentdata {
  String property_id;
  String image_prop;
  String property_title;
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

  Studentdata({
    this.property_id,
    this.image_prop,
    this.property_title,
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

  factory Studentdata.fromJson(Map<String, dynamic> json) {
    return Studentdata(
      property_id: json['property_id'],
      image_prop: json['image_prop'],
      property_title: json['property_title'],
//        signup_category: json['signup_category'],
//
//        property_title: json['property_title'],
//        property_description: json['property_description'],
//        property_image: json['property_image'],
//        property_company: json['property_company'],
//
//
//        signup_choose: json['signup_choose'],
//        signup_img: json['signup_img'],
//        signup_gst_number: json['signup_gst_number'],
//        signup_organation: json['signup_organation'],
//
//        signup_name: json['signup_name'],
//        signup_email: json['signup_email'],
//        signup_mobile: json['signup_mobile'],
//        signup_city: json['signup_city'],
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


class Data {
  String property_id;
  String image_prop;
  String property_category;
  String signup_category;

  String property_title;
  String property_description;
  String property_image;
  String property_company;

  String signup_choose;
  String signup_img;
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

  Data({
    this.property_id,
    this.property_category,
    this.signup_category,

    this.property_title,
    this.property_description,
    this.property_image,
    this.property_company,



    this.signup_choose,
    this.signup_img,
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

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      property_id: json['property_id'],
      property_category: json['property_category'],

        signup_category: json['signup_category'],

        property_title: json['property_title'],
        property_description: json['property_description'],
        property_image: json['property_image'],
        property_company: json['property_company'],


        signup_choose: json['signup_choose'],
        signup_img: json['signup_img'],
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

class Cell extends StatelessWidget {
  const Cell(this.catimg);
  @required
  final Studentdata catimg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: new


        Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
    child:
    Column(
          children: <Widget>[
            Image.network(

                catimg.image_prop == '' ? 'http://ecorewick.com/moniespay_api/images/norecord.png' : p.extension(catimg.image_prop) != '.jpg' ? p.extension(catimg.image_prop) != '.png' ? 'http://ecorewick.com/moniespay_api/images/norecord.png':catimg.image_prop :catimg.image_prop,


                width: 150.0,
                height: 130.0,
                alignment: Alignment.center,
                fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, right: 0.0, top: 10, bottom: 0),
              child: Text(catimg.property_title),
        )
          ],
        ),
        )

      ),
    );
  }
}

