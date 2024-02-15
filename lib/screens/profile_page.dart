import 'package:flutter/material.dart';
import '../model/userdata.dart';
import '../services/firebaseauth_service.dart';
import '../services/firestore_service.dart';
import './update_page.dart';

class ProfilePage extends StatefulWidget {
  final FirebaseAuthService _firebaseService = FirebaseAuthService();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Userdata> _userData = []; // List to store user data

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data when the widget is initialized
  }

  Future<void> fetchUserData() async {
    try {
      // Fetch user data from Firestore
      List<Userdata> userData = await widget._firestoreService.getUserData(widget._firebaseService.getCurrentUser().uid);
      
      setState(() {
        _userData = userData; // Update the user data list
      });
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            iconSize: 30,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdatePage(),
                ),
              ).then((_) {
                // Fetch user data again when returning from UpdatePage
                fetchUserData();
              });
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: _userData.isNotEmpty // Check if user data is available
          ? ListView.builder(
              itemCount: _userData.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Container(
                    height: 400,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                            child:Center(
                          child:Container(
                            width: 135,
                            height: 135,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                              image: DecorationImage(
                                image: AssetImage('images/' + _userData[index].imageURLs),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            ),
                            ),
                          ),
                          Text(
                            'Welcome ' + _userData[index].name,
                            style: TextStyle(color: Colors.black, fontSize: 28.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Email: ' + widget._firebaseService.getCurrentUser().email,
                            style: TextStyle(color: Colors.black, fontSize: 24.0),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    );
  }
}