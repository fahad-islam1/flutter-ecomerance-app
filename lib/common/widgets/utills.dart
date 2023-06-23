import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/const.dart';

class Utils {
  void flutterToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

     Widget loading() {
 return  const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(redColor),
    );
  }

  void snackbar(BuildContext context, String message) {
    ScaffoldMessenger(child: SnackBar(content: Text(message)));
  }
}
