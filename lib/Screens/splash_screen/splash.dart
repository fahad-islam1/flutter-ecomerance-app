import 'dart:async';

import '../../constants/const.dart';

class SplashScreenMethod{
 void startTimer(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      if (auth.currentUser == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  Home()),
        );
      }
    });
  }
}