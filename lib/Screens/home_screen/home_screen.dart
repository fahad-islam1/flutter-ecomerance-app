import 'package:carousel_slider/carousel_slider.dart';
import 'package:emart/Screens/home_screen/search_screen.dart';
import 'package:emart/common/widgets/fetured_catagories.dart';
import 'package:emart/common/widgets/home_button.dart';
import 'package:get/get.dart';

import '../../common/widgets/dialogue.dart';
import '../../common/widgets/loading.dart';
import '../../constants/const.dart';
import '../../features/cotroller/firestore/firestore_services.dart';
import '../../features/cotroller/home/home_controller.dart';
import '../catagory_screen/item_detail.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final fireStoreController = Get.put(FireStore());

  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();

    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => alertDialogue(context));

        return false;
      },
      child: Container(
        color: lightGrey,
        width: size.width,
        height: size.height,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  height: 60,
                  color: lightGrey,
                  child: TextField(
                    controller: homeController.searchController,
                    decoration: InputDecoration(
                      hintText: search,
                      suffixIcon: IconButton(
                          onPressed: () {
                            if (homeController
                                .searchController.text.isNotEmpty) {
                              Get.to(() => SearchScreen(
                                  title: homeController.searchController.text));
                            }
                          },
                          icon: const Icon(Icons.search)),
                      fillColor: whiteColor,
                      filled: true,
                      border: InputBorder.none,
                      hintStyle: const TextStyle(
                          fontFamily: regular, color: textfieldGrey),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CarouselSlider(
                          items: imageSlider
                              .map(
                                (item) => Image.asset(
                                  item,
                                  fit: BoxFit.fill,
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            height: 150,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.7,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            2,
                            (index) => homeScreenButton(
                                height: size.height * .15,
                                width: size.width / 2.5,
                                icon:
                                    index == 1 ? iconFlashDeal : iconTodaysDeal,
                                title: index == 1 ? flashSale : todayDeals),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CarouselSlider(
                          items: imageSlider2
                              .map(
                                (item) => Image.asset(
                                  item,
                                  fit: BoxFit.fill,
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            height: 150,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.7,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            3,
                            (index) => homeScreenButton(
                                height: size.height * .15,
                                width: size.width / 3.5,
                                icon: index == 2
                                    ? icTopSeller
                                    : index == 1
                                        ? icBrands
                                        : icTopCategories,
                                title: index == 2
                                    ? topSeller
                                    : index == 1
                                        ? brand
                                        : topCategory),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              featuredCategory,
                              style: TextStyle(
                                  color: darkFontGrey,
                                  fontFamily: bold,
                                  fontSize: 19),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(
                              3,
                              (index) => Container(
                                width: 200,
                                margin: const EdgeInsets.all(14),
                                child: Column(
                                  children: [
                                    featuredButton(
                                        icon: imgList1[index],
                                        title: textList1[index]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    featuredButton(
                                        icon: imgList2[index],
                                        title: textList2[index]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: redColor,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                featuredProducts,
                                style: TextStyle(
                                    color: whiteColor,
                                    fontFamily: bold,
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    children: List.generate(
                                        3,
                                        (index) => Container(
                                              width: 170,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(11),
                                                  color: whiteColor),
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    imgProducts[index],
                                                    width: 150,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    textList[index],
                                                    style: const TextStyle(
                                                        color: fontGrey,
                                                        fontFamily: semibold,
                                                        fontSize: 19),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    priceList[index],
                                                    style: const TextStyle(
                                                        color: redColor,
                                                        fontFamily: semibold,
                                                        fontSize: 17),
                                                  ),
                                                ],
                                              ),
                                            ))),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CarouselSlider(
                          items: imageSlider2
                              .map(
                                (item) => Image.asset(
                                  item,
                                  fit: BoxFit.fill,
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            height: 150,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.7,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder(
                            stream: fireStoreController.getAllProducts(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const Loading();
                              } else {
                                var data = snapshot.data!.docs;
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 300,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 5,
                                  ),
                                  itemCount: data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.to(() => ItemDetails(
                                            data: data[index],
                                            appBarTitle:
                                                '${data[index]['name']}'));
                                      },
                                      child: Container(
                                        width: 180,
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          color: whiteColor,
                                        ),
                                        child: Column(
                                          children: [
                                            Image.network(
                                              '${data[index]['images'][0]}',
                                              width: size.width * .3,
                                              height: size.height * .26,
                                              fit: BoxFit.fill,
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
                                              'Rs ${data[index]['price']}',
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
                            }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// get all products

//  GridView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             mainAxisExtent: 300,
//                             mainAxisSpacing: 8,
//                             crossAxisSpacing: 5,
//                           ),
//                           itemCount: 6,
//                           itemBuilder: (BuildContext context, int index) {
//                             return Container(
//                               width: 180,
//                               margin: const EdgeInsets.symmetric(horizontal: 8),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(13),
//                                 color: whiteColor,
//                               ),
//                               child: Column(
//                                 children: [
//                                   Image.asset(
//                                     imgProducts2[index],
//                                     width: 200,
//                                     fit: BoxFit.fill,
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(
//                                     textList3[index],
//                                     style: const TextStyle(
//                                         color: fontGrey,
//                                         fontFamily: semibold,
//                                         fontSize: 19),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Text(
//                                     priceList1[index],
//                                     style: const TextStyle(
//                                         color: redColor,
//                                         fontFamily: semibold,
//                                         fontSize: 17),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );