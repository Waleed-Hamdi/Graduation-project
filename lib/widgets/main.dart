import 'package:flutter/material.dart';
import 'package:our_project/screens/Sign_in.dart';
//import 'package:our_project/screens/home.dart';
//import 'package:our_project/screens/Productdetails.dart';
//import 'package:our_project/screens/home3.dart';
//import 'package:our_project/screens/newhome.dart';
import 'package:our_project/screens/home3.dart';

void main(){
  runApp(MaterialApp(
    title: "4Rent",
    debugShowCheckedModeBanner:false ,
    theme: ThemeData(fontFamily: 'SF Pro Display',backgroundColor: Colors.indigo),
    home: splash(),
    color: Colors.red,
  ));
}


class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override

  void initState(){
    super.initState();
    Future.delayed(Duration(
      seconds: 2 ,),
            (){
          Navigator.of(context).pushReplacement(
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
                  return HomePage3();
                }
            )
          );
        }
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
            color: Colors.white,
            margin: EdgeInsets.only(left: 10.0,right: 10.0),

            child: Image(image: AssetImage("images/22.png"))),
      ),
    );
  }
}
