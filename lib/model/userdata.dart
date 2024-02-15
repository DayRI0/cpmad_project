class Userdata {
  String uid;
  String name;
  String imageURLs;

  Userdata({this.uid, this.name});

  Userdata.fromMap(Map<String,dynamic> data) {
    uid = data['uid'];
    name = data['name'];
    imageURLs = data['imageURLs'];
  }

  Map<String, dynamic> toMap() {
    return{
      'uid' : uid,
      'name' : name,
      'imageURLs' : imageURLs,
    };
  }
}