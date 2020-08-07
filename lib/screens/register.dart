import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:our_project/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class reg extends StatefulWidget {
  @override
  _regState createState() => _regState();
}

class _regState extends State<reg> {


  final GlobalKey<FormState> _formkey = GlobalKey();
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference dbref = FirebaseDatabase.instance.reference().child("users");

  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var w ;

  void login()async{

    if(_formkey.currentState.validate()){
      try{

   w  =    await auth.createUserWithEmailAndPassword(email: emailController.text, password: passController.text).then((result){
          dbref.push().set({
            "name" : nameController.text ,
            "phone number" : phoneController.text ,
            "email" : emailController.text ,
            "password" : passController.text
          }).then((value){
            print(auth.currentUser());
            nameController.clear();
            emailController.clear();
            passController.clear();
            phoneController.clear();
            Navigator.of(context).pushReplacement(  PageRouteBuilder(
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
                  return home();
                }
            ));
          });
        }
        );

      }catch(e){
        print(e);
      }
    }

  }

@override
  Widget build(BuildContext context) {

  double height = MediaQuery.of(context).size.height;
  double wid = MediaQuery.of(context).size.width;


  return Scaffold(
      backgroundColor: Colors.indigo,
//        appBar: AppBar(
//          title: Text("Registration Page"),
//          centerTitle: true,
//        ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          ListView(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Text("4Rent ",
                        style: GoogleFonts.pacifico(
                          fontSize: height * 0.08,
                          color: Colors.white,
                        )),
                    FadeAnimatedTextKit(
                      text: [
                        "Flats",
                        "Villas",
                        "Shops",
                        "Cars",
                        "Chalets",
                        "Accessories"
                      ],
                      textStyle: GoogleFonts.aclonica(
                          color: Colors.white, fontSize: height * 0.06),
                      isRepeatingAnimation: true,
                      totalRepeatCount: 1000,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.11,
                child: Center(
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.pacifico(
                          fontSize: height * 0.06, color: Colors.white),
                    )),
              ),
              Form(
                key: _formkey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Enter your Name",
                            labelStyle: TextStyle(color: Colors.white),
                            icon: Icon(
                              Icons.person,
                              size: height * 0.05,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0, color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter your Name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Enter your Phone Number",
                            labelStyle: TextStyle(color: Colors.white),
                            icon: Icon(
                              Icons.phone,
                              size: height * 0.05,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0, color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter your phone number';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Enter User E-mail",
                            labelStyle: TextStyle(color: Colors.white),
                            icon: Icon(
                              Icons.mail,
                              size:height * 0.05,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0, color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter User E-mail';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          obscureText: true,
                          controller: passController,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.vpn_key,
                              size: height * 0.05,
                              color: Colors.white,
                            ),
                            labelText: "Enter User Password",
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0, color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter User Password';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                          obscureText: true,
                          controller: passController,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.vpn_key,
                              size: height * 0.05,
                              color: Colors.white,
                            ),
                            labelText: "Retype Password",
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0, color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Retype Password please';
                            }
                            return null;
                          },
                        ),
                      ),



                    ],
                  )),

              SizedBox(
                height: height * 0.00,
              ),
              Row(
                children: <Widget>[
                  Spacer(),
                  Column(
                  children: <Widget>[
                    Divider(
                      height:  height *0.05,
                    ),
                    Text(
                      "Sign Up",
                      style: GoogleFonts.acme(
                          fontSize: height * 0.06, color: Colors.white),
                    ),
                  ],
                  ),
                  IconButton(
                      icon: Icon(
                        EvaIcons.doneAllOutline,
                        color: Colors.green,
                        size: height * 0.12,
                      ),
                      onPressed: () {
                        login();
                      }),
                  Spacer(),
                ],
              ),

            ],
          )

        ],
      ),

    );
  }
}
