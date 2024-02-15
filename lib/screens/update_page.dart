import 'dart:io';
import 'dart:async';
import 'package:animated_background/animated_background.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/firebaseauth_service.dart';
import '../services/firestore_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './home_page.dart';
import 'package:path/path.dart' as Path; 

class UpdatePage extends StatefulWidget {
  final FirebaseAuthService _firebaseService = FirebaseAuthService();
  final FirestoreService _firestoreService = FirestoreService();
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> with TickerProviderStateMixin {
  String name;
  String imageURLs;
  File _image;    
  int iindex = 0;
  final presetimage = [
    'Default.png',
    'flame.png',
    'tv.png',
  ];
  final formKey = GlobalKey<FormState>();

  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Profile',), backgroundColor: Colors.transparent, 
        elevation: 0.0, actions: <Widget>[],
      textTheme: TextTheme(
            headline6: TextStyle(color: Colors.black, fontSize: 20), 
      ),
      iconTheme: IconThemeData(color: Colors.black), // Change icon color to black
      leading: ModalRoute.of(context).canPop
         ?  IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button press
              Navigator.of(context).pop();
            },
          )
          : null,
        ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
              spawnMaxRadius: 50,
              spawnMinRadius: 20,
              spawnMinSpeed: 10.00,
              particleCount: 10,
              spawnMaxSpeed: 25,
              spawnOpacity: 0.1,
              //opacityChangeRate: -0.1,
              minOpacity: 0),
        ),
        vsync: this,
      child:SingleChildScrollView(
        child: Center(
        child: Container(
            height: 500,
            width: 300,
            padding: EdgeInsets.all(25.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20.0),
            ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
          padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Name',  labelStyle: TextStyle(fontSize: 18)),
                  validator: (val) => val.length == 0 ? 'Enter Name' : null,
                  onSaved: (val) => this.name = val,
                ),),
                /* Padding(
          padding: const EdgeInsets.only(top: 10),
                child:TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'imageURLs', labelStyle: TextStyle(fontSize: 18)),
                  validator: (val) => val.length == 0 ? 'Enter Image' : null,
                  onSaved: (val) => this.imageURLs = val,
                ),), */
                Padding(
          padding: const EdgeInsets.only(top: 10),
                child:ToggleButtons(children: [
                  Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/Default.png'),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            ),
                  Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/flame.png'),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            ),
                  Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/tv.png'),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            ),
                ],
                
                onPressed: (int index) {
                          // Update the selected state of the button
                          setState(() {
                  iindex = index;
                          this.imageURLs = presetimage[iindex];
                });
                         
                        },
                 isSelected: [iindex == 0 ? true : false, iindex == 1 ? true : false, iindex == 2 ? true : false,],
                fillColor: Colors.blueGrey,
                ),),
              Padding(
          padding: const EdgeInsets.only(top: 10),
                child:Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: RaisedButton(
                    onPressed: _submit,
                    child: Text('Update Profile'),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),))
    ));
  }

  void _submit() {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
      delayFunction(Duration(seconds: 1)).then((_) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage()));
  });
      
    } else {
      return null;
    }
    FirestoreService().updateUserData(
        widget._firebaseService.getCurrentUser().uid, name, imageURLs);
    Fluttertoast.showToast(
        msg: "Data saved successfully", gravity: ToastGravity.TOP);
  } //_submit
}



Future<void> delayFunction(Duration duration) {
  return Future.delayed(duration);
}