import 'package:get/get.dart';

import '../../common/widgets/loading.dart';
import '../../constants/const.dart';
import '../../features/cotroller/firestore/firestore_services.dart';

class ViewWishListScreen extends StatelessWidget {
  ViewWishListScreen({super.key});
  final controller = Get.put(FireStore());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          wishlistScreen,
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: bold,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: controller.getUserWishList(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No Favourite product Found',
                style: TextStyle(
                  fontSize: 20,
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
                      onTap: () {},
                      leading: CircleAvatar(
                        radius: size.width * .058,
                        backgroundImage:
                            NetworkImage('${data[index]['images'][0]}'),
                      ),
                      title: Text(
                        '${data[index]['name']}',
                        style: const TextStyle(
                          color: darkFontGrey,
                          fontFamily: bold,
                        ),
                      ),
                      subtitle: Text(
                        'Rs ${data[index]['price']}',
                        style: const TextStyle(
                          color: redColor,
                          fontFamily: semibold,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          controller.deleteWishList(data[index].id);
                        },
                        icon: const Icon(
                          Icons.favorite_rounded,
                          color: redColor,
                          size: 30,
                        ),
                      ));
                });
          }
        },
      ),
    );
  }
}
