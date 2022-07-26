
// @dart=2.9
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path/path.dart';




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

  List<Asset> imagesList = <Asset>[];
  String _error = 'No Error Dectected';

  bool showSpinner = false  ;

  @override
  void initState() {
    super.initState();
  }



  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(imagesList.length, (index) {
        Asset asset = imagesList[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
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

    try{
      setState(() {
        showSpinner = true ;
      });

      var uri = Uri.parse('https://itpcchennai.com/web_api/public/add_product');
      http.MultipartRequest request = new http.MultipartRequest('POST', uri);

      request.fields['property_title'] = 'Testxxx';
      request.fields['property_category'] = 'Banana';
      request.fields['prop_desc'] = 'xxxxxxxxxxxxxxxx';
      request.fields['property_company'] = 'bbf';
      request.fields['signCateg'] = '1';
      request.fields['email'] = 'sahu53@gmail.com';



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

      response.stream.transform(utf8.decoder).listen((value) {
        print('value') ;
        print(value);
      });

      if (response.statusCode == 200) {
        setState(() {
          showSpinner = false ;
        });

        print('uploaded');


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
      child: Scaffold(
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


        Container(
          child: Column(
            children: <Widget>[
              Center(child: Text('Error: $_error')),
              ElevatedButton(
                child: Text("Pick images"),
                onPressed: loadAssets,
              ),
              Expanded(
                child: buildGridView(),
              ),
              Visibility(
                visible: imagesList.isEmpty ? false : true,
                child: ElevatedButton(
                  child: Text("Upload"),
                  onPressed: ()async {
                    uploadImageToServer(context);
                  },
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}