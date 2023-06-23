import 'package:get/get.dart';

import '../../../constants/const.dart';
import '../category/category_controller.dart';

class PaymentController extends GetxController {
  var select = 0.obs;
  late dynamic productSnapshot;
  var product = [];

  var countrycontroller = TextEditingController();
  var statecontroller = TextEditingController();
  var citycontroller = TextEditingController();
  var namecontroller = TextEditingController();
  var addresscontroller = TextEditingController();
  var contactcontroller = TextEditingController();
  var postalcontroller = TextEditingController();
  var categoryModelController =
      Get.find<CategoryModelController>().totalPrice.value;

  changeIndex(index) {
    select.value = index;
  }

// store orderd prduct

  placeOrder({
    required paymentMethod,
    required toatlprice,
  }) async {
    await getCartDetails();
    firestore.collection(orderCollection).doc().set({
      'name': namecontroller.text,
      'email': currentUser!.email,
      'buyerId': currentUser!.uid,
      'country': countrycontroller.text,
      'contact': contactcontroller.text,
      'address': addresscontroller.text,
      'city': citycontroller.text,
      'postal_code': postalcontroller.text,
      'state': statecontroller.text,
      'paymentMethod': paymentMethod,
      'totalPrice': toatlprice,
      'delivery': 'cash on delivery',
      'order_date': FieldValue.serverTimestamp(),
      'order_confirm': false,
      'order_place': true,
      'order_deliver': false,
      'order_on_deliverd': false,
      'order_code': "1234556789",
      'orders_list': FieldValue.arrayUnion(product)
    });
  }

  getCartDetails() {
    product.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      product.add({
        'salerId': productSnapshot[i]['salerId'],
        'Price': productSnapshot[i]['product_price'],
        "image": productSnapshot[i]['img'],
        "color": productSnapshot[i]['color'],
        "productName": productSnapshot[i]['productName'],
        "qunatity": productSnapshot[i]['qunatity'],
      });
    }
    // print(product);
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
