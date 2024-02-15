import 'package:flutter/material.dart';
import '../services/firebaseauth_service.dart';
import 'package:location/location.dart';
import 'profile_page.dart';

import '../map.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> _listPages = List();
  var location = new Location();
  LocationData userLocation;
  Future<LocationData> _getLocation() async {
    LocationData currentLocation;
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      print(e);
      currentLocation = null;
    }
    return currentLocation;
  }

    void initState() {
    super.initState();
    _getLocation().then((value) {
      setState(() {
        userLocation = value;
        // After getting user location, add MapPage to _listPages
        _listPages.add(MapPage(userLocation: userLocation));
      });
    });

    // Always add ProfilePage to _listPages
    _listPages.add(ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _listPages[_currentIndex],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
//shape property must be set to NotchedShape
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.map_rounded),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            
            
            Divider(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.logout),
        backgroundColor: Colors.black,
        tooltip: 'Sign Out',
        onPressed: () async {
          await FirebaseAuthService().signOut();
          Navigator.of(context).pushNamed('/login');
        },
      ),
    );
  }
}
