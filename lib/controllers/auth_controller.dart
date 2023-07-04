import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/constraints.dart';
import 'package:tiktok/models/user_model.dart';

class AuthController extends GetxController {


  late Rx<File?> _pickedImage;

  File? get ProfilePhoto => _pickedImage.value;

  void pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile picture', 'You have successfully selected your profile');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }


  Future<String> _uploadToStorage(File image) async {
    Reference ref =
        storage.ref().child('profilePics').child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  void ReisterUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        var profilePhoto = await _uploadToStorage(image);

        UserModel user = UserModel(
          uid: cred.user!.uid,
          email: email,
          name: username,
          profilePhoto: profilePhoto,
        );

        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Error creating account', 'Please Enter all the fields');
      }
    } catch (e) {
      Get.snackbar('Error creating account', e.toString());
    }
  }
}
