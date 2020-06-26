import 'package:flutter/material.dart';
import 'package:our_project/screens/register.dart';
import 'package:our_project/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class sign extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}


class _homeState extends State<sign> with SingleTickerProviderStateMixin {

  FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey();
  AnimationController ani;

  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Animation animation, tween;
  var w;

  void login() async {
    if (_formkey.currentState.validate()) {
      try {
        w = await auth.signInWithEmailAndPassword(
            email: emailController.text, password: passController.text).then((
            result) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => home()));
        }
        );
      } catch (e) {
        print(e);
      }
    }
  }
  @override
  void dispose() {
    if(ani.status == AnimationStatus.forward || ani.status == AnimationStatus.reverse)
    {
      ani.notifyStatusListeners(AnimationStatus.dismissed);
    }
    ani.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ani = AnimationController(vsync: this,
      duration: Duration(seconds: 2),
      lowerBound: 0.7,
      upperBound: 1,);
    animation = CurvedAnimation(parent: ani, curve: Curves.bounceIn);
    tween = ColorTween(
      begin: Colors.red,
      end: Colors.blue,
    ).animate(ani);

    ani.forward();

    ani.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        ani.reverse(from: 1.0);
      }
      else if (state == AnimationStatus.dismissed) {
        ani.forward();
      }
    });

    ani.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        elevation: 0.0,
//        toolbarOpacity: 1,
//        title: Text("Login Page"),
//        centerTitle: true,
//      ),
      backgroundColor: Colors.blue,
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
                      height: ani.value * 160,
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
                  child:Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Enter User E-mail",labelStyle: TextStyle(
                            color: Colors.white
                        ),
                          icon: Icon(Icons.mail,size: 30,color: Colors.white,),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.white
                            ),
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
                    Padding(padding: EdgeInsets.all(5.0),
                      child:   TextFormField(
                        style: TextStyle(
                            color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                        obscureText: true,
                        controller: passController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.vpn_key,size: 30,color: Colors.white,),
                          labelText: "Enter User Password",labelStyle: TextStyle(
                            color: Colors.white
                        ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.white
                            ),
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
                  )
              ),

              SizedBox(
                height: 20.0,
              ),
              Card(
                  elevation: 3.0,
                  child: GestureDetector(
                    onTap: (){
                     login();
                    },
                    child: Image(image: AssetImage("images/3.png"),
                      height: ani.value * 50,
                      width: MediaQuery.of(context).size.width,
                    ),
                  )
              ),
              SizedBox(
                height: 18.0,
              ),
              Card(
                  elevation: 3.0,
                  child: GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(  PageRouteBuilder(
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
                              return reg();
                            }
                        ));
                      },
                      child: Card(
                        child: Text("Create Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: ani.value* 30,
                              color: Colors.red
                          ),
                        ),
                      )
                  )
              ),

            ],
          ),
        ],
      ),
    );
  }
}
