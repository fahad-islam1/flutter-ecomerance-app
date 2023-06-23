import 'package:get/get.dart';

import '../../../constants/const.dart';

class CartController extends GetxController {
  var totalPrice = 0.obs;

// Add to Cart

  addToCart(
      {image,
      totalPrice,
      color,
      productName,
      saler,
      qunatity,
     required price,
      required salerId}) async {
    try {
      await firestore.collection(cartCollection).doc().set({
        'salerId': salerId,
        'img': image,
        'totalPrice': totalPrice,
        'color': color,
        'productName': productName,
        'saler': saler,
        'qunatity': qunatity,
        "addedBy": currentUser!.uid,
        'product_price':price
      });
    } catch (e) {
      utils.flutterToast(e.toString());
    }
  }

//   delete cart

  deleteCart(docId) async {
    try {
      await firestore.collection(cartCollection).doc(docId).delete();
    } catch (e) {
      utils.flutterToast(e.toString());
    }
  }

  changePrice(data) {
    totalPrice.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalPrice.value =
          totalPrice.value + int.parse(data[i]['totalPrice'].toString());
    }
  }
}
