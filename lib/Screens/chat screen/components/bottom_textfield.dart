import 'package:get/get.dart';

import '../../../constants/const.dart';
import '../../../features/cotroller/chat/chat_controller.dart';

final msgController = Get.put(ChatController());

Widget bottomChatTextFeild() {
  final chatController = Get.find<ChatController>();

  return Container(
    padding: const EdgeInsets.only(top: 8, left: 10, bottom: 10, right: 0),
    // margin: EdgeInsets.all(3),
    child: Row(
      children: [
        Expanded(
          child: Card(
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextField(
                      controller: msgController.msgController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: "    Type message....",
                        hintStyle: TextStyle(color: Colors.blue, fontSize: 16),
                        border: InputBorder.none,
                      )),
                )),
              ],
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {
            msgController.sendMsg(msg: chatController.msgController.text);
            chatController.msgController.clear();
          },
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 5,
          ),
          shape: const CircleBorder(),
          color: redColor,
          child: const Icon(
            Icons.send,
            size: 27,
            color: whiteColor,
          ),
        )
      ],
    ),
  );
}
