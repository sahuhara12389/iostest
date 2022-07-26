// @dart=2.9
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path/path.dart';

void main() {
  runApp(multiupload());
}

class multiupload extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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

      request.fields['property_title'] = 'abcs';
      request.fields['property_category'] = 'banana';
      request.fields['prop_desc'] = 'piza';
      request.fields['property_company'] = 'baacom';
      request.fields['signCateg'] = 'Global';
      request.fields['email'] = 'sahu53@gmail.com';

      print(imagesList.toString()) ;
      request.files.add(
          await http.MultipartFile.fromPath('multiple_image', imagesList.toString()));


    //  List<http.MultipartFile> newList = new List<http.MultipartFile>();

     // var multipartFile = new http.MultipartFile("multiple_image", imageFile.path);


      print('02222') ;
//      for (int i = 0; i < imagesList.length; i++) {
//
//        print('03333') ;
//        print(imagesList[i].toString()) ;
//        var path = await FlutterAbsolutePath.getAbsolutePath(imagesList[i].identifier);
//        print(path) ;
//        print('04444') ;
//        File imageFile =  File(path);
//        print('05555') ;
//        var stream = new http.ByteStream(imageFile.openRead());
//        print('06666') ;
//        var length = await imageFile.length();
//        print('07777') ;
//
//
//        print('088888') ;
//        newList.add(multipartFile);
//
//        print('099999') ;
//      }

//      print('100000') ;
//
//      request.files.addAll(newList);
//      print('11111111') ;
//      var response = await request.send();
//      print('2222222') ;
//      print(response.toString()) ;
//
//      response.stream.transform(utf8.decoder).listen((value) {
//        print('3333333333') ;
//        print(value);
//      });
     print('100000') ;
      http.StreamedResponse response = await request.send();
      print('100001') ;
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
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
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