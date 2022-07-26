// @dart=2.9
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


void main() => runApp(gallerymultitests());

class gallerymultitests extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<gallerymultitests> {


  List _images=[];
  File imagefile;

  final picker= ImagePicker();

  chooseImage() async{

    final pickedfile= await picker.getImage(source: ImageSource.gallery);
    if(pickedfile != null)
      {
        setState(() {
          _images.add(File(pickedfile.path));

          print(_images.toString());
        });
      }

  }



  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
        backgroundColor: Color(0xFFffffff),





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
      child:



      StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: _images.length+1,

        itemBuilder: (BuildContext context, index){

          return index == _images.length
            ? GestureDetector(
            onTap: (){
              chooseImage();
            } ,
              child: Container(
              child: DottedBorder(
                color: Colors.grey,
                strokeWidth: 2 ,
                radius: Radius.circular(8),
                dashPattern: [8,4],
                child: ClipRect(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Icon(Icons.add),
                  ),
                ),

              ) ,
          ),
            )
              :Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              image: DecorationImage(
                image: FileImage(_images[index]),
                fit: BoxFit.cover
              )
            ),
          );
        },
        staggeredTileBuilder: (int index)=> new  StaggeredTile.count(index == 0?2:1, index == 0?2:1 ),
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        ),

      ),




    );








  }



}