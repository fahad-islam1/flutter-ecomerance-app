// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:emart/Screens/catagory_screen/item_detail.dart';
import 'package:emart/common/widgets/loading.dart';
import 'package:get/get.dart';

import '../../constants/const.dart';
import '../../features/cotroller/category/category_controller.dart';
import '../../features/cotroller/firestore/firestore_services.dart';

class CategoryDetails extends StatelessWidget {
  final String appBarTitle;
  CategoryDetails({
    Key? key,
    required this.appBarTitle,
  }) : super(key: key);
  final categoryController = Get.put(CategoryModelController());
  final fireStore = Get.put(FireStore());

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryModelController>();
    // print(Colors.black.value);
    // print(Colors.blue.value);
    // print(Colors.yellow.value);
    // print(Colors.white.value);
    return customBg(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          appBarTitle,
          style: const TextStyle(
            color: whiteColor,
            fontFamily: bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  controller.subCategoryList.length,
                  (index) => Container(
                    height: 50,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(13)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        controller.subCategoryList[index],
                        style: const TextStyle(
                            color: darkFontGrey,
                            fontFamily: semibold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            StreamBuilder(
              stream: fireStore.getUserProducts(title: appBarTitle),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Loading();
                } else if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Product Found  ",
                      style: TextStyle(
                          color: darkFontGrey,
                          fontFamily: semibold,
                          fontSize: 18),
                    ),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 250,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 5,
                          ),
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                controller.checkfav(data[index]);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemDetails(
                                      data: data[index],
                                      appBarTitle: categoryTitleList[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  color: whiteColor,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Image.network(
                                        '${data[index]['images'][0]}',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${data[index]['name']}',
                                      style: const TextStyle(
                                          color: fontGrey,
                                          fontFamily: semibold,
                                          fontSize: 19),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Rs ${data[index]['price']} ',
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
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
