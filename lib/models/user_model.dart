import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String profilePhoto;
  String email;
  String uid;

  UserModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.profilePhoto});

  Map<String, dynamic> toJson() =>
      {'name': name, 'profilePhoto': profilePhoto, 'email': email, 'uid': uid};

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapshot['uid'],
      email: snapshot['email'],
      name: snapshot['name'],
      profilePhoto: snapshot['profilePhoto'],
    );
  }
}
