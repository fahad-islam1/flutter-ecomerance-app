import 'package:emart/constants/const.dart';
import 'package:emart/features/cotroller/home/home_controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chat = firestore.collection(chatCollection);

  // var friendName = '1';
  // var friendId = '2';
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get.find<HomeController>().userName;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();

  dynamic chatDocID;

  getChatId() async {
    await chat
        .where('users', isEqualTo: {friendId: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocID = snapshot.docs.single.id;
          } else {
            chat.add({
              "createdAt": null,
              "friendName": friendName,
              "senderName": senderName,
              "toID": "",
              "fromID": "",
              "userId": {friendId: null, currentId: null},
              "lastMsg": ""
            }).then((value) {
              chatDocID = value.id;
              print("chat doc id${chatDocID}");
            });
          }
        });
  }

  // send msg

  sendMsg({String? msg}) {
    if (msg!.trim().isNotEmpty) {
      chat.doc(chatDocID).update({
        "createdAt": FieldValue.serverTimestamp(),
        "lastMsg": msg,
        "toID": friendId,
        "fromID": currentId,
      });

      chat.doc(chatDocID).collection(msgCollection).doc().set({
        "msg": msg,
        "uId": currentUser!.uid,
        "sendTime": FieldValue.serverTimestamp(),
      });
    }
  }
}
