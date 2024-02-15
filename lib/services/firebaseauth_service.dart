import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './firestore_service.dart';

class FirebaseAuthService {
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;
  Future<User> signIn(
      {String email, String password}) async {
    try {
      UserCredential ucred = await _fbAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = ucred.user;
      print('Signed In Succesful $ucred.user.uid, user: $user');
      return user;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.TOP);
      return null;
    } catch (e) {
      print(e.message);
      return null;
    }
  }

  Future<User> signUp(
      {String email, String password}) async {
    try {
      UserCredential ucred = await _fbAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = ucred.user;
      print('Sign UP successful user: $user');
      FirestoreService().addUserData(_fbAuth.currentUser.uid ,'', 'Default.png');
      return user;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message, gravity: ToastGravity.TOP);
      return null;
    } catch (e) {
      print(e.message);
      return null;
    }
  }

  Future<void> signOut() async {
    await _fbAuth.signOut();
  }

  User getCurrentUser() {
    // Get the current user's email
    return _fbAuth.currentUser ?? "No user signed in";
  }
}
