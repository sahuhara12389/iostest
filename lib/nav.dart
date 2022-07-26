import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itpcchennaiapp/login.dart';
import 'package:itpcchennaiapp/sellerdashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';




class SettingsUI extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Setting UI",
            home: NavDrawer(),
        );
    }
}

class NavDrawer extends StatefulWidget {


// Creating String Var to Hold sent UserID.
//  final String userid;
//
//// Receiving UserID using Constructor.
//  NavDrawer({Key key, @required this.userid}) : super(key: key);
    NavDrawer({this.userid,this.Type});

    var userid;
    var Type;

    @override
    _EditProfilePageState createState() => _EditProfilePageState();
}




class _EditProfilePageState extends State<NavDrawer> {





    void initState() {
        super.initState();


        print('-1-1-1-4');
        print(widget.userid);


        //futureAlbum = fetchAlbum();
    }


    void _handleLogout() async {
        print('logout');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove("SessionUserid");
        prefs.remove("SessionMemberUserid");
        prefs.remove("SessionFIRSTNAME");
        prefs.remove("SessionLevel");
//    Navigator.pushNamedAndRemoveUntil(
////        context, '/signin', ModalRoute.withName('/signin'));



        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => login()),
        );






    }





    @override
    Widget build(BuildContext context) {


        return


            Container(
                width: MediaQuery.of(context).size.width * 1,
                //   height: MediaQuery.of(context).size.height * 1,
                child:
                Drawer(

                    child:
                    Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                // colors: [Color(0xFF191B2A).withOpacity(1), Color(0xFF191B2A).withOpacity(0.8)],
                                colors: [Color(0xFFffffff).withOpacity(1), Color(0xFFffffff).withOpacity(1)],
                                begin: FractionalOffset.centerLeft,
                                end: FractionalOffset.centerRight,
                            ),

                        ),
                        child:
                        SingleChildScrollView(child:
                        Column(

                            children: <Widget>[







                                Column(

                                    children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                                            child: Container(

                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                                    gradient: LinearGradient(
                                                        // colors: [Color(0xFF191B2A).withOpacity(1), Color(0xFF191B2A).withOpacity(0.8)],
                                                        colors: [Color(0xFFCFD0D6).withOpacity(1), Color(0xFFCFD0D6).withOpacity(1)],
                                                        begin: FractionalOffset.centerLeft,
                                                        end: FractionalOffset.centerRight,
                                                    ),

                                                ),
                                                width: double.infinity,
                                                padding: EdgeInsets.all(0),

                                                //color: Theme.of(context).primaryColor,
                                                child: Center(

                                                    child: Column(

                                                        children: <Widget>[



                                                            Row(
                                                                children: [
                                                                    Container(

                                                                        child:
                                                                        Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left:15.0, right: 0.0, top: 10, bottom: 0),
                                                                            child:
                                                                            Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [

                                                                                    SizedBox(
                                                                                        height: 10,
                                                                                    ),

                                                                                    SizedBox(
                                                                                        height: 10,
                                                                                    ),
                                                                                    Row(
                                                                                        children: [

                                                                                            SizedBox(
                                                                                                width: 10,
                                                                                            ),

                                                                                            Text('Welcome',style: const TextStyle(
                                                                                                color: Colors.black,
                                                                                                fontSize: 12.0,
                                                                                                fontWeight: FontWeight.normal,
                                                                                                fontFamily: 'Noto Sans'
                                                                                            ),),
                                                                                        ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                        height: 10,
                                                                                    ),


                                                                                ],

                                                                            ),
                                                                        ),


                                                                    ),
                                                                    Container(
                                                                        child:   Align(
                                                                            alignment: Alignment.topRight,
                                                                            child:

                                                                            Padding(
                                                                                padding: const EdgeInsets.only(
                                                                                    left:30.0, right: 0.0, top: 0, bottom: 0),
                                                                                child:

                                                                                GestureDetector(
                                                                                    onTap: (){
//                              Navigator.push(context,
//                                  MaterialPageRoute(builder: (_) => signup()));
                                                                                    },
                                                                                    child: new
                                                                                    Container(
                                                                                        decoration: BoxDecoration(
                                                                                            color:Color(0xFFFAD330) ,

                                                                                            borderRadius: BorderRadius.circular(5),
                                                                                        ),
                                                                                        height: 30,
                                                                                        width: 60,
                                                                                        child: Padding(
                                                                                            padding: const EdgeInsets.all(1.5),
                                                                                            child:


                                                                                            Container(


                                                                                                child: Center(
                                                                                                    child:
                                                                                                    Text('VERIFY',  style: TextStyle(
                                                                                                        color: Colors.black, fontSize: 10,fontFamily: 'Noto Sans'),
                                                                                                    ),),



                                                                                            ),




                                                                                        ),
                                                                                    ),
                                                                                ),)
                                                                        ),

                                                                    ),
                                                                ],
                                                            ),


                                                            Row(
                                                                children: [

                                                                    Flexible(
                                                                        flex: 5,
                                                                        fit: FlexFit.tight,
                                                                        child:
                                                                        Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left:15.0, right: 1.0, top: 0, bottom: 0),
                                                                            child: Text('ID : '+widget.userid,style: const TextStyle(
                                                                                color: Color(0xFF585974),
                                                                                fontSize: 15.0,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontFamily: 'Noto Sans'
                                                                            ),),
                                                                        ),
                                                                    ),
                                                                    Flexible(
                                                                        flex: 5,
                                                                        fit: FlexFit.tight,
                                                                        child:
                                                                        Align(
                                                                            alignment: Alignment.centerRight,
                                                                            child:
                                                                            Padding(
                                                                                padding: const EdgeInsets.only(
                                                                                    left:0.0, right: 15.0, top: 0, bottom: 0),
                                                                                child:
                                                                                GestureDetector(
                                                                                    child: Text("CLICK TO COPY" ,style: const TextStyle(
                                                                                        color: Color(0xFF0177FB),
                                                                                        fontSize: 12.0,
                                                                                        fontWeight: FontWeight.normal,
                                                                                        fontFamily: 'Noto Sans'
                                                                                    ),),
                                                                                    onTap: () {

                                                                                        Clipboard.setData(ClipboardData(text: widget.userid));
                                                                                        // do what you need to do when "Click here" gets clicked
                                                                                    }
                                                                                )


                                                                            ),
                                                                        ),
                                                                    ),

                                                                ],
                                                            ),
                                                            SizedBox(
                                                                height: 15,
                                                            ),













//                 ListTile(leading: Icon(Icons.redeem), title: Text("Logout"),
//
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     Navigator.of(context).push(
//                       PageRouteBuilder(pageBuilder: (context, _, __) {
//                         return logout(
//
//                         );
//                       }, transitionsBuilder: (_, __, ___, Widget child) {
//                         return child;
//                       }),
//                     );
//                   },
//
//
//                 ),



                                                        ],



                                                    ),
                                                ),
                                            )
                                        ),
                                    ],
                                ),


                                //Text(snapshot.data.RETURN_Name,  style: TextStyle(fontSize: 18,color: Colors.black),textAlign: TextAlign.center,);



                                Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child:Container(
                                        //  height:750,
                                        width:400.0,


                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                // colors: [Color(0xFF191B2A).withOpacity(1), Color(0xFF191B2A).withOpacity(0.8)],
                                                colors: [Color(0xFFffffff).withOpacity(1), Color(0xFFffffff).withOpacity(0.9)],
                                                begin: FractionalOffset.centerLeft,
                                                end: FractionalOffset.centerRight,
                                            ),

                                        ),



                                        child: new SingleChildScrollView(
                                            child: new



                                            Column(
                                                children: <Widget>[


                                                    Divider(
                                                        thickness: 1,
                                                        height: 0,
                                                        indent: 20,
                                                        endIndent: 0,
                                                        // color: Colors.white30,
                                                    ),

                                                    ListTile(
                                                        leading:  Image.asset( "images/dashboard.png",color: Colors.black, height: 25,),

                                                        title: Text('Dashboard',style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: 'Noto Sans', fontWeight: FontWeight.bold),),

                                                        onTap: () {
                                                            Navigator.of(context).pop();
                                                            Navigator.of(context).push(
                                                                PageRouteBuilder(pageBuilder: (context, _, __) {
                                                                    return sellerdashbaord(
                                                                        userid:widget.userid,Type: widget.Type
                                                                    );
                                                                }, transitionsBuilder: (_, __, ___, Widget child) {
                                                                    return child;
                                                                }),
                                                            );
                                                        },
                                                        trailing: Image.asset( "images/arrow.png", height: 25,),
                                                    ),
                                                    Divider(
                                                        thickness: 1,
                                                        height: 0,
                                                        indent: 20,
                                                        endIndent: 0,
                                                        // color: Colors.white30,
                                                    ),
//                              ListTile(
//                                leading:  Image.asset( "images/task.png", height: 25,),
//
//                                title: Text('Task Center',style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold,fontFamily: 'Noto Sans'),),
//
//                                onTap: () {
//                                  Navigator.of(context).pop();
//                                  Navigator.of(context).push(
//                                    PageRouteBuilder(pageBuilder: (context, _, __) {
//                                      return minning(
//                                        userid:widget.userid,Password: _pass,Name: widget.Name,email: widget.email,
//                                      );
//                                    }, transitionsBuilder: (_, __, ___, Widget child) {
//                                      return child;
//                                    }),
//                                  );
//                                },
//                                trailing: Image.asset( "images/arrow.png", height: 25,),
//                              ),
                                                    Divider(
                                                        thickness: 1,
                                                        height: 0,
                                                        indent: 20,
                                                        endIndent: 0,
                                                        // color: Colors.white30,
                                                    ),
                                                    ListTile(
                                                        leading:  Image.asset( "images/reward.png",color: Colors.black,height: 25,),

                                                        title: Text('Activation',style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Noto Sans'),),

//                                    onTap: () {
//                                      Navigator.of(context).pop();
//                                      Navigator.of(context).push(
//                                        PageRouteBuilder(pageBuilder: (context, _, __) {
//                                          return activation(
//                                            userid:widget.userid,Password: _pass,Name: widget.Name,email: widget.email,
//                                          );
//                                        }, transitionsBuilder: (_, __, ___, Widget child) {
//                                          return child;
//                                        }),
//                                      );
//                                    },
                                                        trailing: Image.asset( "images/arrow.png", height: 25,),
                                                    ),

                                                    Divider(
                                                        thickness: 1,
                                                        height: 0,
                                                        indent: 20,
                                                        endIndent: 0,
                                                        // color: Colors.white30,
                                                    ),


//                                  ListTile(
//                                    leading:  Image.asset( "images/kyc.png",color: Colors.black, height: 25,),
//
//                                    title: Text('Account Verification',style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Noto Sans'),),
//
//                                    onTap: () {
//                                      Navigator.of(context).pop();
//                                      Navigator.of(context).push(
//                                        PageRouteBuilder(pageBuilder: (context, _, __) {
//                                          return kycc(
//                                            userid:widget.userid,Password: _pass,Name: widget.Name,email: widget.email,
//                                          );
//                                        }, transitionsBuilder: (_, __, ___, Widget child) {
//                                          return child;
//                                        }),
//                                      );
//                                    },
//                                    trailing: Image.asset( "images/arrow.png", height: 25,),
//                                  ),
                                                    Divider(
                                                        thickness: 1,
                                                        height: 0,
                                                        indent: 20,
                                                        endIndent: 0,
                                                        // color: Colors.white30,
                                                    ),

//                                  ListTile(
//                                    leading:  Image.asset( "images/myreferral.png",color: Colors.black, height: 25,),
//
//                                    title: Text('My Referral',style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Noto Sans'),),
//
//                                    onTap: () {
//                                      Navigator.of(context).pop();
//                                      Navigator.of(context).push(
//                                        PageRouteBuilder(pageBuilder: (context, _, __) {
//                                          return myreferral(
//                                            userid:widget.userid,Password: _pass,Name: widget.Name,email: widget.email,
//                                          );
//                                        }, transitionsBuilder: (_, __, ___, Widget child) {
//                                          return child;
//                                        }),
//                                      );
//                                    },
//                                    trailing: Image.asset( "images/arrow.png", height: 25,),
//                                  ),
//                                  Divider(
//                                    thickness: 1,
//                                    height: 0,
//                                    indent: 20,
//                                    endIndent: 0,
//                                    // color: Colors.white30,
//                                  ),





//                                  ListTile(
//                                    leading:  Image.asset( "images/myreferral.png",color: Colors.black, height: 25,),
//
//                                    title: Text('My Referral',style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Noto Sans'),),
//
//                                    onTap: () {
//                                      Navigator.of(context).pop();
//                                      Navigator.of(context).push(
//                                        PageRouteBuilder(pageBuilder: (context, _, __) {
//                                          return inirectmyreferralcollectcoin(
//                                            userid:widget.userid,Password: _pass,Name: widget.Name,email: widget.email,
//                                          );
//                                        }, transitionsBuilder: (_, __, ___, Widget child) {
//                                          return child;
//                                        }),
//                                      );
//                                    },
//                                    trailing: Image.asset( "images/arrow.png", height: 25,),
//                                  ),
                                                    Divider(
                                                        thickness: 1,
                                                        height: 0,
                                                        indent: 20,
                                                        endIndent: 0,
                                                        // color: Colors.white30,
                                                    ),

//                                  ListTile(
//                                    leading:  Image.asset( "images/incomeicon_.png",color: Colors.black, height: 25,),
//
//                                    title: Text('My Income',style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Noto Sans'),),
//
//                                    onTap: () {
//                                      Navigator.of(context).pop();
//                                      Navigator.of(context).push(
//                                        PageRouteBuilder(pageBuilder: (context, _, __) {
//                                          return binarycomm(
//                                            userid:widget.userid,Password: _pass,Name: widget.Name,email: widget.email,
//                                          );
//                                        }, transitionsBuilder: (_, __, ___, Widget child) {
//                                          return child;
//                                        }),
//                                      );
//                                    },
//                                    trailing: Image.asset( "images/arrow.png", height: 25,),
//                                  ),
                                                    Divider(
                                                        thickness: 1,
                                                        height: 0,
                                                        indent: 20,
                                                        endIndent: 0,
                                                        // color: Colors.white30,
                                                    ),


//
//                                  ListTile(
//                                    leading:  Image.asset( "images/incomeicon_.png",color: Colors.black, height: 25,),
//
//                                    title: Text('Founder Bonus',style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Noto Sans'),),
//
//                                    onTap: () {
//                                      Navigator.of(context).pop();
//                                      Navigator.of(context).push(
//                                        PageRouteBuilder(pageBuilder: (context, _, __) {
//                                          return founderbonus(
//                                            userid:widget.userid,Password: _pass,Name: widget.Name,email: widget.email,
//                                          );
//                                        }, transitionsBuilder: (_, __, ___, Widget child) {
//                                          return child;
//                                        }),
//                                      );
//                                    },
//                                    trailing: Image.asset( "images/arrow.png", height: 25,),
//                                  ),
//                                  Divider(
//                                    thickness: 1,
//                                    height: 0,
//                                    indent: 20,
//                                    endIndent: 0,
//                                    // color: Colors.white30,
//                                  ),
//
//                                  ListTile(
//                                    leading: Image.asset( "images/incomeicon_.png",color: Colors.black, height: 25,),
//
//                                    title: Text('My Referral Income',style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Noto Sans'),),
//
//                                    onTap: () {
//                                      Navigator.of(context).pop();
//                                      Navigator.of(context).push(
//                                        PageRouteBuilder(pageBuilder: (context, _, __) {
//                                          return directincomereport(
//                                            userid:widget.userid,Password: _pass,Name: widget.Name,email: widget.email,
//                                          );
//                                        }, transitionsBuilder: (_, __, ___, Widget child) {
//                                          return child;
//                                        }),
//                                      );
//                                    },
//                                    trailing: Image.asset( "images/arrow.png", height: 25,),
//                                  ),
//                                  Divider(
//                                    thickness: 1,
//                                    height: 0,
//                                    indent: 20,
//                                    endIndent: 0,
//                                    // color: Colors.white30,
//                                  ),
//
//
//                                  ListTile(
//                                    leading:  Image.asset( "images/incomeicon_.png",color: Colors.black, height: 25,),
//
//                                    title: Text('Level Income',style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Noto Sans'),),
//
//                                    onTap: () {
//                                      Navigator.of(context).pop();
//                                      Navigator.of(context).push(
//                                        PageRouteBuilder(pageBuilder: (context, _, __) {
//                                          return levelincome(
//                                            userid:widget.userid,Password: _pass,Name: widget.Name,email: widget.email,
//                                          );
//                                        }, transitionsBuilder: (_, __, ___, Widget child) {
//                                          return child;
//                                        }),
//                                      );
//                                    },
//                                    trailing: Image.asset( "images/arrow.png", height: 25,),
//                                  ),
//                                  Divider(
//                                    thickness: 1,
//                                    height: 0,
//                                    indent: 20,
//                                    endIndent: 0,
//                                    // color: Colors.white30,
//                                  ),
//





//                                  ListTile(
//                                    leading:  Image.asset( "images/help.png",color: Colors.black, height: 25,),
//
//                                    title: Text('Help & Support',style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Noto Sans'),),
//
//                                    onTap: () {
//                                      Navigator.of(context).pop();
//                                      Navigator.of(context).push(
//                                        PageRouteBuilder(pageBuilder: (context, _, __) {
//                                          return createsupport(
//                                            userid:widget.userid,Password: _pass,Name: widget.Name,email: widget.email,
//                                          );
//                                        }, transitionsBuilder: (_, __, ___, Widget child) {
//                                          return child;
//                                        }),
//                                      );
//                                    },
//                                    trailing: Image.asset( "images/arrow.png", height: 25,),
//                                  ),



//                                  ListTile(
//                                    leading:  Image.asset( "images/share.png",color: Colors.black, height: 25,),
//
//                                    title: Text('Graph',style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Noto Sans'),),
//
//                                    onTap: () {
//                                      Navigator.of(context).pop();
//                                      Navigator.of(context).push(
//                                        PageRouteBuilder(pageBuilder: (context, _, __) {
//                                          return chart(
//                                           // userid:widget.userid,Password: _pass,Name: widget.Name,email: widget.email,
//                                          );
//                                        }, transitionsBuilder: (_, __, ___, Widget child) {
//                                          return child;
//                                        }),
//                                      );
//                                    },
//                                    trailing: Image.asset( "images/arrow.png", height: 25,),
//                                  ),
//
//
//
//                                  ListTile(
//                                    leading:  Image.asset( "images/share.png",color: Colors.black, height: 25,),
//
//                                    title: Text('welcome',style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Noto Sans'),),
//
//                                    onTap: () {
//                                      Navigator.of(context).pop();
//                                      Navigator.of(context).push(
//                                        PageRouteBuilder(pageBuilder: (context, _, __) {
//                                          return
//                                            welcome(userid:"4",Password:"2",Name:"s");
//                                        }, transitionsBuilder: (_, __, ___, Widget child) {
//                                          return child;
//                                        }),
//                                      );
//                                    },
//                                    trailing: Image.asset( "images/arrow.png", height: 25,),
//                                  ),


                                                    ListTile(
                                                        leading:  Image.asset( "images/logout.png",color: Colors.black, height: 25,),

                                                        title: Text('Logout',style: TextStyle(fontSize: 16,color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Noto Sans'),),

                                                        onTap: () {
                                                            _handleLogout();

                                                        },
                                                        trailing: Image.asset( "images/arrow.png", height: 25,),
                                                    ),




                                                ],
                                            )

                                        )



                                    ),),



                            ],
                        ),
                        ),

                    )




                )
            );
    }


}

