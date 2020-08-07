import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_project/screens/productfromfirebase.dart';

class hhh extends StatelessWidget {
  var t ;
  String x,city;

  var txt , image ;
  hhh(this.t , this.image , this.txt,this.x,this.city);
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      child: Card(
        elevation: 10.0,
        shape: OutlineInputBorder(borderSide: BorderSide(color:Colors.indigo,width: 3.0),borderRadius: BorderRadius.circular(5.0)),
        child:
        InkWell(
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
//                 / return pff(x,city);
                }
            ));
          },
          child: Container(
              height: 100,
              width: 90,
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 3,
                      child:Container(
                          height: 90,
                          foregroundDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)
                          ),
                          child: Image(image: AssetImage(image),fit: BoxFit.fill,
                          ))
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 1,
                        ),
                        Text(txt,textAlign: TextAlign.center,style: GoogleFonts.acme(
                            color: Colors.red,
//                            fontWeight: FontWeight.bold,
                            fontSize: 30
                        ),),
                        Expanded(
                          child:Text("click for more",textAlign: TextAlign.left,style: GoogleFonts.acme(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          )),
                        ),
                      ],
                    ),
                  ),

                ],
              )

          ),
        ) ,
      ) ,
    );
  }
}