import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../common/widgets/loading.dart';
import '../../../constants/const.dart';

class AuthController extends GetxController{

  bool isLoading = false;

// sign in with email
  Future<UserCredential?> signIn({email, pass, context}) async {
    UserCredential? userCredential;

    try {
      isLoading = true; // Start showing the loading indicator
      Loading();

      userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
    } on FirebaseAuthException catch (e) {
      utils.flutterToast(e.toString());
    } finally {
      isLoading = false; // Hide the loading indicator
    }

    return userCredential;
  }

// sign up with email
  Future<UserCredential?> signUp({email, pass, context}) async {
    UserCredential? userCredential;

    try {
      isLoading = true; // Start showing the loading indicator
      Loading();

      userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      utils.flutterToast('Account created successfully');
    } on FirebaseAuthException catch (e) {
      utils.flutterToast(e.toString());
    } finally {
      isLoading = false; // Hide the loading indicator
    }

    return userCredential;
  }

// sign out
  Future<void> signOut() async {
    await auth.signOut();
  }
}