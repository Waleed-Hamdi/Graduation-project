import 'package:flutter/material.dart';

class horizantel extends StatelessWidget {
  final txt;
  final img;

  horizantel({
    this.txt,
    this.img,
});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(2.0),
        child:
        InkWell(
          onTap: (){},
          child:
          Card(child: Container(
            width: 170.0,
            height: 170.0,
            child: ListTile(
              title: Image.asset(img,width: 100.0,height: 140.0,fit: BoxFit.cover,),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(txt,style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                  fontSize: 20.0,
                ),),
              ),
            ),
          ),)

        )
    );
  }
}
