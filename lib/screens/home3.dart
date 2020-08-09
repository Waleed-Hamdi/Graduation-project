import 'package:our_project/screens/sliding_cards.dart';
import 'package:our_project/screens/productfromfirebase.dart';
import 'package:our_project/screens/admin-side.dart';
import 'package:our_project/screens/Sign_in.dart';

import 'package:our_project/screens/addproduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'exhibition_bottom_sheet.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'dart:math' as math;
import 'dart:ui';


class HomePage3 extends StatefulWidget {
  @override
  _HomePage3State createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3>
    with SingleTickerProviderStateMixin {

  int x = 3;
  AnimationController _controller;

  double get maxHeight => MediaQuery.of(context).size.height;

  double get headerTopMargin =>
      lerp(20, 20 + MediaQuery.of(context).padding.top);

  double get headerFontSize => lerp(14, 24);

  double get itemBorderRadius => lerp(8, 24);

  double get iconLeftBorderRadius => itemBorderRadius;

  double get iconRightBorderRadius => lerp(8, 0);

  double get iconSize => lerp(iconStartSize, iconEndSize);

  double iconTopMargin(int index) =>
      lerp(iconStartMarginTop,
          iconEndMarginTop + index * (iconsVerticalSpacing + iconEndSize)) +
      headerTopMargin;

  double iconLeftMargin(int index) =>
      lerp(index * (iconsHorizontalSpacing + iconStartSize), 0);

  int n = 1;


  String txt ;
  TextEditingController controller ;
  onchange(){
    txt = controller.toString();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  signout()async{
    try {
     final w = await auth.signOut()
          .then((result) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => sign()));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    controller.dispose();
    super.dispose();
  }

  double lerp(double min, double max) =>
      lerpDouble(min, max, _controller.value);
  void _toggle() {
    final bool isOpen = _controller.status == AnimationStatus.completed;
    _controller.fling(velocity: isOpen ? -2 : 2);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _controller.value -= details.primaryDelta / maxHeight;
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed) return;

    final double flingVelocity =
        details.velocity.pixelsPerSecond.dy / maxHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  @override
  Widget build(BuildContext context) {


    final double width = MediaQuery.of(context).size.width;
    final double hieght = MediaQuery.of(context).size.height;

    final double minHeight = hieght * 0.15;
//    const double iconStartSize = 44;
//    const double iconEndSize = 120;
//    const double iconStartMarginTop = 36;
//    const double iconEndMarginTop = 80;
//    const double iconsVerticalSpacing = 24;
//    const double iconsHorizontalSpacing = 16;


    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Header(),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(width: width * 0.05),
                    GestureDetector(
                      onTap: () {
                        x = 3;

                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Home",
                              style: TextStyle(
                                fontSize:
                                    x == 3 ? hieght * 0.030 : hieght * 0.025,
                                color: x == 3 ? Colors.black : Colors.grey,
                                fontWeight:
                                    x == 3 ? FontWeight.w600 : FontWeight.w500,
                              ),
                            ),
                            Container(
                              height: hieght * 0.010,
                              width: width * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color:
                                    x == 3 ? Color(0xFFFF5A1D) : Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        n = 2;
                        x = 2;
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Recent",
                              style: TextStyle(
                                fontSize:
                                x == 2 ? hieght * 0.030 : hieght * 0.025,
                                color: x == 2 ? Colors.black : Colors.grey,
                                fontWeight:
                                x == 2 ? FontWeight.w600 : FontWeight.w500,
                              ),
                            ),
                            Container(
                              height: hieght * 0.010,
                              width: width * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color:
                                x == 2 ? Color(0xFFFF5A1D) : Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        x = 1;
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Nearby",
                              style: TextStyle(
                                fontSize:
                                    x == 1 ? hieght * 0.030 : hieght * 0.025,
                                color: x == 1 ? Colors.black : Colors.grey,
                                fontWeight:
                                    x == 1 ? FontWeight.w600 : FontWeight.w500,
                              ),
                            ),
                            Container(
                              height: hieght * 0.010,
                              width: width * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color:
                                    x == 1 ? Color(0xFFFF5A1D) : Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: hieght * 0.002),
                SlidingCardsView(n: n,),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                height: lerp(minHeight, maxHeight),
                left: 0,
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: _toggle,
                  onVerticalDragUpdate: _handleDragUpdate,
                  onVerticalDragEnd: _handleDragEnd,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    decoration: const BoxDecoration(
                      color: Color(0xFF162A49),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(32)),
                    ),
                    child: Stack(
                      children: <Widget>[
                        MenuButton(),
                        SheetHeader(
                          fontSize: hieght * 0.07,
                          topMargin: headerTopMargin,
                        ),

                        _controller.status == AnimationStatus.completed
                            ? ListView(
//                                shrinkWrap: true,
                                children: <Widget>[
                                  SizedBox(
                                    height: hieght * 0.15,
                                  ),
//                                  Text(
//                                    "waleed",
//                                    style: TextStyle(
//                                        color: Colors.white, fontSize: 50),
//                                  ),
//                                  InkWell(
//                                    onTap: () {},
//                                    child: UserAccountsDrawerHeader(
//                                      accountName: Text("waleed hamdi"),
//                                      currentAccountPicture: CircleAvatar(
//                                        backgroundImage:
//                                            AssetImage("images/waleed.jpeg"),
//                                      ),
//                                      decoration: BoxDecoration(
//                                        borderRadius: BorderRadius.circular(10),
//                                          image: DecorationImage(
//                                              image: AssetImage(
//                                                  "images/waleed.jpeg"),
//                                              fit: BoxFit.cover)),
//                                    ),
//                                  ),
//                                  Card(
//                                    color: Colors.white,
//                                    child: InkWell(
//                                      onTap: () {
//                                        Navigator.of(context).push(
//                                            PageRouteBuilder(
//                                                transitionDuration:
//                                                Duration(seconds: 2),
//                                                transitionsBuilder: (BuildContext
//                                                context,
//                                                    Animation<double> animation,
//                                                    Animation<double>
//                                                    secAnimation,
//                                                    Widget Child) {
//                                                  animation = CurvedAnimation(
//                                                      parent: animation,
//                                                      curve: Curves.elasticInOut);
//                                                  return ScaleTransition(
//                                                    scale: animation,
//                                                    child: Child,
//                                                    alignment: Alignment.center,
//                                                  );
//                                                },
//                                                pageBuilder: (BuildContext
//                                                context,
//                                                    Animation<double> animation,
//                                                    Animation<double>
//                                                    secAnimation) {
//                                                  return ;
//                                                }));
//                                      },
//                                      child:
////                                      ListTile(
////                                        title: Text("Home page"),
////                                        leading: IconButton(
////                                          icon: Icon(Icons.home),
////                                          color: Colors.blue, onPressed: () {
////                                            Navigator.of(context).pop();
////                                        },
////                                        ),
////                                      ),
//                                     SizedBox(
//                                       height: hieght * 0.1,
//                                       child: Row(
//                                         children: <Widget>[
//
//                                           IconButton(icon: Icon(Icons.home,color: Colors.indigo,), onPressed: (){}),
//                                           Text("       Home Page"),
//                                         ],
//
//                                       ),
//                                     ),
//                                    ),
//                                  ),
                                  //            InkWell(
                                  Card(
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () {},
                                      child: ListTile(
                                        title: Text("My account"),
                                        leading: Icon(
                                          Icons.person,
                                          color: Colors.indigo,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            PageRouteBuilder(
                                                transitionDuration:
                                                    Duration(seconds: 2),
                                                transitionsBuilder: (BuildContext
                                                        context,
                                                    Animation<double> animation,
                                                    Animation<double>
                                                        secAnimation,
                                                    Widget Child) {
                                                  animation = CurvedAnimation(
                                                      parent: animation,
                                                      curve: Curves.elasticInOut);
                                                  return ScaleTransition(
                                                    scale: animation,
                                                    child: Child,
                                                    alignment: Alignment.center,
                                                  );
                                                },
                                                pageBuilder: (BuildContext
                                                        context,
                                                    Animation<double> animation,
                                                    Animation<double>
                                                        secAnimation) {
                                                  return HomeePage();
                                                }));
                                      },
                                      child: ListTile(
                                        title: Text("Add Product"),
                                        leading: Icon(
                                          Icons.add,
                                          color: Colors.indigo,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Card(
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                         signout();

                                      },
                                      child: ListTile(
                                        title: Text("Sign Out"),
                                        leading: Icon(
                                          EvaIcons.logOut,
                                          color: Colors.indigo,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    color: Colors.white,
                                    child: InkWell(
                                      onLongPress: (){
//                                        showDialog(context: context,child:
//                                        AlertDialog(
//                                          title: Text("Warning",style: GoogleFonts.pacifico(color: Colors.white,fontSize: hieght *0.05),textAlign: TextAlign.center,),
//                                          content: TextField(obscureText: true,controller: controller,onChanged: onchange(),),
//                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
//                                          backgroundColor: Colors.indigo,
//                                          actions: <Widget>[
//                                            Card(
//
//                                              child: InkWell(
//                                                child: Text("OK   ",textAlign: TextAlign.center,style: GoogleFonts.pacifico(fontSize: hieght *0.05),),
//                                                onTap: (){
//                                                  txt == "sherlock" ? Navigator.of(context)
//                                                      .push(  PageRouteBuilder(
//                                                      transitionDuration: Duration(seconds: 2),
//                                                      transitionsBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation, Widget Child){
//                                                        animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
//                                                        return ScaleTransition(
//                                                          scale: animation,
//                                                          child: Child,
//                                                          alignment: Alignment.center,
//                                                        );
//                                                      },
//                                                      pageBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation){
//                                                        return admin();
//                                                      }
//                                                  )) : Navigator.of(context)
//                                                      .push(  PageRouteBuilder(
//                                                      transitionDuration: Duration(seconds: 2),
//                                                      transitionsBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation, Widget Child){
//                                                        animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
//                                                        return ScaleTransition(
//                                                          scale: animation,
//                                                          child: Child,
//                                                          alignment: Alignment.center,
//                                                        );
//                                                      },
//                                                      pageBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation){
//                                                        return HomePage3();
//                                                      }
//                                                  ));
//                                                },
//                                              ),
//                                            )
//                                          ],
//                                        )
//                                        );
                                      },
                                      onTap: () {
//                                        print("waleed");

                                        showDialog(context: context,child:
                                        AlertDialog(
                                          title: Text("Warning",style: GoogleFonts.pacifico(color: Colors.white,fontSize: hieght *0.05),textAlign: TextAlign.center,),
                                          content: Text("it is not your way",textAlign: TextAlign.center,style: GoogleFonts.lato(color: Colors.white,fontSize: hieght * 0.03),),
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
                                        );
                                      },
                                      child: ListTile(
                                        title: Text("About"),
                                        leading: Icon(
                                          Icons.help,
                                          color: Colors.indigo,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                "",
                                style: TextStyle(color: Colors.white),
                              ),
//                       Positioned(
//                         top: 10,
//                         child: ListView(
//                           children: <Widget>[
//                             Text("waleed",style: TextStyle(color: Colors.white),),
//                           ],
//                         ),
//                       )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
//          DraggableScrollableSheet(
//            expand: true,
//            minChildSize: 0.15,
//            maxChildSize: 0.8,
//            initialChildSize: 0.8,
//            builder:
//                (BuildContext context, ScrollController scrollController) {
//              return Card(
//                color: Colors.indigo,
//                child: ListTile(
//                    title: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Text(
//                          "4 Rent",
//                          style: GoogleFonts.aBeeZee(fontSize: hieght * 0.07,color: Colors.white),
//                        ),
//                        Icon(
//                          Icons.arrow_upward,
//                          color: Colors.white,
//                          size: 30.0,
//                        )
//                      ],
//                    ),
//                    subtitle: ListView(
//                      controller: scrollController,
//                      children: <Widget>[
////                        card("City", widget.City),
////                        card("Address", widget.Address),
////                        card("Description", widget.Description),
////                        card("Price", widget.Price.toString()),
////                        card("Phone", widget.number.toString()),
//                      ],
//                    )
//                    ),
//              );
//            },
//          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double hieght = MediaQuery.of(context).size.height;

    return Expanded(
      child: Card(
        color: Colors.indigo[800],
        child: Center(
          child: Text(
            "4Rent",
            style:
                GoogleFonts.pacifico(fontSize: hieght* 0.07, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class SheetHeader extends StatelessWidget {
  final double fontSize;
  final double topMargin;

  const SheetHeader(
      {Key key, @required this.fontSize, @required this.topMargin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topMargin,
      child: Text(
        '4Rent',
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -5,
      bottom: 10,
      child: Icon(
        Icons.menu,
        color: Color(0xFFFF5A1D),
        size: 28,
      ),
    );
  }
}
