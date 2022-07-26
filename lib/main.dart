//import 'package:flutter/material.dart';
//
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key? key, required this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
//      body: Center(
//        // Center is a layout widget. It takes a single child and positions it
//        // in the middle of the parent.
//        child: Column(
//          // Column is also a layout widget. It takes a list of children and
//          // arranges them vertically. By default, it sizes itself to fit its
//          // children horizontally, and tries to be as tall as its parent.
//          //
//          // Invoke "debug painting" (press "p" in the console, choose the
//          // "Toggle Debug Paint" action from the Flutter Inspector in Android
//          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//          // to see the wireframe for each widget.
//          //
//          // Column has various properties to control how it sizes itself and
//          // how it positions its children. Here we use mainAxisAlignment to
//          // center the children vertically; the main axis here is the vertical
//          // axis because Columns are vertical (the cross axis would be
//          // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.headline4,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}










// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:itpcchennaiapp/buyerdashboard.dart';
import 'package:itpcchennaiapp/dashboard.dart';
import 'package:itpcchennaiapp/login.dart';
import 'package:flutter/material.dart';
import 'package:itpcchennaiapp/sellerdashboard.dart';
import 'package:new_version/new_version.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info/device_info.dart';


String M_Name="";
String M_phone="";
String M_email="";
String M_Avtar="";
String UserID="";
String local_version=".";
String store_version=".";



const APP_STORE_URL =
    'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=YOUR-APP-ID&mt=8';
const PLAY_STORE_URL =
    'https://play.google.com/store/apps/details?id=com.gallery.elffreedomapp';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
    routes: <String, WidgetBuilder>{
      '/login': (BuildContext context) => new login()
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<MyApp> {
  double _progress = 0;

  SharedPreferences sharedPreferences;

  DeviceInfoPlugin deviceInfo =
  DeviceInfoPlugin(); // instantiate device info plugin
  AndroidDeviceInfo androidDeviceInfo;

  String board, brand, device, hardware, host, id, manufacture, model, product, type, androidid;
  bool isphysicaldevice;



  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async{

    sharedPreferences = await SharedPreferences.getInstance();

    if(sharedPreferences.getString("SessionUserid") == null) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
    else
    {



      String uid=sharedPreferences.getString("SessionUserid");
      String name=sharedPreferences.getString("SessionFIRSTNAME");
      String email=sharedPreferences.getString("Sessionemail");
      String signup_choose=sharedPreferences.getString("Sessionsignup_choose");
      String signup_content=sharedPreferences.getString("Sessionsignup_content");
      String signupid=sharedPreferences.getString("Sessionsignupid");



      if(signup_choose=='IndonesianInvestor')
      {

        print('1x');


        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              buyerdashbaord(
                  userid:uid ,Type:signup_choose.toString(),content:signup_content,Name:name.toString(),signupid:signupid.toString() ,
                //userid:UserId,Password:password.text.toString(),Name:Name.toString(),email: email.toString(),Tokesn:token
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
                  userid:uid ,Type:signup_choose.toString(),content:signup_content,Name:name.toString(),signupid:signupid.toString() ,
                //userid:UserId,Password:password.text.toString(),Name:Name.toString(),email: email.toString(),Tokesn:token
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
                  userid:uid ,Type:signup_choose.toString(),content:signup_content,Name:name.toString(),signupid:signupid.toString() ,
                //userid:UserId,Password:password.text.toString(),Name:Name.toString(),email: email.toString(),Tokesn:token
              )),
        );

      }



    }

  }

  @override
  void initState() {

    try {

    } catch (e) {
      print(e);
    }
    super.initState();
    getDeviceinfo();
    startTime();
   // checkLoginStatus();





    // Instantiate NewVersion manager object (Using GCP Console app as example)
    final newVersion = NewVersion(
      iOSId: 'com.google.Vespa',
      androidId: 'com.gallery.elffreedomapp',
    );

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
    const simpleBehavior = false;

    if (simpleBehavior) {
      basicStatusCheck(newVersion);
      print('111');
    } else {
      print('222');
      advancedStatusCheck(newVersion);
    }

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


  basicStatusCheck(NewVersion newVersion) {
    print('333');
    newVersion.showAlertIfNecessary(context: context);
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    print(status.releaseNotes);
    print(status.appStoreLink);
    print(status.localVersion);
    print(status.storeVersion);
    print(status.canUpdate.toString());

    local_version=status.localVersion;
    store_version=status.storeVersion;

    if(status.localVersion != status.storeVersion) {
      print('iiiii');


      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Update Moniespay"),
          content: Text("This version needs to be updated.Update to the latest version?"),
          actions: <Widget>[
//            TextButton(
//              child: Text('Update'),
//              onPressed: () {
//                print('Update');
//                _launchURL;
//                //Navigator.of(context).pop();
//              },
//            ),
            RaisedButton(
              onPressed: _launchURL,
              child: Text('Update'),
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {

                Navigator.of(context).pop();
                startTime();
              },
            ),
          ],

        ),
      );



//      newVersion.showUpdateDialog(
//        context: context,
//        versionStatus: status,
//        dialogTitle: 'Update Available',
//        dialogText: 'You can now update this app from ' + status.localVersion +
//            ' to ' + status.storeVersion,
//      );



    }
    else {
      startTime();
    }
  }



//  checkLoginStatus() async {
//    sharedPreferences = await SharedPreferences.getInstance();
//    if(sharedPreferences.getString("SessionUserid") == null) {
//      Navigator.of(context).pushReplacementNamed('/login');
//    }
//    else
//    {
//      String uid=sharedPreferences.getString("SessionUserid");
//      String name=sharedPreferences.getString("SessionFIRSTNAME");
//      String email=sharedPreferences.getString("Sessionemail");
//      String signup_choose=sharedPreferences.getString("Sessionsignup_choose");
//      String signup_content=sharedPreferences.getString("Sessionsignup_content");
//      String signupid=sharedPreferences.getString("Sessionsignupid");
//
//
//
//
//      if(signup_choose=='IndonesianInvestor')
//      {
//
//        print('1x');
//
//
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) =>
//              sellerdashbaord(
//                  userid:uid ,Type:signup_choose.toString(),content:signup_content,Name:name.toString()
//                //userid:UserId,Password:password.text.toString(),Name:Name.toString(),email: email.toString(),Tokesn:token
//              )),
//
//
//        );
//
//
//
//      }
//      else  if(signup_choose=='IndonesianSeller/Exporter/Manufacturer')
//      {
//
//        print('2x');
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) =>
//              sellerdashbaord(
//                  userid:uid ,Type:signup_choose.toString(),content:signup_content,Name:name.toString()
//                //userid:UserId,Password:password.text.toString(),Name:Name.toString(),email: email.toString(),Tokesn:token
//              )),
//
//
//
//
//        );
//
//
//      }
//      else
//      {
//        print('b2x');
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) =>
//              buyerdashbaord(
//                  userid:uid ,Type:signup_choose.toString(),content:signup_content,Name:name.toString()
//                //userid:UserId,Password:password.text.toString(),Name:Name.toString(),email: email.toString(),Tokesn:token
//              )),
//        );
//
//      }
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
//    }
//  }


  _launchURL() async {
    const url = 'https://play.google.com/store/apps/details?id=com.gallery.realhappyindiaapp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Color(0xFFFAFAFA),




      body: SafeArea(

        child:
        Container(

          //color: Color(0xFFF1F1F1),

          width:double.infinity,




          padding: EdgeInsets.only(left: 0, right: 0),
          child: Column(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 140,),






                  Center(
                    child:Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 200, bottom: 30),
                      child:
                      Image.asset('images/logo.png',),
                    ),
                  ),








                  SizedBox(height: 100,),

                ],
              ),




            ],
          ),
        ),
      ),


    );
  }








}