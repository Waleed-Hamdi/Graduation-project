import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:our_project/screens/home.dart';

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
    return Scaffold(
      backgroundColor: Colors.blue,
//        appBar: AppBar(
//          title: Text("Registration Page"),
//          centerTitle: true,
//        ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: <Widget>[
          Image(image: AssetImage("images/9.jpg"),fit: BoxFit.fill,),
          ListView(
            children: <Widget>[
              Container(
                height: 180,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("   "),
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("images/1.png"),fit: BoxFit.fill,),
                          backgroundBlendMode: BlendMode.colorDodge,
                          color: Color.fromRGBO(25, 13, 10, 1),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight : Radius.circular(98),
                          )
                      ),
                    ),

                  ],
                ),
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
                              size: 30,
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
                              size: 30,
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
                              size: 30,
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
                              size: 30,
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

                    ],
                  )),

              SizedBox(
                height: 20.0,
              ),
              Card(
                  elevation: 3.0,
                  child: GestureDetector(
                    onTap: () {
                      login();
                    },
                    child: Image(
                      image: AssetImage("images/3.png"),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                    ),
                  )),
              Container(
                  alignment: Alignment.bottomRight,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Image(image: AssetImage("images/12.png"),)),
            ],
          )

        ],
      ),

    );
  }
}
