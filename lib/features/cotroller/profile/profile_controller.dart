import 'dart:io';

import 'package:emart/constants/const.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ProfileController extends GetxController {
  var profilePath = ''.obs;
  var profileImageUrl = '';
  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();

  var isLoading = false.obs;
//change image
  changeImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      // Pick an image.
      final image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (image == null) return null;

      profilePath.value = image.path.toString();
    } catch (e) {
      utils.flutterToast(e.toString());
    }
  }

// uptadte image

  updateImage() async {
    try {
      var filename = path.basename((profilePath.value));
      var destination = 'image/${currentUser!.uid}/$filename';
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(File(profilePath.value));
      profileImageUrl = await ref.getDownloadURL();
    } catch (e) {
      utils.flutterToast(e.toString());
    }
  }

  // update detail

  Future<void> updateProfile(
      {required String name,
      required String pass,
      required String imageUrl}) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({'name': name, 'password': pass, 'imageUrl': imageUrl},
        SetOptions(merge: true));
    isLoading(false);
  }

//  update authPassword  change

  Future<void> updateAuthPassword(
      {required String oldPass,
      required String newPass,
      required String email}) async {
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: oldPass);
    await currentUser!.reauthenticateWithCredential(credential).then((value) {
      currentUser!.updatePassword(newPass);
    });
  }
}
