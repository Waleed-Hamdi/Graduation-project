import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:our_project/screens/Productdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';



class pff extends StatefulWidget {
  String y , city;
  pff(this.y,this.city);

  @override
  _pffState createState() => _pffState();
}

class _pffState extends State<pff> {

 int n = 0 ;

  final cloud = Firestore.instance;

  DatabaseReference dbref = FirebaseDatabase.instance.reference().child("products");

  List pro = [];

  @override
  void initState() {
  Map<dynamic , dynamic> vlues ;
  var result = cloud.collection("products").where("type", isEqualTo: widget.y).where("city" ,isEqualTo: widget.city).getDocuments().then((doc){
     doc.documents.forEach((result){
       
         pro.add(result.data);
     });
     setState(() {
       n = 1;
     });
  });

  }
 @override
 void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text("Renting App",style: GoogleFonts.aclonica(
            fontSize: 30
        )),
      ),
      body:  Container(
          alignment: Alignment.topCenter,
          child: pro.length == 0 ? Center(
            child: GestureDetector(
              child: CircularProgressIndicator(),
              onTap: (){
              },
            ),
          ) :
          ListView.builder(
            itemCount: pro.length,
            itemBuilder: (context , index){
              return Card(
                shape: Border(
                  bottom: BorderSide(color: Colors.indigo,width: 3.0,style: BorderStyle.solid),
                  left: BorderSide(color: Colors.indigo,width: 3.0,style: BorderStyle.solid),
                  right: BorderSide(color: Colors.indigo,width: 3.0,style: BorderStyle.solid),
                ),
                elevation: 10.0,
                margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                child: ListTile(
                  onTap: (){
                    Navigator.of(context).push(
                        PageRouteBuilder(
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
                              return proddetails(pro[index]["Adress"], pro[index]["Details"],pro[index]["city"],
                                pro[index]["Price"],pro[index]["Phone"],pro[index]["DocID"],
                              );
                            }
                        ));
                  },
                  title: Text(pro[index]["Adress"],style:GoogleFonts.actor(
                    color: Colors.red
                  ),),
                  subtitle: Text(pro[index]["Details"],style: TextStyle(color: Colors.red),),
                  trailing: Column(
                    children: <Widget>[
                      Text(pro[index]["Price"],style: TextStyle(color: Colors.red),),
                      Text("جنيه شهريا",style: TextStyle(color: Colors.red),),
                    ],
                  ),
                  leading: Container(
                    width: 80,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Image(image: AssetImage("images/1.jpg"),fit:BoxFit.fitWidth ,)),
                ),
              );
            },
          ),
      ),
    );

  }
}
