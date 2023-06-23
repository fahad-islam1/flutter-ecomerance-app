import 'package:get/get.dart';

import '../../common/widgets/loading.dart';
import '../../features/cotroller/chat/chat_controller.dart';
import '../../features/cotroller/firestore/firestore_services.dart';
import 'components/bottom_textfield.dart';
import '../../constants/const.dart';
import 'components/msg.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final firebase = Get.put(FireStore());
  final msgController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    // final chatController = Get.find<ChatController>();

    // final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          // elevation: 0,
          title: Text(
            msgController.friendName,
            style: const TextStyle(
              color: darkFontGrey,
              fontFamily: bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: firebase.getUserMsg(
                    docId: msgController.chatDocID.toString()),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Loading();
                  } else if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Msg Found',
                        style: TextStyle(
                          color: darkFontGrey,
                          fontFamily: bold,
                        ),
                      ),
                    );
                  } else {
                    var data = snapshot.data!.docs;
                    print(data);
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var msgdata =
                            data[index].data() as Map<String, dynamic>;
                        return msgdata['uId'] == currentUser!.uid
                            ? sendMessage(context, msgdata)
                            : recieveMessage(context, msgdata);
                      },
                    );
                  }
                },
              ),
            ),
            bottomChatTextFeild()
          ],
        ));
  }
}
