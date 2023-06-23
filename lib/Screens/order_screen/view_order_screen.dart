import 'package:get/get.dart';

import '../../common/widgets/loading.dart';
import '../../constants/const.dart';
import '../../features/cotroller/firestore/firestore_services.dart';
import 'order_details_screen.dart';

class ViewOrderScreen extends StatelessWidget {
  ViewOrderScreen({super.key});
  final controller = Get.put(FireStore());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          orderScreen,
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: controller.getUserOrder(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No  order Found',
                style: TextStyle(
                  color: darkFontGrey,
                  fontFamily: bold,
                ),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Get.to(() => OrderDetails(
                            data: data[index],
                          ));
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Text('${index + 1}',
                          style: const TextStyle(
                            color: darkFontGrey,
                            fontFamily: bold,
                          )),
                    ),
                    title: Text(
                      '${data[index]['order_code']}',
                      style: const TextStyle(
                        color: darkFontGrey,
                        fontFamily: bold,
                      ),
                    ),
                    subtitle: Text(
                      'Rs ${data[index]['totalPrice']}',
                      style: const TextStyle(
                        color: redColor,
                        fontFamily: semibold,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined,
                        color: fontGrey, size: 27),
                  );
                });
          }
        },
      ),
    );
  }
}
