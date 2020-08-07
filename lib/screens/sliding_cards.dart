import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:our_project/screens/productfromfirebase.dart';


class SlidingCardsView extends StatefulWidget {
  int n ;

  SlidingCardsView({this.n});
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset = 0;
  String dropval2;

  void dropchange2(String val) {
    setState(() {
      dropval2 = val;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double hieght = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
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
        Padding(
          padding:  EdgeInsets.only(top: hieght * 0.015 ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: PageView(
              controller: pageController,
              children: <Widget>[
                SlidingCard(
                  city: dropval2,
                  name: 'Flats',
                  assetName: '3.jpg',
                  offset: pageOffset,
                  f: widget.n,

                ),
                SlidingCard(
                  city: dropval2,
                  name: 'Vllas',
                  assetName: 'dow2.jpg',
                  offset: pageOffset - 1,
                  f: widget.n,
                ),
                SlidingCard(
                  city: dropval2,
                  name: 'Chalets',
                  assetName: 'dow4.jpg',
                  offset: pageOffset - 2,
                  f: widget.n,
                ),
                SlidingCard(
                  city: dropval2,
                  name: 'Shops',
                  assetName: 'dow6.jpg',
                  offset: pageOffset - 3,
                  f: widget.n,
                ),
                SlidingCard(
                  city: dropval2,
                  name: 'Cars',
                  assetName: 'dow9.jpg',
                  offset: pageOffset - 4,
                  f: widget.n,
                ),
                SlidingCard(
                  city: dropval2,
                  name: 'Accessories',
                  assetName: 'dowcam.jpg',
                  offset: pageOffset - 5,
                  f: widget.n,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SlidingCard extends StatelessWidget {

  final String name ,city;
  final String assetName;
  final double offset;
  final f ;

  const SlidingCard({
    Key key,
    @required this.name,
    @required this.city,
    @required this.assetName,
    @required this.offset,
    this.f
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double hieght = MediaQuery.of(context).size.height;

    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return
      GestureDetector(
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
              return pff(name,city,f);
            }
        ));
      },
      child: Transform.translate(
        offset: Offset(-32 * gauss * offset.sign, 0),
        child: Card(
          margin: EdgeInsets.only(left: 8, right: 8, bottom: 70),
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                child: Image.asset(
                  'images/$assetName',
                  height: MediaQuery.of(context).size.height * 0.35,
                  alignment: Alignment(-offset.abs(), 0),
                  fit: BoxFit.cover,
                ),
              ),
//            Expanded(
//              child: CardContent(
//                name: name,
//                offset: gauss,
//              ),
//            ),
              Text("$name",style:GoogleFonts.lato(
                fontSize: hieght * 0.060,
                color: Color(0xFFFF5A1D),
              ) ,),
//          Row(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: <Widget>[
//              Text("$name")
//            ],
//          )
            ],
          ),
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final double offset;

  const CardContent(
      {Key key,
      @required this.name,
      @required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0),
            child: Text(name, style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}
