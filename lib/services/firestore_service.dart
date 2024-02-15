import 'package:cloud_firestore/cloud_firestore.dart';
import './firebaseauth_service.dart';
import '../model/userdata.dart';

class FirestoreService {
// Create a CollectionReference called bookCollection that references
// the firestore collection
final CollectionReference userCollection = FirebaseFirestore.instance.collection('userdata');
Future<void> addUserData(
String uid, String name, String imageURLs) async { var docRef = FirestoreService().userCollection.doc();
print('add docRef: ' + docRef.id); 
await userCollection.doc(docRef.id).set({ 'uid': uid,
'name' : name,
'imageURLs' : imageURLs
});
} //addBookData
Future<List<Userdata>> readUserData() async { List<Userdata> userList = [];
QuerySnapshot snapshot = await userCollection.get(); snapshot.docs.forEach((document) {
Userdata user = Userdata.fromMap(document.data()); userList.add(user);
});
print('Userlist: $userList'); return userList;
} //readBookData

Future<List<Userdata>> getUserData(String uid) 
async {
  List<Userdata> userList = [];
QuerySnapshot snapshot = await userCollection.where('uid', isEqualTo: uid).get(); snapshot.docs.forEach((document) {
Userdata user = Userdata.fromMap(document.data()); userList.add(user);
});
print('Userlist: $userList'); 
return userList;
} 



Future<void> deleteUserData(String docId) async { userCollection.doc(docId).delete();
print('deleting uid: ' + docId);
} //deleteBookData
//for your reference

Future<String> getDocumentIdFromUid(String uid) async {
    try {
      QuerySnapshot snapshot = await userCollection.where('uid', isEqualTo: uid).get();
      
      if (snapshot.docs.isNotEmpty) {
        // Return the document ID of the first document found
        return snapshot.docs.first.id;
      } else {
        // If no document matches the given UID, return null or throw an error
        return null; // or throw Exception('Document with UID $uid not found');
      }
    } catch (e) {
      print('Error getting document ID for UID $uid: $e');
      // Handle the error appropriately
      throw e;
    }
  }

Future<void> updateUserData(
String uid, String name, String imageURLs) async {
  String documentId = await FirestoreService().getDocumentIdFromUid(uid);
var docRef = FirestoreService().userCollection.doc(); print('update docRef: ' + docRef.id);
await userCollection.doc(documentId).update({ 'uid': uid,
'name' : name,
'imageURLs' : imageURLs

});
} //updateBookData
//for your reference
Future<void> deleteUserDoc() async {
await userCollection.get().then((snapshot) { for (DocumentSnapshot ds in snapshot.docs) { ds.reference.delete();
}
});
} //deleteBookDoc



} //FirestoreService
