import 'package:emart/constants/const.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    getUserName();
  }

  var searchController = TextEditingController();
  var currentIndex = 0.obs;

  var userName = '';

  getUserName() async {
    var getUserNAme = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    userName = getUserNAme;
    // print(userName);
  }
}
