import 'package:get/get.dart';

import '../../common/widgets/loading.dart';
import '../../constants/const.dart';
import '../../features/cotroller/firestore/firestore_services.dart';
import 'package:intl/intl.dart' as intl;

import 'chat_screen.dart';

class MsgScreen extends StatelessWidget {
  MsgScreen({super.key});
  final controller = Get.put(FireStore());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          msgScreen,
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: controller.getUserAllMsg(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No Msg Found',
                style: TextStyle(
                  color: darkFontGrey,
                  fontSize: 20,
                  fontFamily: bold,
                ),
              ),
            );
          } else {
            var data = snapshot.data!.docs;

            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var t = data[index]['createdAt'] == null
                      ? DateTime.now()
                      : data[index]['createdAt'].toDate();
                  var time = intl.DateFormat('hh:mm').format(t);
                  return ListTile(
                    onTap: () {
                      Get.to(() => ChatScreen(), arguments: [
                        data[index]['friendName'],
                        data[index]['toID']
                      ]);
                    },
                    leading: CircleAvatar(
                      radius: size.width * .058,
                      backgroundColor: redColor,
                      child: const Icon(
                        Icons.person,
                        color: whiteColor,
                      ),
                    ),
                    title: Text(
                      '${data[index]['friendName']}',
                      style: const TextStyle(
                        color: darkFontGrey,
                        fontFamily: bold,
                      ),
                    ),
                    subtitle: Text(
                      '${data[index]['lastMsg']}',
                      style: const TextStyle(
                        color: darkFontGrey,
                        fontFamily: semibold,
                      ),
                    ),
                    trailing: Text(
                      time,
                      style: const TextStyle(
                        color: darkFontGrey,
                        fontFamily: semibold,
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
