import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:our_project/screens/Productdetails.dart';
import 'package:our_project/screens/home3.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';



class pff extends StatefulWidget {
  String y , city;
  int f ;
  pff(this.y,this.city,this.f);

  @override
  _pffState createState() => _pffState();
}

class _pffState extends State<pff> with SingleTickerProviderStateMixin{

 int n = 0 ;
 double pageOffset = 0;
 PageController pageController;


  final Firestore cloud = Firestore.instance;

  DatabaseReference dbref = FirebaseDatabase.instance.reference().child("products");

  List pro = [];
 Map<dynamic , dynamic> images = {"waleed": "hamdi"};
 List listimg = [];
 List<String> urls = [];
 AnimationController controller;

  @override
  void initState() {
    print(widget.f);
    controller = AnimationController(
        vsync: this,
        upperBound: 1,
        lowerBound: 0,
        duration: Duration(seconds: 5));
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });

    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });

  Map<dynamic , dynamic> vlues ;

  var result = cloud.collection("products").where("type", isEqualTo: widget.y).getDocuments().then((doc){
     doc.documents.forEach((result){
       print(result);
         pro.add(result.data);
     });
//     print(pro);
     setState(() {
       print(widget.y);
       print(widget.city);
       n = 1;
     });
  }).then((_){
//    images.clear();
//    cloud.collection("images").document(pro["DocID"]).get().then((value) {
//      images = value.data;
//      print(images);
////      listimg.add(images.values);
//      print(value.data.toString() + "hello waleed");
//      print(listimg);
//    }
  });
  }




 @override
 void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {


    final double width = MediaQuery.of(context).size.width;
    final double hieght = MediaQuery.of(context).size.height;


    double gauss = math.exp(-(math.pow((pageOffset.abs() - 0.5), 2) / 0.08));

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text("4Rent",style: GoogleFonts.pacifico(
            fontSize: hieght *0.09
        )),
      ),
      body:  
     widget.city == null ?
      AlertDialog(
        title: Text("Warning",style: GoogleFonts.pacifico(color: Colors.white,fontSize: hieght *0.05),textAlign: TextAlign.center,),
        content: Text("u have to choice the city",textAlign: TextAlign.center,style: GoogleFonts.lato(color: Colors.white,fontSize: hieght * 0.03),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          Card(

            child: InkWell(
              child: Text("OK   ",textAlign: TextAlign.center,style: GoogleFonts.pacifico(fontSize: hieght *0.05),),
              onTap: (){
                Navigator.of(context)
                    .push(  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 2),
                    transitionsBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation, Widget Child){
                      animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
                      return ScaleTransition(
                        scale: animation,
                        child: Child,
                        alignment: Alignment.center,
                      );
                    },
                    pageBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation){
                      return HomePage3();
                    }
                ));
              },
            ),
          )
        ],
      )
     : Stack(
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
          ): Container(
              alignment: Alignment.topCenter,
              child: pro.length == 0 ? Center(
                child: GestureDetector(
                  child: CircularProgressIndicator(),
                  onTap: (){
                    setState(() {

                    });
                  },
                ),
              ) :
           widget.f != 2 ?
           ListView.builder(
                itemCount: pro.length,
                itemBuilder: (context , index){
                   return
                     pro[index]["city"] == widget.city  ? Container(
                      height: hieght * 0.4,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context)
                              .push(  PageRouteBuilder(
                              transitionDuration: Duration(seconds: 2),
                              transitionsBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation, Widget Child){
                                animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
                                return ScaleTransition(
                                  scale: animation,
                                  child: Child,
                                  alignment: Alignment.center,
                                );
                              },
                              pageBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation){
                                return proddetails(pro[index]["Adress"], pro[index]["Details"], pro[index]["city"],pro[index]["Price"], pro[index]["Phone"], pro[index]["DocID"],pro[index]["Rating"]);
                              }
                          ));
                        },
                        child: Column(
                          children: <Widget>[
                            Card(
                              margin: EdgeInsets.only(left: 8, right: 8, bottom: 0),
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                              child: Column(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(32),topRight: Radius.circular(32)),
                                    child: Image.network(pro[index]["urls0"].toString(),height: hieght * 0.24,fit: BoxFit.fill, width: width * 0.9 ,
                                      loadingBuilder: (context , child , progress){
                                      return progress == null ? child : LinearProgressIndicator();
                                    },),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12,right: 12,top: 1),
                              child: Card(
                                color: Colors.indigo,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                Flexible(
                                child: new Text(pro[index]["Adress"],overflow: TextOverflow.ellipsis,style:GoogleFonts.lato(
                                  fontSize: hieght * 0.040,
                                  color: Colors.white,
                                ) ,)),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.white30,
                                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                              ),
                                    Text("Price \n "+pro[index]["Price"],overflow: TextOverflow.ellipsis,style:GoogleFonts.lato(
                                      fontSize: hieght * 0.040,
                                      color: Colors.white,
                                    ) ,),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ) : Text("  ");

//                Card(
//                shape: Border(
//                  bottom: BorderSide(color: Colors.indigo,width: 3.0,style: BorderStyle.solid),
//                  left: BorderSide(color: Colors.indigo,width: 3.0,style: BorderStyle.solid),
//                  right: BorderSide(color: Colors.indigo,width: 3.0,style: BorderStyle.solid),
//                ),
//                elevation: 10.0,
//                margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
//                child: ListTile(
//                  onTap: (){
//                    Navigator.of(context).push(
//                        PageRouteBuilder(
//                            transitionDuration: Duration(seconds: 2),
//                            transitionsBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation, Widget Child){
//                              animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
//                              return ScaleTransition(
//                                scale: animation,
//                                child: Child,
//                                alignment: Alignment.center,
//                              );
//                            },
//                            pageBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation){
//                              return proddetails(pro[index]["Adress"], pro[index]["Details"],pro[index]["city"],
//                                pro[index]["Price"],pro[index]["Phone"],pro[index]["DocID"],
//                              );
//                            }
//                        ));
//                  },
//                  title: Text(pro[index]["Adress"],style:GoogleFonts.actor(
//                    color: Colors.red
//                  ),),
//                  subtitle: Text(pro[index]["Details"],style: TextStyle(color: Colors.red),),
//                  trailing: Column(
//                    children: <Widget>[
//                      Text(pro[index]["Price"],style: TextStyle(color: Colors.red),),
//                      Text("جنيه شهريا",style: TextStyle(color: Colors.red),),
//                    ],
//                  ),
//                  leading: Container(
//                    width: 80,
//                      height: 100,
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(10.0)
//                      ),
//                      child: Image(image: AssetImage("images/1.jpg"),fit:BoxFit.fitWidth ,)),
//                ),
//              );
                },
              )
               : ListView.builder(
             itemCount: pro.length,
             itemBuilder: (context , index){
               return
                 pro[index]["Date"] == DateTime.now().month  ? Container(
                   height: hieght * 0.4,
                   child: GestureDetector(
                     onTap: (){
                       Navigator.of(context)
                           .push(  PageRouteBuilder(
                           transitionDuration: Duration(seconds: 2),
                           transitionsBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation, Widget Child){
                             animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
                             return ScaleTransition(
                               scale: animation,
                               child: Child,
                               alignment: Alignment.center,
                             );
                           },
                           pageBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation){
                             return proddetails(pro[index]["Adress"], pro[index]["Details"], pro[index]["city"],pro[index]["Price"], pro[index]["Phone"], pro[index]["DocID"],pro[index]["Rating"]);
                           }
                       ));
                     },
                     child: Column(
                       children: <Widget>[
                         Card(
                           margin: EdgeInsets.only(left: 8, right: 8, bottom: 0),
                           elevation: 8,
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                           child: Column(
                             children: <Widget>[
                               ClipRRect(
                                 borderRadius: BorderRadius.only(topLeft: Radius.circular(32),topRight: Radius.circular(32)),
                                 child: Image.network(pro[index]["urls0"].toString(),height: hieght * 0.24,fit: BoxFit.fill, width: width * 0.9 ,
                                   loadingBuilder: (context , child , progress){
                                     return progress == null ? child : LinearProgressIndicator();
                                   },),
                               ),
                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left: 12,right: 12,top: 1),
                           child: Card(
                             color: Colors.indigo,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                               children: <Widget>[
                                 Flexible(
                                     child: new Text(pro[index]["Adress"],overflow: TextOverflow.ellipsis,style:GoogleFonts.lato(
                                       fontSize: hieght * 0.040,
                                       color: Colors.white,
                                     ) ,)),
                                 Container(
                                   height: 30.0,
                                   width: 1.0,
                                   color: Colors.white30,
                                   margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                                 ),
                                 Text("Price \n "+pro[index]["Price"],overflow: TextOverflow.ellipsis,style:GoogleFonts.lato(
                                   fontSize: hieght * 0.040,
                                   color: Colors.white,
                                 ) ,),
                               ],
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ) : Text("  ");

//                Card(
//                shape: Border(
//                  bottom: BorderSide(color: Colors.indigo,width: 3.0,style: BorderStyle.solid),
//                  left: BorderSide(color: Colors.indigo,width: 3.0,style: BorderStyle.solid),
//                  right: BorderSide(color: Colors.indigo,width: 3.0,style: BorderStyle.solid),
//                ),
//                elevation: 10.0,
//                margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
//                child: ListTile(
//                  onTap: (){
//                    Navigator.of(context).push(
//                        PageRouteBuilder(
//                            transitionDuration: Duration(seconds: 2),
//                            transitionsBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation, Widget Child){
//                              animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
//                              return ScaleTransition(
//                                scale: animation,
//                                child: Child,
//                                alignment: Alignment.center,
//                              );
//                            },
//                            pageBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation){
//                              return proddetails(pro[index]["Adress"], pro[index]["Details"],pro[index]["city"],
//                                pro[index]["Price"],pro[index]["Phone"],pro[index]["DocID"],
//                              );
//                            }
//                        ));
//                  },
//                  title: Text(pro[index]["Adress"],style:GoogleFonts.actor(
//                    color: Colors.red
//                  ),),
//                  subtitle: Text(pro[index]["Details"],style: TextStyle(color: Colors.red),),
//                  trailing: Column(
//                    children: <Widget>[
//                      Text(pro[index]["Price"],style: TextStyle(color: Colors.red),),
//                      Text("جنيه شهريا",style: TextStyle(color: Colors.red),),
//                    ],
//                  ),
//                  leading: Container(
//                    width: 80,
//                      height: 100,
//                      decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(10.0)
//                      ),
//                      child: Image(image: AssetImage("images/1.jpg"),fit:BoxFit.fitWidth ,)),
//                ),
//              );
             },
           )

          ),
        ],
      ),
    );

  }
}
