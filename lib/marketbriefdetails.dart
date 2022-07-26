// @dart=2.9
import 'package:flutter/material.dart';
import 'package:itpcchennaiapp/marketbriefindia.dart';
import 'package:pdf_viewer_jk/pdf_viewer_jk.dart';


class marketbriefdtls extends StatefulWidget {

  marketbriefdtls({this.userid, this.Type, this.content, this.Name, this.signupid,this.previouspage, this.Url});

  var userid;
  var Type;
  var content;
  var Name;
  var signupid;
  var previouspage;
  var Url;


  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<marketbriefdtls> {
  bool _isLoading = true;
  PDFDocument document;
  String title = "Loading";

  @override
  void initState() {
    super.initState();

    loadDocument(1);
  }

  loadDocument(value) async {
    setState(() {
      _isLoading = true;
      title = "Loading";
    });
    if (value == 1) {
      document = await PDFDocument.fromURL(widget.Url);
    } else {
      document = await PDFDocument.fromAsset('assets/sample.pdf');
    }
    setState(() {
      title = (value == 1) ? "Loaded From Url" : "Loaded From Assets";
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
//            drawer: Drawer(
//              child: Column(
//                children: <Widget>[
//                  SizedBox(height: 36),
//                  ListTile(
//                    title: Text('Load from URL'),
//                    onTap: () {
//                      loadDocument(1);
//                    },
//                  ),
//                  ListTile(
//                    title: Text('Load from Assets'),
//                    onTap: () {
//                      loadDocument(0);
//                    },
//                  ),
//                ],
//              ),
//            ),
            appBar:

            AppBar(
              title: Text(''),
              backgroundColor: Colors.white,
              leading: GestureDetector(
                child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
                onTap: () {


                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>
                        marketbriefindia(
                            userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid

                        )),
                  );

                } ,
              ) ,
            ),
//            AppBar(
//              title: Text(''),
//              automaticallyImplyLeading: false,
//              leadingWidth: 100,
//              leading: ElevatedButton.icon(
//                onPressed: (){
//                  // Do something
//
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) =>
//                        marketbriefindia(
//                            userid:widget.userid ,Type:widget.Type,content:widget.content,Name:widget.Name,signupid:widget.signupid
//
//                        )),
//                  );
//
//                },
//                icon: const Icon(Icons.arrow_back_ios),
//                label: const Text('Back'),
//                style: ElevatedButton.styleFrom(
//                    elevation: 0, primary: Colors.transparent),
//              ),
//            ),


            body:

            Container(
              color:Color(0xFFCCCCCC),
              child:
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 10, bottom: 0),
                child:
                Center(
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : PDFViewer(
                      document: document,
                      zoomSteps: 100,
                      //preload all pages
                      lazyLoad: false,
                      // scroll vertically
                      scrollDirection: Axis.vertical,





                      //uncomment below code to replace bottom navigation with your own
                      /* navigationBuilder:
                      (context, page, totalPages, jumpToPage, animateToPage) {
                    return ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page),
                          onPressed: () {
                            jumpToPage()(page: 0);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            animateToPage(page: page - 2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            animateToPage(page: page);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () {
                            jumpToPage(page: totalPages - 1);
                          },
                        ),
                      ],
                    );
                  }, */
                    )),
              ),

            )





        )
    );
  }
}

