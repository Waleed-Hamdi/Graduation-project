import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:our_project/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:photo_view/photo_view.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class proddetails extends StatefulWidget {
  String Address, Description, City, DocID, Price, number;
  proddetails(this.Address, this.Description, this.City, this.Price,
      this.number, this.DocID);
  @override
  _proddetailsState createState() => _proddetailsState();
}

class _proddetailsState extends State<proddetails>
    with SingleTickerProviderStateMixin {
//  Widget image() {
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
//          AssetImage("images/1.jpg"),
//          AssetImage("images/2.jpg"),
//          AssetImage("images/3.jpg"),
//          AssetImage("images/4.jpg"),
//          AssetImage("images/5.jpg"),
//        ],
//      ),
//    );
//  }

  final waleed = Firestore.instance;

  String imagee1, imagee2, imagee3, imagee4, imagee5, imagee6;

  Map images = {"waleed": "hamdi"};
  List listimg = [];

  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    images.clear();
    waleed.collection("images").document(widget.DocID).get().then((value) {
      images = value.data;
      listimg.add(images.values);
      print(value.data.toString() + "hello waleed");
      print(listimg);
    });
    controller = AnimationController(
        vsync: this,
        upperBound: 1,
        lowerBound: 0,
        duration: Duration(seconds: 10));
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
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double initalsize;
    return Scaffold(
        appBar: AppBar(
          elevation: 25.0,
          backgroundColor: Colors.indigo,
          centerTitle: true,
          title: InkWell(
            child:
                Text("Renting App", style: GoogleFonts.aclonica(fontSize: 30)),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => home()));
            },
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: <Widget>[

            controller.value != 1 ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(controller.value == 1 ? "Done" : "Loading ... ",style: GoogleFonts.lacquer(
                fontSize: 20
            ),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6,vertical: 7),
              height: 60,
              child: LiquidLinearProgressIndicator(
                borderRadius: 20,
                direction: Axis.horizontal,
                value: controller.value,
                backgroundColor: Colors.white,
                borderColor: Colors.indigo,borderWidth: 2,
                center: Text("${(controller.value * 100).round()}" + "%",style: GoogleFonts.lacquer(
                    fontSize: 20
                ),),
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
                            Pad(images["urls3"]),
                            SizedBox(
                              height: 80,
                            )
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
              minChildSize: 0.12,
              maxChildSize: 1,
              initialChildSize: 0.12,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Card(
                  color: Colors.indigo,
                  child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Scroll UP For Details",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                            size: 30.0,
                          )
                        ],
                      ),
                      subtitle: ListView(
                        controller: scrollController,
                        children: <Widget>[
                          card("City", widget.City),
                          card("Address", widget.Address),
                          card("Description", widget.Description),
                          card("Price", widget.Price.toString()),
                          card("Phone", widget.number.toString()),
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
      child: Container(
          height: text1 == "Price" || text1 == "Phone" || text1 == "City"
              ? 80
              : 150,
          width: double.infinity,
          child: ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Text(text1),
                ),
                Expanded(
                  child: Text(text2),
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
                child: Image(image: NetworkImage(url.toString())),
              ),
            );
    } else {
      return Text("  ");
    }
  }
}
