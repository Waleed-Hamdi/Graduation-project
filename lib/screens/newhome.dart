import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class newhome extends StatefulWidget {
  @override
  _newhomeState createState() => _newhomeState();
}

class _newhomeState extends State<newhome> {

  String x = "account_circle";

  @override
  Widget build(BuildContext context) {

    double hieght = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("4 Rent",style: GoogleFonts.aclonica(fontSize: hieght * 0.055),),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      drawer: SizedBox(
        width: width * 0.5,
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: hieght * 0.3,
                      child:
                      UserAccountsDrawerHeader(
                        accountName: Text("waleed hamdi",style: GoogleFonts.lato(
                          fontSize: width * 0.050
                        ),),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: AssetImage("images/waleed.jpeg"),
                        ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/waleed.jpeg"),
                              fit: BoxFit.cover)),
                      ),
                    ),
                    SizedBox(
                      height: hieght * 0.09,
                      child: GestureDetector(
                        child: Card(
                          color: Colors.indigo,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.account_circle,color: Colors.white,size: width * 0.080,),
                              Text("My Account",style:GoogleFonts.acme(fontSize: width * 0.050,color: Colors.white),),
                            ],
                          ),),
                        onTap: (){},
                      ),
                    ),
                    SizedBox(
                      height:  hieght * 0.09,
                      child: GestureDetector(
                        child: Card(
                          color: Colors.indigo,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.view_module,color: Colors.white,size: width * 0.080,),
                              Text("My Products",style:GoogleFonts.acme(fontSize: width * 0.050,color: Colors.white),),
                            ],
                          ),),
                        onTap: (){},
                      ),
                    ),
                    SizedBox(
                      height:  hieght * 0.09,
                      child: GestureDetector(
                        child: Card(
                          color: Colors.indigo,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.view_module,color: Colors.white,size: width * 0.080,),
                              Text("Add Product",style:GoogleFonts.acme(fontSize: width * 0.050,color: Colors.white),),
                            ],
                          ),),
                        onTap: (){},
                      ),
                    ),
                    SizedBox(
                      height:  hieght * 0.09,
                      child: GestureDetector(
                        child: Card(
                          color: Colors.indigo,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.settings,color: Colors.white,size: width * 0.080,),
                              Text("Setting",style:GoogleFonts.acme(fontSize: width * 0.050,color: Colors.white),),
                            ],
                          ),),
                        onTap: (){},
                      ),
                    ),
                    SizedBox(
                      height:  hieght * 0.09,
                      child: GestureDetector(
                        child: Card(
                          color: Colors.indigo,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.help,color: Colors.white,size: width * 0.080,),
                              Text("About",style:GoogleFonts.acme(fontSize: width * 0.050,color: Colors.white),),
                            ],
                          ),),
                        onTap: (){},
                      ),
                    ),
                    SizedBox(
                      height:  hieght * 0.09,
                      child: GestureDetector(
                        child: Card(
                          color: Colors.indigo,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Icon(Icons.close,color: Colors.white,size: width * 0.080,),
                              Text("Sign Out",style:GoogleFonts.acme(fontSize: width * 0.050,color: Colors.white),),
                            ],
                          ),),
                        onTap: (){},
                      ),
                    ),

                  ],
          ),
        ),
      ),
    );
  }

}
