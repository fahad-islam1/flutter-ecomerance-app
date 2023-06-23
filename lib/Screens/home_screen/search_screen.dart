import 'package:emart/features/cotroller/firestore/firestore_services.dart';
import 'package:get/get.dart';

import '../../common/widgets/loading.dart';
import '../../constants/const.dart';
import '../catagory_screen/item_detail.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key, required this.title});
  final String title;
  final fireStoreController = Get.put(FireStore());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteColor,
          title: Text(
            title,
            style: const TextStyle(
              color: darkFontGrey,
              fontFamily: bold,
            ),
          ),
        ),
        body: StreamBuilder(
            stream: fireStoreController.getAllProducts(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Loading();
              } else {
                var data = snapshot.data!.docs;
                var searchedProduct = data
                    .where((element) => element['name']
                        .toString()
                        .toLowerCase()
                        .contains(title.toString().toLowerCase()))
                    .toList();
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 300,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: searchedProduct.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => ItemDetails(
                            data: searchedProduct[index],
                            appBarTitle: '${searchedProduct[index]['name']}'));
                      },
                      child: Container(
                        width: 180,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: whiteColor,
                        ),
                        child: Column(
                          children: [
                            Image.network(
                              '${searchedProduct[index]['images'][0]}',
                              width: size.width * .3,
                              height: size.height * .26,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${searchedProduct[index]['name']}',
                              style: const TextStyle(
                                  color: fontGrey,
                                  fontFamily: semibold,
                                  fontSize: 19),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Rs ${searchedProduct[index]['price']}',
                              style: const TextStyle(
                                  color: redColor,
                                  fontFamily: semibold,
                                  fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }));
  }
}
