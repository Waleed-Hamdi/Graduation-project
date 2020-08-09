import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:our_project/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:fleva_icons/fleva_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class proddetails extends StatefulWidget {
  String Address, Description, City, DocID, Price, number,Rating;
  proddetails(this.Address, this.Description, this.City, this.Price,
      this.number, this.DocID,this.Rating);
  @override
  _proddetailsState createState() => _proddetailsState();
}

class _proddetailsState extends State<proddetails>
    with SingleTickerProviderStateMixin {
  final waleed = Firestore.instance;

//  String imagee1, imagee2, imagee3, imagee4, imagee5, imagee6;

  Map<dynamic, dynamic> images = {"waleed": "hamdi"};
  int x = 0;

  Future<void> _launched;
  String _phone = '';

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  AnimationController controller;
  Animation animation;


  @override
  void initState() {
    super.initState();

    images.clear();
    waleed.collection("images").document(widget.DocID).get().then((value) {
      images = value.data;
      x = images.length;
      print(images);
      print(value.data.toString() + "hello waleed");
    });
    controller = AnimationController(
        vsync: this,
        upperBound: 1,
        lowerBound: 0,
        duration: Duration(seconds: 4));
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

//  void prin() async {
//    imagee1 = images["urls1"];
//    imagee2 = images["urls2"];
//    imagee3 = images["urls3"];
//    imagee4 = images["urls4"];
//    setState(() {});
//    print(images[0]["urls2"]);
//  }

  void _showRatingDialog() {
    // We use the built in showDialog function to show our Rating Dialog
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: Icon(FlevaIcons.bar_chart,), // set your own image/icon widget
            title: "Rating Product",
            description:
            "Tap a star to set your rating.",
            submitButton: "SUBMIT",
            alternativeButton: "Contact us instead?", // optional
            positiveComment: "We are so happy to hear :)", // optional
            negativeComment: "We're sad to hear :(", // optional
            accentColor: Colors.red, // optional
            onSubmitPressed: (int rating) async{
              var firebaseUser = await FirebaseAuth.instance.currentUser();
              try {
                final result = await Firestore.instance.collection('products').document(widget.DocID).updateData({
                  "Rating" : rating.toString(),
                }).then((_) {
                  print("Done");
                });
              } catch (e) {
                print(e);
              }
              print("onSubmitPressed: rating = $rating");
              // TODO: open the app's page on Google Play / Apple App Store
            },
            onAlternativePressed: () {
              print("onAlternativePressed: do something");
              // TODO: maybe you want the user to contact you instead of rating a bad review
            },
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double hieght = MediaQuery.of(context).size.height;
    final double wid = MediaQuery.of(context).size.width;

    double initalsize;
    return Scaffold(
        appBar: AppBar(
          elevation: 25.0,
          backgroundColor: Colors.indigo,
          centerTitle: true,
          title: InkWell(
            child: Text("Product Details",
                style: GoogleFonts.aclonica(fontSize: hieght * 0.04)),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => home()));
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: <Widget>[
            controller.value != 1
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        controller.value == 1 ? "Done" : "Loading ... ",
                        style: GoogleFonts.lacquer(fontSize: 20),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 7),
                        height: 60,
                        child: LiquidLinearProgressIndicator(
                          borderRadius: 20,
                          direction: Axis.horizontal,
                          value: controller.value,
                          backgroundColor: Colors.white,
                          borderColor: Colors.indigo,
                          borderWidth: 2,
                          center: Text(
                            "${(controller.value * 100).round()}" + "%",
                            style: GoogleFonts.lacquer(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  )
//                  controller.value == 1
//                      ? Center(
//                          child: RaisedButton(
//                              child: Text("Get images"), onPressed: prin),
//                        )
//                      :
                : ListView(
                    children: <Widget>[
                      Pad(images["urls0"]),
                      Pad(images["urls1"]),
                      Pad(images["urls2"]),
                      images["urls3"] == null ? Text(" "): Pad(images["urls3"]),
                      images["urls4"] == null ? Text(" "): Pad(images["urls4"]),
                      images["urls5"] == null ? Text(" "): Pad(images["urls5"]),
                      images["urls6"] == null ? Text(" "): Pad(images["urls6"]),
                      images["urls7"] == null ? Text(" "): Pad(images["urls7"]),
                      images["urls8"] == null ? Text(" "): Pad(images["urls8"]),
                      images["urls9"] == null ? Text(" "): Pad(images["urls9"]),

                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
//            Center(
//              child: RaisedButton(
//                color: Colors.red,
//                onPressed: (){
//                  setstate();
//                },
//                child: Container(
//                  child: Pad(listimg),
//                ),
//              ),
//            ),
            DraggableScrollableSheet(
              expand: true,
              minChildSize: 0.14,
              maxChildSize: 1,
              initialChildSize: 0.14,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Card(
                  color: Color.fromRGBO(80, 11, 76, 1),
                  child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Scroll UP For Details",
                            style: GoogleFonts.pacifico(
                                color: Colors.white, fontSize: hieght * 0.04),
                          ),
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                            size: 30.0,
                          )
                        ],
                      ),
                      subtitle: ListView(
                        shrinkWrap: true,
                        controller: scrollController,
                        children: <Widget>[
                          Card(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "City",
                                  style: GoogleFonts.aclonica(
                                      fontSize: hieght * 0.05),
                                ),
                                Text(
                                  widget.City,
                                  style:
                                  GoogleFonts.lato(fontSize: hieght * 0.04),
                                ),                                Divider(
                                  color: Colors.indigo,
                                  thickness: 5.0,
                                ),
                                Text(
                                  "Address",
                                  style: GoogleFonts.aclonica(
                                      fontSize: hieght * 0.05),
                                ),
                                Text(
                                  widget.Address,
                                  style:
                                  GoogleFonts.lato(fontSize: hieght * 0.04),
                                ),                                Divider(
                                  color: Colors.indigo,
                                  thickness: 5.0,
                                ),
                                Text(
                                  "Description",
                                  style: GoogleFonts.aclonica(
                                      fontSize: hieght * 0.05),
                                ),
                                Text(
                                  widget.Description,
                                  style:
                                  GoogleFonts.lato(fontSize: hieght * 0.04),
                                ),
                                Divider(
                                  color: Colors.indigo,
                                  thickness: 5.0,
                                ),
                                Text(
                                  "Price",
                                  style: GoogleFonts.aclonica(
                                      fontSize: hieght * 0.05),
                                ),
                                Text(
                                  widget.Price,
                                  style:
                                  GoogleFonts.lato(fontSize: hieght * 0.04),
                                ),                                Divider(
                                  color: Colors.indigo,
                                  thickness: 5.0,
                                ),
                                Text(
                                  "Phone number",
                                  style: GoogleFonts.aclonica(
                                      fontSize: hieght * 0.05),
                                ),
                                Text(
                                  widget.number,
                                  style:
                                  GoogleFonts.lato(fontSize: hieght * 0.04),
                                ),
                                Divider(
                                  color: Colors.indigo,
                                  thickness: 5.0,
                                ),
                                Text(
                                  "Last Rate",
                                  style: GoogleFonts.aclonica(
                                      fontSize: hieght * 0.05),
                                ),
                                Text(
                                  "${widget.Rating} /5",
                                  style: GoogleFonts.aclonica(
                                      fontSize: hieght * 0.05),
                                ),
                                Divider(
                                  color: Colors.indigo,
                                  thickness: 5.0,
                                ),
                                Center(
                                  child: RaisedButton(
                                    color: Colors.indigo,
                                    child: Text("Rating Product",style: GoogleFonts.lato(color: Colors.white,fontSize: hieght * 0.05),),
                                    onPressed: _showRatingDialog,
                                  ),
                                ),

                                Center(
                                  child: InkWell(
                                    onTap: () => setState(() {
                                      _launched = _makePhoneCall('tel:${widget.number}');
                                    }),
                                    child: Card(
                                        color: Colors.green,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Center(
                                              child: IconButton(
                                                  onPressed: () => setState(() {
                                                    _makePhoneCall('${widget.number}');
                                                  }),
                                                  icon:
                                                      Icon(EvaIcons.phoneCall)),
                                            ),
                                            Text(
                                              "   Call    ",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.pacifico(
                                                  fontSize: hieght * 0.04),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                                Divider(
                                  height: hieght * 0.1,
                                  color: Colors.indigo,
                                  thickness: 5.0,
                                ),
                              ],
                            ),
                          )
//                          card("City", widget.City),
//                          card("Address", widget.Address),
//                          card("Description", widget.Description),
//                          card("Price", widget.Price.toString()),
//                          card("Phone", widget.number.toString()),
//                          card("Phone", widget.number.toString()),
//                          card("Phone", widget.number.toString()),
//                          card("Phone", widget.number.toString()),
                        ],
                      )),
                );
              },
            ),
          ],
        ));
  }

  Widget card(String text1, String text2) {
    return Card(
      color: Color.fromRGBO(180, 29, 130, 0.8),
      child: Container(
          height: text1 == "Price" || text1 == "Phone" || text1 == "City"
              ? 80
              : 150,
          width: double.infinity,
          child: ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    text1,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    text2,
                    style: TextStyle(color: Colors.white),
                  ),
                  flex: 2,
                ),
              ],
            ),
          )),
    );
  }

  Widget Pad(String url) {
    if (url != null) {
      print(url + "hello waleed");
      return Card(
        elevation: 10.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
          child: Image(
              image: NetworkImage(url.toString()),
              loadingBuilder: (context, child, progress) {
                return progress == null ? child : LinearProgressIndicator();
              }),
        ),
      );
    } else {
      return Text("  ");
    }
  }

//  Widget image(images , y) {
//    return Container(
//      decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(10.0),
//          border: Border.all(
//              color: Colors.indigo[600], style: BorderStyle.solid, width: 3.0)),
//      height: 250.0,
//      child: Carousel(
//        dotSize: 3.0,
//        indicatorBgPadding: 8.0,
//        boxFit: BoxFit.fill,
//        images: [
//          Image.network(images["urls0"]),
//          Image.network(images["urls1"]),
//          Image.network(images["urls2"]),
//        ],
//      ),
//    );
//  }

}
