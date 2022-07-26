// @dart=2.9




import 'package:itpcchennaiapp/loader.dart';
import 'package:itpcchennaiapp/login.dart';
import 'package:itpcchennaiapp/nav.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:social_share/social_share.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';



String UserID;
String Name;



String balance="0";
String isvestment="0";

String snews="Welcome to the World's fastest growing Company. The business plan of the Trx Global provides you a miraculous opportunity for your bright and safe future. Trx Global Management has a team of dedicated and committed professionals having vast experience in network marketing.";







class dashboard extends StatefulWidget {
  // ChooseState() : super();
  dashboard({this.userid,this.Password, this.Name,this.email, this.Rank});

  var userid;
  var Password;
  var Name;
  var email;
  var Rank;
  final String title = "Filter List Demo";


  @override
  UserFilterDemoState createState() => UserFilterDemoState();
}


class UserFilterDemoState extends State<dashboard> {

  final myController = TextEditingController();
  int starter = 0;
  int _counter = 0;
  bool _isLoading = false;

  String _TotalLeft="0";
  String _TotalRight="0";
  String _Total="0";
  String _TodayLeft="0";
  String _TodayRight="0";
  String _TodayTotal="0";
  String _TotalDirectLeft="0";
  String _TotalDirectRight="0";
  String _TotalDirect="0";
  String _Recognition="-";





  bool _isVisible = true;
  bool _isVisible_upgrade = false;
  bool _isVisible_isemailvarified = false;
  Future<bool>  _onBackPressed()async {
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
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });

    return true;
  }

   Future<Album> futureBalance;
   Future<List<Album>> futureDashboard;
   SharedPreferences sharedPreferences;




  Future <List<Album>> fetchDatabalance() async {
    print('x1');
    print(UserID);

    var superheros_length;

    var url = "http://ecorewick.com/elffreedom/api/MLM_CUSTOMERDASHBOARD";
    final body = {

      'UserId':UserID,

    };
    print('x2');

    final response = await http.post(Uri.parse(url),
        body: json.encode(body),
        headers: { 'Content-type': 'application/json',
          'Accept': 'application/json',
          "Token": "TXpZdE9TMDVMVEl3TWpFdE1BPT0sVE9QSUQsMDktMDktMjAyMiAwNjowNjowMQ=="}
    );


    print(response.statusCode);
    if (response.statusCode == 200) {
      print(
          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
      // String  data = response.body;


      var parsed =json.decode(response.body);
      List jsonResponse=parsed["Data"] as List;

      String data = jsonResponse.toString();
      List<String> strings = data.split(",");
      var TotalLeft = strings[0].replaceAll("RETURN_TotalLeft", "").replaceAll("{", "")
          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "")
          .replaceAll(":", "");
      print('OOOOOOOOOOOO');
      _TotalLeft=TotalLeft;
      print(_TotalLeft);

      var TotalRight = strings[1].replaceAll("RETURN_TotalRight", "").replaceAll("{", "")
          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "")
          .replaceAll(":", "");

      _TotalRight=TotalRight;


      var Total = strings[2].replaceAll("RETURN_Total", "").replaceAll("{", "")
          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "")
          .replaceAll(":", "");

      _Total=Total;

      var TodayLeft = strings[3].replaceAll("RETURN_TodayLeft", "").replaceAll("{", "")
          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "")
          .replaceAll(":", "");

      _TodayLeft=TodayLeft;

      var TodayRight = strings[4].replaceAll("RETURN_TodayRight", "").replaceAll("{", "")
          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "")
          .replaceAll(":", "");

      _TodayRight=TodayRight;

      var TodayTotal = strings[5].replaceAll("RETURN_TodayTotal", "").replaceAll("{", "")
          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "")
          .replaceAll(":", "");

      _TodayTotal=TodayTotal;

      var TotalDirectLeft = strings[6].replaceAll("RETURN_TotalDirectLeft", "").replaceAll("{", "")
          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "")
          .replaceAll(":", "");

      _TotalDirectLeft=TotalDirectLeft;

      var TotalDirectRight = strings[7].replaceAll("RETURN_TotalDirectRight", "").replaceAll("{", "")
          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "")
          .replaceAll(":", "");

      _TotalDirectRight=TotalDirectRight;

      var TotalDirect = strings[8].replaceAll("RETURN_TotalDirect", "").replaceAll("{", "")
          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "")
          .replaceAll(":", "");

      _TotalDirect=TotalDirect;

      var Recognition = strings[9].replaceAll("RETURN_Recognition", "").replaceAll("{", "")
          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
          .replaceAll("\"", "")
          .replaceAll(":", "");

      _Recognition=Recognition;

//      print(response.body);
//      List jsonResponse = json.decode(response.body)['Data'];
//
//      print(jsonResponse);




      print('ssss');
      return jsonResponse.map((data) => new Album.fromJson(data)).toList();

    } else {
      throw Exception('error while fetching record');
    }
  }
//  Future<Album> fetchDatabalance() async {
//    print('x');
//    print(UserID);
//    var url = "http://ecorewick.com/elffreedom/api/MLM_CUSTOMERDASHBOARD";
//    final body = {
//
//      'UserId': "TOPID",
//
//    };
//
//    final response  =await http.post(Uri.parse(url),
//        body: json.encode(body),
//        headers: { 'Content-type': 'application/json',
//          'Accept': 'application/json',
//          "Token": "TXpZdE9TMDVMVEl3TWpFdE1BPT0sVE9QSUQsMDktMDktMjAyMiAwNjowNjowMQ=="}
//    );
//
//
//    print(response.statusCode );
//    if (response.statusCode == 200) {
//
//
//
//
//
//      var parsed =json.decode(response.body);
//      List jsonResponse=parsed["Data"] as List;
//
//
//      var returni = response.body;
//
//      String data = jsonResponse.toString();
//      List<String> strings = data.split(",");
//      var TotalLeft = strings[0].replaceAll("RETURN_TotalLeft", "").replaceAll("{", "")
//          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "")
//          .replaceAll(":", "");
//
//      _TotalLeft=TotalLeft;
//
//      var TotalRight = strings[1].replaceAll("RETURN_TotalRight", "").replaceAll("{", "")
//          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "")
//          .replaceAll(":", "");
//
//      _TotalRight=TotalRight;
//
//
//      var Total = strings[2].replaceAll("RETURN_Total", "").replaceAll("{", "")
//          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "")
//          .replaceAll(":", "");
//
//      _Total=Total;
//
//      var TodayLeft = strings[3].replaceAll("RETURN_TodayLeft", "").replaceAll("{", "")
//          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "")
//          .replaceAll(":", "");
//
//      _TodayLeft=TodayLeft;
//
//      var TodayRight = strings[4].replaceAll("RETURN_TodayRight", "").replaceAll("{", "")
//          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "")
//          .replaceAll(":", "");
//
//      _TodayRight=TodayRight;
//
//      var TodayTotal = strings[5].replaceAll("RETURN_TodayTotal", "").replaceAll("{", "")
//          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "")
//          .replaceAll(":", "");
//
//      _TodayTotal=TodayTotal;
//
//      var TotalDirectLeft = strings[6].replaceAll("RETURN_TotalDirectLeft", "").replaceAll("{", "")
//          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "")
//          .replaceAll(":", "");
//
//      _TotalDirectLeft=TotalDirectLeft;
//
//      var TotalDirectRight = strings[7].replaceAll("RETURN_TotalDirectRight", "").replaceAll("{", "")
//          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "")
//          .replaceAll(":", "");
//
//      _TotalDirectRight=TotalDirectRight;
//
//      var TotalDirect = strings[8].replaceAll("RETURN_TotalDirect", "").replaceAll("{", "")
//          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "")
//          .replaceAll(":", "");
//
//      _TotalDirect=TotalDirect;
//
//      var Recognition = strings[9].replaceAll("RETURN_Recognition", "").replaceAll("{", "")
//          .replaceAll("[", "").replaceAll("]", "").replaceAll("}", "")
//          .replaceAll("\"", "")
//          .replaceAll(":", "");
//
//      _Recognition=Recognition;
//      print(TotalDirectLeft);
//      print(_TotalDirectRight);
//       print(_TotalDirect);
//
//      //return Album.fromJson(jsonDecode(jsonResponse.toString()));
//      //print(await response.stream.bytesToString());
//      return jsonResponse.map((data) => new Album.fromJson(data)).toList();
//
//
//
//    }
//    else {
//      // print(response.reasonPhrase);
//    }
//
//    return Album.fromJson(jsonDecode(response.body));
//
//  }


  @override

  void initState() {
    super.initState();
    checkLoginStatus();
    UserID=widget.userid;
    // _showLoadingIndicator_log();
    futureDashboard = fetchDatabalance();

  }


  showAlertDialog(BuildContext context) {
    // set up the buttons

    Widget cancelButton = FlatButton(
      child: Text("OK"),
      onPressed:  () {

        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Text("An email verification link has been sent to your registered emailid."),
      actions: [

        cancelButton,

      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  void _handleLogout() async {
    print('logout');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("SessionUserid");
    prefs.remove("Sessionpass");
    prefs.remove("SessionFIRSTNAME");
    prefs.remove("Sessionemail");
    prefs.remove("Sessionrank");



//    Navigator.pushNamedAndRemoveUntil(
////        context, '/signin', ModalRoute.withName('/signin'));



    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => login()),
    );






  }


  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("SessionUserid") == null) {
      Navigator.of(context).pushReplacementNamed('/signin');
    }
    else
    {
      String uid=sharedPreferences.getString("SessionUserid");
      String pass=sharedPreferences.getString("Sessionpass");
      String name=sharedPreferences.getString("SessionFIRSTNAME");
//        List<String> strings = uid.split(":");
//        var user= strings[1];
      print(uid);
      UserID=uid;






    }
  }



   MaskFilter _blur;
  final List<MaskFilter> _blurs = [

    MaskFilter.blur(BlurStyle.normal, 10.0),
    MaskFilter.blur(BlurStyle.inner, 10.0),
    MaskFilter.blur(BlurStyle.outer, 10.0),
    MaskFilter.blur(BlurStyle.solid, 16.0),
  ];
  int _blurIndex = 0;
  MaskFilter _nextBlur() {
    if (_blurIndex == _blurs.length - 1) {
      _blurIndex = 0;
    } else {
      _blurIndex = _blurIndex + 1;
    }
    _blur = _blurs[_blurIndex];
    return _blurs[_blurIndex];
  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;


    int _selectedIndex = 0;

    return

      Scaffold(
        backgroundColor: Color(0xFFffffff),
//        drawer: NavDrawer(
//          userid: widget.userid,Password:widget.Password,Name:widget.Name,email: widget.email,
//        ),




//      floatingActionButton: UnicornDialer(
//          backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
//          parentButtonBackground: Colors.blue,
//          orientation: UnicornOrientation.VERTICAL,
//          parentButton: Icon(Icons.share),
//          childButtons: childButtons),

        appBar:
        AppBar(
          centerTitle: false,
          title:
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('images/elf2.png', width: 50.0, height: 35,),

              Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 0.0, top: 10, bottom: 0),
                child:Text('Dashboard', style: TextStyle(fontSize: 15,color: Colors.black),textAlign: TextAlign.left,),
              )
            ],
          ),

          iconTheme: IconThemeData(
            color: Colors.black,
          ),




          backgroundColor:Color(0xFFFFFFFF),
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


            IconButton(
              icon: const Icon(Icons.exit_to_app, color: Colors.black,),
              iconSize: 28.0,
              onPressed: () {


                _handleLogout();

              },
            ),
          ],
        ),
        body:
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child:
          Stack(
            children: <Widget>[



              WillPopScope(
                onWillPop: _onBackPressed,
                child:  Container(


                  child:
                  FutureBuilder <List<Album>>(
                    future: futureDashboard,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {

                        return


                          CustomScrollView(
                            physics: ClampingScrollPhysics(),
                            slivers: <Widget>[
                              SliverToBoxAdapter(
                                  child:
                                  Column(children: [



                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left:10.0, right: 10.0, top: 5, bottom: 0),
                                      child:
                                      Container(
                                          child:

                                          Column(
                                            children: [




                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 7,
                                                    child:
                                                    Container(
                                                      height: 60,





                                                      padding: EdgeInsets.all(1.0),
                                                      child:
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.only(
                                                                left:5.0, right: 15.0, top: 5, bottom: 0),
                                                            child:
                                                            Text('Hello!',style: const TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 18.0,
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: 'Noto Sans'
                                                            ),),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(
                                                                left:5.0, right: 15.0, top: 5, bottom: 0),
                                                            child:
                                                            Text(widget.Name,style: const TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 18.0,
                                                                fontWeight: FontWeight.normal,
                                                                fontFamily: 'Noto Sans'
                                                            ),),
                                                          ),
                                                        ],
                                                      ),

                                                    ),
                                                  ),

                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                        padding: EdgeInsets.all(1.0),
                                                        child:

                                                        Column(

                                                          children: [
                                                            Container(
                                                              width: double.infinity,
                                                              height: 60,

                                                              padding: EdgeInsets.all(5.0),

                                                              child:

                                                              Align(
                                                                alignment: Alignment.bottomRight,
                                                                child:
                                                                Icon(
                                                                  Icons.notifications,
                                                                  color: Colors.black,
                                                                  size: 30.0,
                                                                ),
                                                              ),

                                                            ),


                                                          ],
                                                        )


                                                    ),
                                                  ),
                                                ],
                                              ),







                                              SizedBox(
                                                height: 0.0,
                                              ),

                                              Opacity(
                                                opacity: 0.9,
                                                child:
                                                Container(
                                                  height: 100.0,
                                                  width: double.infinity,

                                                  child:
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage("images/poster.png",),

                                                            //fit: BoxFit.cover
                                                          ),
                                                          // color: Color(0xFF0177FB),

//                                                        gradient: LinearGradient(
//                                                          begin: Alignment.topLeft,
//                                                          end: Alignment.bottomRight,
//                                                          colors: <Color>[
//                                                            Color(0xFF2ECC71).withOpacity(1),
//                                                           // Color(0xFF1584A2).withOpacity(1),
//                                                            Color(0xFF36E781).withOpacity(1),
//                                                          ],
//
//                                                        ),
                                                          borderRadius: BorderRadius.all(Radius.circular(10.0)
                                                          )
                                                      ),



                                                      child: new

                                                      Container(child:
                                                      Center(
                                                        child:

                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[







                                                          ],
                                                        ),

                                                      )


                                                      )



                                                  ),

                                                ),
                                              ),


                                              SizedBox(
                                                height: 5.0,
                                              ),

                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text('Feature',style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Noto Sans'
                                                ),),
                                              ),
                                              SizedBox(
                                                height: 15.0,
                                              ),

                                              Row(
                                                children: [

                                                  Expanded(
                                                    flex: 2,
                                                    child:

                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Center(
                                                          child:Container(
                                                            height:60,
                                                            width:60,
                                                            decoration: BoxDecoration(

                                                              borderRadius: BorderRadius.circular(15.0),
                                                              color: Color(0xFFE8DAEF),
                                                              border: Border.all(color: Color(0xFFE8DAEF), width: 2),
                                                            ),
                                                            child: IconButton(
                                                              icon: Icon(
                                                                  Icons.account_balance_wallet,
                                                                  color:  Color(0xFF8E44AD),size: 30.0
                                                              ),
                                                              onPressed: () {

                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Center(
                                                          child:Text('Wallet',style: const TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 15.0,
                                                              fontWeight: FontWeight.normal,
                                                              fontFamily: 'Noto Sans'
                                                          ),),
                                                        )
                                                      ],
                                                    )   ,

                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child:

                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Center(
                                                          child:
                                                          Container(
                                                            height:60,
                                                            width:60,
                                                            decoration: BoxDecoration(

                                                              borderRadius: BorderRadius.circular(15.0),
                                                              color: Color(0xFFFDEBD0),
                                                              border: Border.all(color: Color(0xFFFDEBD0), width: 2),
                                                            ),
                                                            child: IconButton(
                                                              icon: Icon(
                                                                  Icons.restore,
                                                                  color: Color(0xFFF39C12),size: 30.0
                                                              ),
                                                              onPressed: () {






                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Center(
                                                          child:Text('Recharge',style: const TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 15.0,
                                                              fontWeight: FontWeight.normal,
                                                              fontFamily: 'Noto Sans'
                                                          ),),
                                                        )
                                                      ],
                                                    )   ,

                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child:

                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Center(
                                                          child: Container(
                                                            height:60,
                                                            width:60,
                                                            decoration: BoxDecoration(

                                                              borderRadius: BorderRadius.circular(15.0),
                                                              color: Color(0xFFD5F5E3),
                                                              border: Border.all(color: Color(0xFFD5F5E3), width: 2),
                                                            ),
                                                            child: IconButton(
                                                              icon: Icon(
                                                                  Icons.vpn_key,
                                                                  color: Color(0xFF2ECC71),size: 30.0
                                                              ),
                                                              onPressed: () {




                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Center(
                                                          child:Text('E-pin',style: const TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 15.0,
                                                              fontWeight: FontWeight.normal,
                                                              fontFamily: 'Noto Sans'
                                                          ),),
                                                        )
                                                      ],
                                                    )   ,

                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child:

                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Center(
                                                          child:
                                                          Container(
                                                            height:60,
                                                            width:60,
                                                            decoration: BoxDecoration(

                                                              borderRadius: BorderRadius.circular(15.0),
                                                              color: Color(0xFFFADBD8),
                                                              border: Border.all(color: Color(0xFFFADBD8), width: 2),
                                                            ),
                                                            child: IconButton(
                                                              icon: Icon(
                                                                  Icons.repeat_one,
                                                                  color:  Color(0xFFE74C3C),size: 30.0
                                                              ),
                                                              onPressed: () {



                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Center(
                                                          child:Text('Repurchase',style: const TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 15.0,
                                                              fontWeight: FontWeight.normal,
                                                              fontFamily: 'Noto Sans'
                                                          ),),
                                                        )
                                                      ],
                                                    )   ,

                                                  ),
                                                ],
                                              ),

                                              SizedBox(
                                                height: 15,
                                              ),
















                                              Opacity(
                                                opacity: 0.9,
                                                child:
                                                Container(
                                                  height: 120.0,
                                                  width: double.infinity,

                                                  child:
                                                  Container(
                                                    decoration: BoxDecoration(
//                        image: DecorationImage(
//                            image: AssetImage("images/dashboardtop.png",),
//
//                            fit: BoxFit.cover
//                        ),
                                                      // color: Color(0xFF0177FB),

                                                        gradient: LinearGradient(
                                                          begin: Alignment.topLeft,
                                                          end: Alignment.bottomRight,
                                                          colors: <Color>[
                                                            Color(0xFF2CC16B).withOpacity(1),
                                                            // Color(0xFF1584A2).withOpacity(1),
                                                            Color(0xFF2ECC71).withOpacity(1),
                                                          ],

                                                        ),
                                                        borderRadius: BorderRadius.all(Radius.circular(10.0)
                                                        )
                                                    ),

                                                    child:Container(
                                                      child: Column(

                                                        children: [

                                                          Container(child:
                                                          Center(
                                                            child:

                                                            Row(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[

                                                                Padding(
                                                                  padding: const EdgeInsets.only(
                                                                      left:20.0, right: 0.0, top: 0, bottom: 0),
                                                                  child:
                                                                  Image.asset('images/user_d.png', width: 40.0, height: 40,),
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[

                                                                    Padding(
                                                                      padding: const EdgeInsets.only(
                                                                          left:10.0, right: 0.0, top: 20, bottom: 0),
                                                                      child:

                                                                      Text('Recognition ',style: const TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 20.0,
                                                                          fontWeight: FontWeight.normal,
                                                                          fontFamily: 'Noto Sans'
                                                                      ),),
                                                                    ),
                                                                    Text( '$_Recognition',style: const TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 20.0,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontFamily: 'Noto Sans'
                                                                    ),),

                                                                  ],
                                                                ),
                                                              ],
                                                            ),



                                                          )


                                                          ),
                                                          WaveWidget(
                                                            duration: 1,
                                                            config: CustomConfig(
                                                              gradients: [
                                                                [Color(0xFF2CC16B), Color(0xFF9DEC9B)],
                                                                [Color(0xFF2CC16B), Color(0xFF31C02E)],
                                                                [Color(0xFF13EC0E), Color(0xFF13EC0E)],
                                                                [Color(0xFF31C02E), Color(0xFF68D465)]
                                                              ],
                                                              durations: [35000, 19440, 10800, 6000],
                                                              heightPercentages: [0.20, 0.23, 0.25, 0.30],
                                                              blur: MaskFilter.blur(BlurStyle.inner, 5),
                                                              gradientBegin: Alignment.centerLeft,
                                                              gradientEnd: Alignment.centerRight,
                                                            ),
                                                            waveAmplitude: 1.0,
                                                            backgroundColor:  Color(0xFF2CC16B).withOpacity(1),
                                                            size: Size(double.infinity, 50.0),

                                                          ),
                                                        ],


                                                      ),

                                                    ),







                                                  ),

                                                ),
                                              ),

                                              SizedBox(
                                                height: 10,
                                              ),



                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child:

                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left:0.0, right: 0.0, top: 2, bottom: 0),



                                                  child:
                                                  Text('Member Statistics',style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.0,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Noto Sans'
                                                  ),),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 0),
                                                child:
                                                Container(




                                                  child:
                                                  Column(
                                                    children: <Widget>[


                                                      Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(

                                                        ),

                                                        child:
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 10),
                                                          child:
                                                          Row(
                                                            children: <Widget>[



                                                              Expanded(
                                                                flex: 2,
                                                                child:
                                                                Text(
                                                                  '',
                                                                  style: const TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 16.0,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontFamily: 'Noto Sans'
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                  Container(
                                                                    child:Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left: 0.0, right: 15.0, top: 0, bottom: 0),



                                                                        child:
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [

                                                                            Text(
                                                                              'Left',
                                                                              style: const TextStyle(
                                                                                color: Color(0xFFE2A915),
                                                                                fontSize: 16.0,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),


                                                                          ],
                                                                        )
                                                                    ),
                                                                  )

                                                              ),

                                                              Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                  Container(
                                                                    child:Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left: 0.0, right: 15.0, top: 0, bottom: 0),



                                                                        child:
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [

                                                                            Text(
                                                                              'Right',
                                                                              style: const TextStyle(
                                                                                color: Color(0xFFE2A915),
                                                                                fontSize: 16.0,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),


                                                                          ],
                                                                        )
                                                                    ),
                                                                  )

                                                              ),

                                                              Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                  Container(
                                                                    child:Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left: 0.0, right: 15.0, top: 0, bottom: 0),



                                                                        child:
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [

                                                                            Text(
                                                                              'Total',
                                                                              style: const TextStyle(
                                                                                color: Color(0xFFE2A915),
                                                                                fontSize: 16.0,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),


                                                                          ],
                                                                        )
                                                                    ),
                                                                  )

                                                              ),



                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color:Color(0xFF2CC16B),
                                                        ),

                                                        child:

                                                        Padding(
                                                            padding: EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 10),
                                                            child:


                                                            ColoredBox(
                                                              color: Colors.transparent,
                                                              child:  Row(
                                                                children: <Widget>[



                                                                  Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                    Text(
                                                                      'Total Joining',
                                                                      style: const TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 12.0,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontFamily: 'Noto Sans'
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                      Container(
                                                                        child:Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 0.0, right: 15.0, top: 0, bottom: 0),



                                                                            child:
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [

                                                                                Text(
                                                                                  '$_TotalLeft',
                                                                                  style: const TextStyle(
                                                                                    color: Color(0xFFffffff),
                                                                                    fontSize: 18.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),


                                                                              ],
                                                                            )
                                                                        ),
                                                                      )

                                                                  ),

                                                                  Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                      Container(
                                                                        child:Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 0.0, right: 15.0, top: 0, bottom: 0),



                                                                            child:
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [

                                                                                Text(
                                                                                  '$_TotalRight',
                                                                                  style: const TextStyle(
                                                                                    color: Color(0xFFffffff),
                                                                                    fontSize: 18.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),


                                                                              ],
                                                                            )
                                                                        ),
                                                                      )

                                                                  ),

                                                                  Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                      Container(
                                                                        child:Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 0.0, right: 15.0, top: 0, bottom: 0),



                                                                            child:
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [

                                                                                Text(
                                                                                  '$_Total',
                                                                                  style: const TextStyle(
                                                                                    color: Color(0xFFffffff),
                                                                                    fontSize: 18.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),


                                                                              ],
                                                                            )
                                                                        ),
                                                                      )

                                                                  ),




                                                                ],
                                                              ),
                                                            )






                                                        ),

                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),

                                                      Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: Color(0xFF2CC16B),
                                                        ),

                                                        child:

                                                        Padding(
                                                            padding: EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 10),
                                                            child:


                                                            ColoredBox(
                                                              color: Colors.transparent,
                                                              child: Row(
                                                                children: <Widget>[



                                                                  Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                    Text(
                                                                      'Today\'s Joining',
                                                                      style: const TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 12.0,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontFamily: 'Noto Sans'
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                      Container(
                                                                        child:Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 0.0, right: 15.0, top: 0, bottom: 0),



                                                                            child:
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [

                                                                                Text(
                                                                                  '$_TodayLeft',
                                                                                  style: const TextStyle(
                                                                                    color: Color(0xFFffffff),
                                                                                    fontSize: 18.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),


                                                                              ],
                                                                            )
                                                                        ),
                                                                      )

                                                                  ),

                                                                  Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                      Container(
                                                                        child:Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 0.0, right: 15.0, top: 0, bottom: 0),



                                                                            child:
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [

                                                                                Text(
                                                                                  '$_TodayRight',
                                                                                  style: const TextStyle(
                                                                                    color: Color(0xFFffffff),
                                                                                    fontSize: 18.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),


                                                                              ],
                                                                            )
                                                                        ),
                                                                      )

                                                                  ),

                                                                  Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                      Container(
                                                                        child:Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 0.0, right: 15.0, top: 0, bottom: 0),



                                                                            child:
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [

                                                                                Text(
                                                                                  '$_TodayTotal',
                                                                                  style: const TextStyle(
                                                                                    color: Color(0xFFffffff),
                                                                                    fontSize: 18.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),


                                                                              ],
                                                                            )
                                                                        ),
                                                                      )

                                                                  ),






                                                                ],
                                                              ),
                                                            )







                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),

                                                      Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10.0),
                                                          color: Color(0xFF2CC16B),
                                                        ),

                                                        child:
                                                        Padding(
                                                            padding: EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 10),
                                                            child:


                                                            ColoredBox(

                                                              color: Colors.transparent,
                                                              child:   Row(
                                                                children: <Widget>[



                                                                  Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                    Text(
                                                                      'Total Directs',
                                                                      style: const TextStyle(
                                                                          color: Colors.black,
                                                                          fontSize: 12.0,
                                                                          fontWeight: FontWeight.bold,
                                                                          fontFamily: 'Noto Sans'
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                      Container(
                                                                        child:Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 0.0, right: 15.0, top: 0, bottom: 0),



                                                                            child:
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [

                                                                                Text(
                                                                                  '$_TotalDirectLeft',
                                                                                  style: const TextStyle(
                                                                                    color: Color(0xFFffffff),
                                                                                    fontSize: 18.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),


                                                                              ],
                                                                            )
                                                                        ),
                                                                      )

                                                                  ),

                                                                  Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                      Container(
                                                                        child:Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 0.0, right: 15.0, top: 0, bottom: 0),



                                                                            child:
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [

                                                                                Text(
                                                                                  '$_TotalDirectRight',
                                                                                  style: const TextStyle(
                                                                                    color: Color(0xFFffffff),
                                                                                    fontSize: 18.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),


                                                                              ],
                                                                            )
                                                                        ),
                                                                      )

                                                                  ),

                                                                  Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                      Container(
                                                                        child:Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 0.0, right: 15.0, top: 0, bottom: 0),



                                                                            child:
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [

                                                                                Text(
                                                                                  '$_TotalDirect',
                                                                                  style: const TextStyle(
                                                                                    color: Color(0xFFffffff),
                                                                                    fontSize: 18.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),


                                                                              ],
                                                                            )
                                                                        ),
                                                                      )

                                                                  ),





                                                                ],
                                                              ),
                                                            )





                                                        ),

                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),

                                                      Container(
                                                        width: double.infinity,

                                                        decoration: BoxDecoration(

                                                        ),
                                                        child:
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 10),
                                                          child:
                                                          Row(
                                                            children: <Widget>[



                                                              Expanded(
                                                                flex: 6,
                                                                child:
                                                                Text(
                                                                  'Total Inactive Users',
                                                                  style: const TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 16.0,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontFamily: 'Noto Sans'
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  flex: 4,
                                                                  child:
                                                                  Container(
                                                                    child:Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            left: 0.0, right: 15.0, top: 0, bottom: 0),



                                                                        child:
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [

                                                                            Text(
                                                                              '',
                                                                              style: const TextStyle(
                                                                                color: Color(0xFFE2A915),
                                                                                fontSize: 16.0,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),


                                                                          ],
                                                                        )
                                                                    ),
                                                                  )

                                                              ),






                                                            ],
                                                          ),
                                                        ),
                                                      ),





                                                    ],
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                height: 10,
                                              ),





                                              SizedBox(
                                                height: 10,
                                              ),





                                            ],
                                          )


                                      ),






                                    ),





                                  ],)



                              ),



                            ],
                          );






                      } else if (snapshot.hasError) {
                        // return Text("${snapshot.error}");
                      }

                      // By default, show a loading spinner.
                      return LinearProgressIndicator(backgroundColor: Colors.lightBlue);
                    },
                  ),

                ),
              ),

              Container(
                  child: _isLoading ? Loader(loadingTxt: 'loading...') : Container()
              )
            ],
          ),


        ),
      );





//        bottomNavigationBar: BottomNavigationBar(
//          type: BottomNavigationBarType.fixed,
//          backgroundColor: Color(0xFF191B2A),
//          selectedItemColor: Color(0xFFE2A915),
//          unselectedItemColor: Color(0xFF97A3B9),
//          selectedFontSize: 14,
//          unselectedFontSize: 14,
//          currentIndex: _selectedIndex, //현재 선택된 Index
//          onTap: (int index) {
//            setState(() {
//              _selectedIndex = index;
//
//              print(_selectedIndex);
//
//              if(_selectedIndex==1)
//              {
////                Navigator.push(
////                  context,
////                  MaterialPageRoute(builder: (context) =>
////                      wallet(
////                        userid:widget.userid,Password: _pass,Name: widget.Name,email: widget.email,
////                      )
////
////                  ),
////                );
//              }
//              else if(_selectedIndex==2)
//              {
//
//              }
//              else if(_selectedIndex==3)
//              {
////                Navigator.push(
////                  context,
////                  MaterialPageRoute(builder: (context) =>
////                      SettingProfile(
////                        userid:widget.userid,Password: _pass,Name: widget.Name,email: widget.email,
////                      )
////
////                  ),
////                );
//              }
//              else
//              {
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) =>
//                      DASHBOARD(
//                        userid:widget.userid,Password: _pass,Name: widget.Name,email: widget.email,
//                      )
//
//                  ),
//                );
//              }
//
//            });
//          },
//          items: [
//            BottomNavigationBarItem(
//              title: Text('Home',style: const TextStyle(color: Color(0xFF97A3B9), fontSize: 16.0, fontWeight: FontWeight.normal, fontFamily: 'Noto Sans'),),
//              //icon: Icon(Icons.home,color:  Color(0xFFF09F16),),
//          icon: Image.asset("images/_home_1.png", height: 45 ),),
//            BottomNavigationBarItem(
//              title: Text('Wallet',style: const TextStyle(color: Color(0xFF97A3B9), fontSize: 16.0, fontWeight: FontWeight.normal, fontFamily: 'Noto Sans'),),
//              icon: Image.asset("images/_wallet_1.png", height: 45 ),),
//            BottomNavigationBarItem(
//              title: Text('Market',style: const TextStyle(color: Color(0xFF97A3B9), fontSize: 16.0, fontWeight: FontWeight.normal, fontFamily: 'Noto Sans'),),
//              icon: Image.asset("images/_market_1.png", height: 45 ),),
//
//            BottomNavigationBarItem(
//              title: Text('Profile',style: const TextStyle(color: Color(0xFF97A3B9), fontSize: 16.0, fontWeight: FontWeight.normal, fontFamily: 'Noto Sans'),),
//              icon: Image.asset("images/_profile_1.png", height: 45 ),),
//
//          ],
//        ),



    //   );

  }
  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}












final kInnerDecoration = BoxDecoration(
  color: Colors.black,
  border: Border.all(color: Colors.black),
  borderRadius: BorderRadius.circular(32),
);

final kGradientBoxDecoration = BoxDecoration(
  gradient: LinearGradient(colors: [Colors.blue, Colors.pink]),
  border: Border.all(
    // color: Colors.blue,
  ),
  borderRadius: BorderRadius.circular(32),
);



_launchURL() async {
  const url = 'https://t.me/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


List _widgetOptions = [
  Text(
    'Home',
    style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
  ),
  Text(
    'Wallet',
    style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
  ),
  Text(
    'Market',
    style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
  ),
  Text(
    'Profile',
    style: TextStyle(fontSize: 30, fontFamily: 'DoHyeonRegular'),
  ),
];











class LabelText extends StatelessWidget {
  LabelText({ this.label,  this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),

      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}






class Album {
  final String RETURN_TotalLeft;

  final String RETURN_TotalRight;

  final String RETURN_Total;
  final String RETURN_TodayLeft;
  final String RETURN_TodayRight;
  final String RETURN_TodayTotal;

  final String RETURN_TotalDirectLeft;

  final String RETURN_TotalDirectRight;
  final String RETURN_TotalDirect;
  final String RETURN_Recognition;


  Album({

     this.RETURN_TotalLeft,

     this.RETURN_TotalRight,

      this.RETURN_Total,
     this.RETURN_TodayLeft,
     this.RETURN_TodayRight,
      this.RETURN_TodayTotal,

      this.RETURN_TotalDirectLeft,

     this.RETURN_TotalDirectRight,
     this.RETURN_TotalDirect,
      this.RETURN_Recognition,




  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(

      RETURN_TotalLeft: json['RETURN_TotalLeft'],

      RETURN_TotalRight: json['RETURN_TotalRight'],
      RETURN_Total: json['RETURN_Total'],
      RETURN_TodayLeft: json['RETURN_TodayLeft'],
      RETURN_TodayRight: json['RETURN_TodayRight'],
      RETURN_TodayTotal: json['RETURN_TodayTotal'],
      RETURN_TotalDirectLeft: json['RETURN_TotalDirectLeft'],
      RETURN_TotalDirectRight: json['RETURN_TotalDirectRight'],
      RETURN_TotalDirect: json['RETURN_TotalDirect'],
      RETURN_Recognition: json['RETURN_Recognition'],






    );
  }
}








