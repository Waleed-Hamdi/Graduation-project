import './home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  DatabaseReference dbref = FirebaseDatabase.instance.reference().child("products");
  DatabaseReference dbimref = FirebaseDatabase.instance.reference().child("Images");

  final cloud = Firestore.instance;

  final GlobalKey<FormState> _formkey = GlobalKey();

  TextEditingController addresscontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController detailscontroller = TextEditingController();

  String dropval ,dropval2 , DocID;
  Asset c;
  int x =0 , n = 0;
  String _error = 'No Error Dectected';
  List<Asset> images = List<Asset>();
  List imageUrls;
  var ID;


  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(vsync: this,lowerBound: 0.0,upperBound: 1,duration: Duration(seconds: 10));
    controller.addListener((){
      setState(() {});
    });
  }
  void go(){
    controller.forward();
    setState(() {});
  }

  void dropchange(String val) {
    setState(() {
      dropval = val;
    });
  }

  void dropchange2(String val) {
    setState(() {
      dropval2 = val;
    });
  }

  void click() async {
    if (_formkey.currentState.validate()) {
      try {
        final result = await dbref.push().set({
          "type": dropval,
          "city": dropval2,
          "Adress": addresscontroller.text,
          "Phone": phonecontroller.text,
          "Price": pricecontroller.text,
          "Details": detailscontroller.text,
          "img 1 ": images[0].name,
        }).then((_) {
          addresscontroller.clear();
          phonecontroller.clear();
          pricecontroller.clear();
          detailscontroller.clear();
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.1,
        title: Text("Add Prouduct"),
      ),
      body: controller.value != 0 ?  Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(controller.value == 1 ? "Done" : "Loading ... ",style: GoogleFonts.lacquer(
              fontSize: 20
            ),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6,vertical: 7),
              height: 60,
              child: LiquidLinearProgressIndicator(
                borderRadius: 20,
                direction: Axis.horizontal,
                value: controller.value,
                backgroundColor: Colors.white,
                borderColor: Colors.indigo,borderWidth: 2,
                center: Text("${(controller.value * 100).round()}" + "%",style: GoogleFonts.lacquer(
                  fontSize: 20
                ),),
              ),
            ),
          ],
        ) ,
      ) : Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    DropdownButtonFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter the type';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Type',
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                                gapPadding: 0,
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ))),
                        //hint: Text('Select Type'),
                        isExpanded: true,
                        iconSize: 30.0,
                        onChanged: dropchange,
                        value: dropval,
                        items: <String>[
                          'Flat',
                          'Chalet',
                          'vlla',
                          'Shop',
                          'Car',
                          'weeding halls',
                          'Accessories'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            child: Text(value),
                            value: value,
                          );
                        }).toList()),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter the City';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'City',
                            contentPadding: EdgeInsets.all(10.0),
                            //     prefixIcon: Icon(Icons.title),
                            border: OutlineInputBorder(
                                gapPadding: 0,
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                                borderSide: BorderSide(
                                  color: Colors.red,
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
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: addresscontroller,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter the Address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.home, color: Colors.brown),
                        /* border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                        color: Colors.black45,
                      )),*/
                        labelText: 'Enter Your Address',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: phonecontroller,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter the Phone';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone, color: Colors.green[600]),
                        labelText: 'Phone Number',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: pricecontroller,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter the Price';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        icon:
                        Icon(Icons.attach_money, color: Colors.yellow[700]),
                        labelText: 'Price For Day',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: detailscontroller,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter the Details';
                        }
                        return null;
                      },
                      maxLines: null,
                      decoration: InputDecoration(
                        icon: Icon(Icons.chat, color: Colors.blue),
                        labelText: 'Details',
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 20.0),
            SizedBox(
                width: 400, // specific value
                height: 50,
                child: RaisedButton(
                  child: Text(
                    "Get Pictures",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    loadAssets();
                  },
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(22.0),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 400, // specific value
                height: 50,
                child: RaisedButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    pro();
                    x = 0;
                    DocID = DateTime.now().toString();
                    uploadImages(DocID);
                    go();
                    if(n == 1){
//                      showDialog(
//                        context: context,
//                        builder: (BuildContext context){
//                          return SnackBar(content: Text("Done"));
//                        }
//                      );
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
                            return home();
                          }
                      ));
                    }

                  },
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(22.0),
                  ),
                )),
//            Image.network(url),
            Container(
              child: images == null ? Text("no images") : buildGridView(),
            ),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  Widget pro(){
//     Scaffold.of(context).showSnackBar(SnackBar(content: Text("Looding...")));
  return CircularProgressIndicator();
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;
    setState(() {
      images = resultList;
      _error = error;
    });
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        print(asset.getByteData(quality: 100));
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: AssetThumb(
                asset: asset,
                width: 300,
                height: 300,
              ),
            ),
          ),
        );
      }),
    );
  }



  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putData(
        (await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    return storageTaskSnapshot.ref.getDownloadURL();
  }



  void uploadImages(String docid)async{
    if (_formkey.currentState.validate()) {
      try {
        final result = await Firestore.instance.collection('products').document(docid).setData({
          "type": dropval,
          "city": dropval2,
          "Adress": addresscontroller.text,
          "Phone": phonecontroller.text,
          "Price": pricecontroller.text,
          "Details": detailscontroller.text,
          "DocID" : docid
        }).then((_) {
          addresscontroller.clear();
          phonecontroller.clear();
          pricecontroller.clear();
          detailscontroller.clear();
        });
      } catch (e) {
        print(e);
      }
    }
    for ( var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        print(downloadUrl + "gooooog");
        ID = downloadUrl.toString();
        storeid( docid,ID );
      });
    }
    print('hello');
  }

  void storeid(String docid , String id)async{
    if(id == null){
      print("id still null");
    }else{
      print('good');
      String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
      Firestore.instance.collection('images').document(docid).setData({
        'urls$x': id
      },merge: true).then((_){
      }).whenComplete(action);
      x += 1;
    }
  }
  void action(){
    setState(() {
      n = 1;
      images = [];
    });
  }

}