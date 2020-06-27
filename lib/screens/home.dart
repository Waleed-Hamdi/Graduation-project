import 'package:flutter/material.dart';
import './productfromfirebase.dart';
import 'package:our_project/widgets/hhhome.dart';
import './admin-side.dart';

//دي صفحة الهوم
import 'package:google_fonts/google_fonts.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:our_project/widgets/horizantel_listview.dart';
import 'package:our_project/screens/addproduct.dart';


class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin{

  AnimationController controller ;
  Animation twee;

  String dropval2;
  int x = 1;

  void dropchange2(String val) {
    setState(() {
      dropval2 = val;
    });
  }

  Widget image = new Container(
    height: 180.0,
    child: Carousel(
      dotSize: 4.0,
      indicatorBgPadding: 8.0,
      boxFit: BoxFit.cover,
      images: [
        AssetImage("images/dow8.jpg"),
        AssetImage("images/dow.jpg"),
        AssetImage("images/dow1.jpg"),
        AssetImage("images/dow2.jpg"),
        AssetImage("images/dow3.jpg"),
        AssetImage("images/dow9.jpg"),
        AssetImage("images/dow4.jpg"),
        AssetImage("images/dow5.jpg"),
        AssetImage("images/dow10.jpg"),
        AssetImage("images/dow6.jpg"),
        AssetImage("images/dow7.jpg"),
        AssetImage("images/dowcam.jpg"),
      ],
    ),
  );

  Image im ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    im = Image.network("https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif");
    controller = AnimationController(vsync: this,
      duration: Duration(milliseconds: 250),
      lowerBound: 0,
      upperBound: 1,
    );
    twee = CurvedAnimation(parent: controller, curve: Curves.bounceOut);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  void toggle() =>
      controller.isDismissed ? controller.forward() : controller.reverse();


  @override
  Widget build(BuildContext context) {
    final double maxSlide = 225.0;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text("Renting App hamdi",style: GoogleFonts.aclonica(
          fontSize: 30,
//          color: Color(twee.value),
        )),
        leading: IconButton(
            icon: Icon(Icons.list), onPressed: toggle),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      //========== the Drawer=====
//      drawer: Drawer(
//        child: ListView(
//          children: <Widget>[
//            InkWell(
//              onTap: () {},
//              child: UserAccountsDrawerHeader(
//                accountName: Text("waleed hamdi"),
//                accountEmail: Text("waleedhamdi716@gmail.com"),
//                currentAccountPicture: CircleAvatar(
//                  backgroundImage: AssetImage("images/waleed.jpeg"),
//                ),
//                decoration: BoxDecoration(
//                    image: DecorationImage(
//                        image: AssetImage("images/waleed.jpeg"),
//                        fit: BoxFit.cover)),
//              ),
//            ),
//            InkWell(
//              onTap: () {
//                Navigator.of(context).pop();
//              },
//              child: ListTile(
//                title: Text("Home page"),
//                leading: Icon(
//                  Icons.home,
//                  color: Colors.red,
//                ),
//              ),
//            ),
//            InkWell(
//              onTap: () {},
//              child: ListTile(
//                title: Text("My account"),
//                leading: Icon(
//                  Icons.person,
//                  color: Colors.red,
//                ),
//              ),
//            ),
//            InkWell(
//              onTap: () {
//                Navigator.of(context)
//                    .push(  PageRouteBuilder(
//                    transitionDuration: Duration(seconds: 2),
//                    transitionsBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation, Widget Child){
//                      animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
//                      return ScaleTransition(
//                        scale: animation,
//                        child: Child,
//                        alignment: Alignment.center,
//                      );
//                    },
//                    pageBuilder: (BuildContext context, Animation<double> animation , Animation<double> secAnimation){
//                      return HomePage();
//                    }
//                ));
//              },
//              child: ListTile(
//                title: Text("Add Product"),
//                leading: Icon(
//                  Icons.add,
//                  color: Colors.red,
//                ),
//              ),
//            ),
//
//            InkWell(
//              onTap: () {},
//              child: ListTile(
//                title: Text("favourites"),
//                leading: Icon(
//                  Icons.favorite,
//                  color: Colors.red,
//                ),
//              ),
//            ),
//            InkWell(
//              onTap: () {},
//              child: ListTile(
//                title: Text("Settings"),
//                leading: Icon(
//                  Icons.settings,
//                  color: Colors.grey,
//                ),
//              ),
//            ),
//            InkWell(
//              onTap: () {},
//              child: ListTile(
//                title: Text("About"),
//                leading: Icon(
//                  Icons.help,
//                  color: Colors.blue,
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
      //========== the body======
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
           animation: controller,
            builder: (context ,_){
              double slide = maxSlide * twee.value;
              double scale = 1 - (twee.value * 0.2);
            return  Stack(
              children: <Widget> [
             Container(
                  color: Colors.white,
              alignment: Alignment.topLeft,
              margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 3.0),
              child: Column(
                children: <Widget>[
                  ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      InkWell(
                        onTap: () {},
                        child:
                        Container(
                          height: 160,
                          child:
                          UserAccountsDrawerHeader(
                            accountName: Text("waleed hamdi",style: GoogleFonts.pacifico(),),
                            accountEmail: Text("waleedhamdi716@gmail.com",style: GoogleFonts.pacifico(),),
                            currentAccountPicture: CircleAvatar(
                              maxRadius: 10,
                              backgroundImage: AssetImage("images/waleed.jpeg"),
                            ),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/waleed.jpeg"),
                                  fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text("My account"),
                          leading: Icon(
                            Icons.person,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
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
                                return HomePage();
                              }
                          ));
                        },
                        child: ListTile(
                          title: Text("Add Product"),
                          leading: Icon(
                            Icons.add,
                            color: Colors.red,
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,builder: (_) => NetworkGiffyDialog(
                            image: im,
//                            image:  Image.network("https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif"),
//                              imageUrl:"https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
                          title: Text('Granny Eating Chocolate',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600)),
                            description:Text('This is a granny eating chocolate dialog box',
                              textAlign: TextAlign.center,
                            ),
                            entryAnimation: EntryAnimation.TOP,
                            onOkButtonPressed: () {},
                          ) );
                        },
                        onLongPress: (){
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
                                return admin();
                              }
                          ));
                        },
                        child: ListTile(
                          title: Text("Setting"),
                          leading: Icon(
                            Icons.settings,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text("Sign Out"),
                          leading: Icon(
                            Icons.help,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ),
              Transform(
                transform: Matrix4.identity()..translate(slide)..scale(scale),
                child: Container(
                  color: Colors.white,
                    child: ListView(
                      children: <Widget>[
                        image,
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 230,
                          child: ListView(
                            children: <Widget>[
                              Card(
                                color: Colors.indigo,
                                elevation: 20.0,
                                shape: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white, width: 4.0)),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Renting",
                                      style: GoogleFonts.lacquer(
                                          fontSize: 30.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800
                                      )
                                    ),
                                    FadeAnimatedTextKit(
                                      text: [
                                        "Flats",
                                        "Vllas",
                                        "Shops",
                                        "Cars",
                                        "Chalets",
                                        "Camera"
                                      ],
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white,
                                          fontSize: 30.0),
                                      isRepeatingAnimation: true,
                                      totalRepeatCount: 1000,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(3.0, 5.0, 3.0, 5.0),
                                  child: Card(
                                    color: Colors.indigo,
                                    elevation: 10.0,
                                    child: Container(
                                      height: 180,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: <Widget>[
                                          horizantel(
                                            img: "images/dow.jpg",
                                            txt: "Flats",
                                          ),
                                          horizantel(
                                            img: "images/dow1.jpg",
                                            txt: "Vllas",
                                          ),
                                          horizantel(
                                            img: "images/dow6.jpg",
                                            txt: "Shops",
                                          ),
                                          horizantel(
                                            img: "images/dow9.jpg",
                                            txt: "Cars",
                                          ),
                                          horizantel(
                                            img: "images/dowcam2.jpg",
                                            txt: "Accessories",
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              Card(
                                color: Colors.indigo,
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    "Categories",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.aclonica(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold
                                    )
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 10.0,
                                shape: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.indigo, width: 3.0),
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        hintText: 'City you want to Rent in',labelStyle: GoogleFonts.lacquer(
                                      color: Colors.red
                                    ),
                                        contentPadding: EdgeInsets.all(10.0),
                                        //     prefixIcon: Icon(Icons.title),
                                        border: OutlineInputBorder(
                                            gapPadding: 0,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(8.0)),
                                            borderSide: BorderSide(
                                              color: Colors.indigo,
                                            ))),
                                    isExpanded: true,
                                    iconSize: 30.0,
                                    onChanged: dropchange2,
                                    value: dropval2,
                                    items: <String>[
                                      'Alexandria',
                                      'Aswan',
                                      'Asyut',
                                      'Beheira',
                                      'Beni Suef',
                                      'Cairo',
                                      'Dakahlia',
                                      'Damietta',
                                      'Faiyum',
                                      'Gharbia',
                                      'Giza',
                                      'Ismailia',
                                      'Kafr El Sheikh',
                                      'Luxor',
                                      'Matruh	',
                                      'Minya	',
                                      'Monufia	',
                                      'New Valley	',
                                      'North Sinai	',
                                      'Port Said	',
                                      'Qalyubia	',
                                      'Qena	',
                                      'Red Sea	',
                                      'Sharqia	',
                                      'Sohag	',
                                      'South Sinai	',
                                      'Suez	'
                                    ].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        child: Text(value),
                                        value: value,
                                      );
                                    }).toList()),
                              ),
                              hhh(1,"images/dow.jpg", "flats","Flat",dropval2),
                              hhh(2, "images/dow1.jpg","vlla","vlla",dropval2),
                              hhh(3,"images/dow2.jpg","Chalets","Chalet",dropval2),
                              hhh(4,"images/dow9.jpg","Cars","Car",dropval2),
                              hhh(5,"images/dow5.jpg","Shops","Shop",dropval2),
                              hhh(6,"images/dow5.jpg","Weeding halls","weeding halls",dropval2),
                              hhh(7,"images/dowcam.jpg" , "Accessories","Accessories",dropval2),
                              Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 30,
                                    width: 150,
                                    child: Divider(
                                      thickness: 3.0,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                  Text("4Rent in service ",style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700
                                  ),),
                                  SizedBox(
                                    height: 30,
                                    width: 150,
                                    child: Divider(
                                      thickness: 3.0,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
              ),

              ]
            );

            },

          ),
      ]
      ),
    );
  }
}



