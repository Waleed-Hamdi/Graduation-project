import 'package:google_fonts/google_fonts.dart';
import 'package:our_project/widgets//sliding_cards.dart';
import 'package:flutter/material.dart';
import 'package:our_project/screens/exhibition_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int x = 3;
  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double hieght = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Header(),
//                SizedBox(height: hieght * 0.020),
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
                                fontSize: x == 3 ? hieght * 0.030 : hieght * 0.025,
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
                                fontSize: x == 1 ? hieght * 0.030 : hieght * 0.025,
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
                    GestureDetector(
                      onTap: () {
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
                                fontSize: x == 2 ? hieght * 0.030 : hieght * 0.025,
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
                  ],
                ),
//                SizedBox(height: hieght * 0.010),
                SlidingCardsView(),
                ExhibitionBottomSheet(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.indigo),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Text(
            '4Renting',
            style: GoogleFonts.laila(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}


