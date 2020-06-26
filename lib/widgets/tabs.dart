import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 24),
        MyTab(text: 'Nearby'),
        MyTab(text: 'Recent'),
        MyTab(text: 'Notice'),
      ],
    );
  }
}

class MyTab extends StatefulWidget {
  final String text;


  const MyTab({Key key, @required this.text})
      : super(key: key);
  final bool isSelected = false;
  @override
  _MyTabState createState() => _MyTabState();
}

class _MyTabState extends State<MyTab> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          widget.isSelected == true ;
         setState(() {});

        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.text,
              style: TextStyle(
                fontSize: widget.isSelected ? 16 : 14,
                color: widget.isSelected ? Colors.black : Colors.grey,
                fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            Container(
              height: 6,
              width: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: widget.isSelected ? Color(0xFFFF5A1D) : Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
