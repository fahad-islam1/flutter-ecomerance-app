import 'package:emart/constants/const.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../models/category_model.dart';

class CategoryModelController extends GetxController {
  List<String> subCategoryList = [];
  var isfav = false.obs;
  var quantity = 0.obs;

  var totalPrice = 0.obs;
  var selectedColor = 0.obs;

  Future<void> getSubCategory({required String title}) async {
    subCategoryList.clear();

    var data = await rootBundle.loadString('assets/models/category_model.json');

    CategoryModel categoryModel = categoryModelFromJson(data);
    var matchingCategories = categoryModel.categories
        .where((element) => element.name == title)
        .toList();

    if (matchingCategories.isNotEmpty) {
      for (var i in matchingCategories[0].subcategory) {
        subCategoryList.add(i);
      }
    }
  }

  // increament

  incrementProduct(totalqunatity) {
    if (quantity.value < totalqunatity) {
      quantity.value++;
    }
  }

  // decrement

  decrementProduct() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  // total price

  totalProductPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  // change color

  changeColor(index) {
    selectedColor.value = index;
  }

// reset al
  resetAll() {
    quantity.value = 0;

    totalPrice.value = 0;
    selectedColor.value = 0;
  }

  // added to favrt
  addToFavrt(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      "wishList": FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));

    isfav(true);
  }

  // remove favrt
  removeFavrt(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      "wishList": FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));

    isfav(false);
  }

  // check
  checkfav(data) {
    if (data['wishList'].contains(currentUser!.uid)) {
      isfav(true);
    } else {
      isfav(false);
    }
  }
}
