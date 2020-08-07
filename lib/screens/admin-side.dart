import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class admin extends StatefulWidget {
  @override
  _adminState createState() => _adminState();
}

class _adminState extends State<admin> {
  @override
  Widget build(BuildContext context) {


    final double width = MediaQuery.of(context).size.width;
    final double hieght = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text("Admin Side",style: GoogleFonts.aclonica(
          fontSize: 30,
//          color: Color(twee.value),
        )),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
    );
  }
}
