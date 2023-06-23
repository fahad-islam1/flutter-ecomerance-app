import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../constants/const.dart';

class FireStore extends GetxController {
// store user data
  Future<void> storeUser({
    name,
    email,
    pass,
  }) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(currentUser?.uid);
    store.set({
      'name': name,
      "email": email,
      "password": pass,
      ' imageUrl':
          "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
      "id": currentUser!.uid,
      'cart': '00',
      'Wishlist': '00',
      'Order': '00'
    });
  }

// get user data
  getUserData(uid) {
    final store = firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
    return store;
  }

// get the user prdoucts

  Stream<QuerySnapshot> getUserProducts({required String title}) {
    try {
      return firestore
          .collection('product')
          .where('category', isEqualTo: title)
          .snapshots();
    } catch (e) {
      // print("Error retrieving user products: $e");
      utils.flutterToast(e.toString());
      return const Stream.empty(); // Return an empty stream in case of an error
    }
  }

  // for home
  Stream<QuerySnapshot> getAllProducts() {
    try {
      return firestore.collection('product').snapshots();
    } catch (e) {
      // print("Error retrieving user products: $e");
      utils.flutterToast(e.toString());
      return const Stream.empty(); // Return an empty stream in case of an error
    }
  }
  // for featured products homescreen

  Stream<QuerySnapshot> getFeaturedProducts() {
    try {
      return firestore
          .collection('product')
          .where('isFeatured', isEqualTo: true)
          .snapshots();
    } catch (e) {
      // print("Error retrieving user products: $e");
      utils.flutterToast(e.toString());
      return const Stream.empty(); // Return an empty stream in case of an error
    }
  }

  // for search product homescreen
  Stream<QuerySnapshot> getSearchProducts({title}) {
    try {
      return firestore
          .collection('product')
          .where('name', isLessThanOrEqualTo: title)
          .snapshots();
    } catch (e) {
      // print("Error retrieving user products: $e");
      utils.flutterToast(e.toString());
      return const Stream.empty(); // Return an empty stream in case of an error
    }
  }

  // for subcategory ...........category detail screen
  Stream<QuerySnapshot> getSubCatagoryProducts({title}) {
    try {
      return firestore
          .collection('product')
          .where('subcategory', isEqualTo: title)
          .snapshots();
    } catch (e) {
      // print("Error retrieving user products: $e");
      utils.flutterToast(e.toString());
      return const Stream.empty(); // Return an empty stream in case of an error
    }
  }

  // get cart product
  Stream<QuerySnapshot> getCartProducts({uid}) {
    try {
      return firestore
          .collection(cartCollection)
          .where('addedBy', isEqualTo: uid)
          .snapshots();
    } catch (e) {
      // print("Error retrieving user products: $e");
      utils.flutterToast(e.toString());
      return const Stream.empty(); // Return an empty stream in case of an error
    }
  }

  // get user msg
  Stream<QuerySnapshot<Object?>>? getUserMsg({docId}) {
    try {
      var getData = firestore
          .collection(chatCollection)
          .doc(docId)
          .collection(msgCollection)
          .snapshots();

      Fluttertoast.showToast(msg: 'retrieve messages');
      return getData;
    } catch (e) {
      // print("Error retrieving user messages: $e\n$stackTrace");
      Fluttertoast.showToast(msg: 'Failed to retrieve messages');
      return null;
    }
  }

  // get user all msg
  getUserAllMsg() {
    try {
      var getData = firestore
          .collection(chatCollection)
          .where('fromID', isEqualTo: currentId)
          .snapshots();

      Fluttertoast.showToast(msg: 'retrieve messages');
      return getData;
    } catch (e) {
      // print("Error retrieving user messages: $e\n$stackTrace");
      Fluttertoast.showToast(msg: 'Failed to retrieve messages');
      return null;
    }
  }

  // getUser order
  Stream<QuerySnapshot<Object?>>? getUserOrder() {
    try {
      var getData = firestore
          .collection(orderCollection)
          .where('buyerId', isEqualTo: currentId)
          .snapshots();

      return getData;
    } catch (e) {
      // print("Error retrieving user messages: $e\n$stackTrace");
      Fluttertoast.showToast(msg: 'Failed to retrieve order');
      return null;
    }
  }

  // getUser wishlist

  Stream<QuerySnapshot<Object?>>? getUserWishList() {
    try {
      var getData = firestore
          .collection(productsCollection)
          .where('wishList', arrayContains: (currentId))
          .snapshots();

      return getData;
    } catch (e) {
      // print("Error retrieving user messages: $e\n$stackTrace");
      Fluttertoast.showToast(msg: 'Failed to retrieve wishList');
      return null;
    }
  }

// for wishlist
  deleteWishList(data) {
    try {
      var getData = firestore.collection(productsCollection).doc(data).set({
        'wishList': FieldValue.arrayRemove([currentId]),
      }, SetOptions(merge: true));

      return getData;
    } catch (e) {
      // print("Error retrieving user messages: $e\n$stackTrace");
      Fluttertoast.showToast(msg: 'Failed to retrieve wishList');
      return null;
    }
  }

// for profille screen
  Future<List<int>> getAllCount() async {
    var res = await Future.wait([
      firestore
          .collection(cartCollection)
          .where('addedBy', isEqualTo: currentUser!.uid)
          .get()
          .then(
        (value) {
          return value.docs.length;
        },
      ),
      firestore
          .collection(productsCollection)
          .where('wishList', arrayContains: currentId)
          .get()
          .then(
        (value) {
          return value.docs.length;
        },
      ),
      firestore
          .collection(orderCollection)
          .where('buyerId', isEqualTo: currentUser!.uid)
          .get()
          .then(
        (value) {
          return value.docs.length;
        },
      ),
    ]);
    return List<int>.from(res);
  }
}
