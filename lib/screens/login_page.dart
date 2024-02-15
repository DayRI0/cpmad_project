import 'package:animated_background/animated_background.dart';
import 'package:cpmad_project/screens/update_page.dart';
import 'package:flutter/material.dart';
import '../services/firebaseauth_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool signUp = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(""),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
              spawnMaxRadius: 50,
              spawnMinRadius: 20,
              spawnMinSpeed: 10.00,
              particleCount: 25,
              spawnMaxSpeed: 25,
              spawnOpacity: 0.2,
              //opacityChangeRate: -0.2,
              minOpacity: 0),
        ),
        vsync: this,
        child: SingleChildScrollView(
          child: Center(
              child: Container(
            height: 500,
            width: 300,
            padding: EdgeInsets.all(25.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    "CityCommute",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    signUp ? "Sign Up" : "Sign In",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                  ),
                ),
//Sign in / Sign up button
                ElevatedButton(
                  onPressed: () async {
                    if (signUp) {
                      var newuser = await FirebaseAuthService().signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      if (newuser != null) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => UpdatePage()));
                      }
                    } else {
                      var reguser = await FirebaseAuthService().signIn(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      if (reguser != null) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage()));
                      }
                    }
                  },
                  child: signUp ? Text("Sign Up") : Text("Sign In"),
                ),

//Sign up / Sign In toggler
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      signUp = !signUp;
                    });
                  },
                  child: signUp
                      ? Text("Have an account? Sign In")
                      : Text("Create an account"),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
