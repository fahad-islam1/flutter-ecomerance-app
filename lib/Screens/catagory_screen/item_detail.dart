// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../constants/const.dart';

import 'dart:math' as math;

import '../../features/cotroller/cart/cart_controller.dart';
import '../../features/cotroller/category/category_controller.dart';
import '../cart_screen/cart_screen.dart';
import '../chat screen/chat_screen.dart';

class ItemDetails extends StatelessWidget {
  final String appBarTitle;
  final dynamic data;
  ItemDetails({
    Key? key,
    required this.appBarTitle,
    required this.data,
  }) : super(key: key);

  final rnd = math.Random();
  final categoryController = Get.put(CategoryModelController());
  final cartController = Get.put(CartController());
  Color getRandomColor() => Color(rnd.nextInt(0xffffffff));
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    final controller = Get.find<CategoryModelController>();

    return WillPopScope(
      onWillPop: () async {
        categoryController.resetAll();
        Get.back();

        return false;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              categoryController.resetAll();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            '${data['name']}',
            style: const TextStyle(
              color: darkFontGrey,
              fontFamily: bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
            ),
            IconButton(
              onPressed: () {
                Get.to(() => CartScreen());
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  if (controller.isfav.value) {
                    categoryController.removeFavrt(data.id);
                    controller.isfav.value = false;
                  } else {
                    categoryController.addToFavrt(data.id);
                    controller.isfav.value = true;
                  }
                },
                icon: Icon(controller.isfav.value == false
                    ? Icons.favorite_outline
                    : Icons.favorite),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider.builder(
                        itemCount: data['images'].length,
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            Image.network(
                          data['images'][itemIndex],
                          fit: BoxFit.cover,
                        ),
                        options: CarouselOptions(
                          height: 150,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 2),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        '${data['name']}',
                        style: const TextStyle(
                            color: darkFontGrey,
                            fontFamily: bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      RatingBar.builder(
                        initialRating: double.parse('${data['rating']}'),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Rs ${data['price']} ',
                        style: const TextStyle(
                            color: redColor,
                            fontFamily: semibold,
                            fontSize: 17),
                      ),
                      Container(
                        height: 60,
                        // padding: EdgeInsets.symmetric(horizontal: 13),
                        decoration: BoxDecoration(
                            color: textfieldGrey,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${data['salerName']}',
                                    style: const TextStyle(
                                        color: textfieldGrey,
                                        fontFamily: semibold,
                                        fontSize: 17),
                                  ),
                                  Text(
                                    '${data['salerName']}',
                                    style: const TextStyle(
                                        color: darkFontGrey,
                                        fontFamily: semibold,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                backgroundColor: whiteColor,
                                child: IconButton(
                                  onPressed: () {
                                    Get.to(
                                      () => ChatScreen(),
                                      arguments: [
                                        data['salerName'],
                                        data['salerId']
                                      ],
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.message,
                                    color: darkFontGrey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text(
                              "Color :",
                              style: TextStyle(
                                  color: fontGrey,
                                  fontFamily: semibold,
                                  fontSize: 17),
                            ),
                          ),
                          Obx(
                            () => Row(
                                children: List.generate(
                              data['colors'].length,
                              (index) => InkWell(
                                onTap: () {
                                  categoryController.changeColor(index);
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(data['colors'][index])
                                              .withOpacity(1.0)),
                                    ),
                                    Visibility(
                                        visible: index ==
                                            controller.selectedColor.value,
                                        child: Icon(Icons.done,
                                            color:
                                                Color(data['colors'][index]) ==
                                                        Color(
                                                            Colors.white.value)
                                                    ? Colors.black
                                                    : Colors.white))
                                  ],
                                ),
                              ),
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        () => Row(
                          children: [
                            const SizedBox(
                              width: 100,
                              child: Text(
                                "Quantity:",
                                style: TextStyle(
                                    color: fontGrey,
                                    fontFamily: semibold,
                                    fontSize: 16),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                categoryController.decrementProduct();
                                categoryController.totalProductPrice(
                                    int.parse(data['price']));
                              },
                              icon: const Icon(
                                Icons.remove,
                                color: darkFontGrey,
                              ),
                            ),
                            Text(
                              '${controller.quantity.value}',
                              style: const TextStyle(
                                  color: darkFontGrey,
                                  fontFamily: semibold,
                                  fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                categoryController.incrementProduct(
                                    int.parse(data['quantity']));
                                categoryController.totalProductPrice(
                                    int.parse(data['price']));
                              },
                              icon: const Icon(
                                Icons.add,
                                color: darkFontGrey,
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text(
                                " ${data['quantity']} Available",
                                style: const TextStyle(
                                    color: fontGrey,
                                    fontFamily: semibold,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => Row(
                          children: [
                            const SizedBox(
                              width: 100,
                              child: Text(
                                "Total :",
                                style: TextStyle(
                                    color: fontGrey,
                                    fontFamily: semibold,
                                    fontSize: 16),
                              ),
                            ),
                            Text(
                              "Rs ${categoryController.totalPrice.value}",
                              style: const TextStyle(
                                  color: redColor,
                                  fontFamily: semibold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        "Description",
                        style: TextStyle(
                            color: darkFontGrey,
                            fontFamily: bold,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${data['description']}',
                        style: const TextStyle(
                            color: darkFontGrey,
                            fontFamily: regular,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        child: ListView(
                            shrinkWrap: true,
                            children: List.generate(
                                5,
                                (index) => ListTile(
                                    leading: Text(
                                      bottomItem[index],
                                      style: const TextStyle(
                                          color: darkFontGrey,
                                          fontFamily: bold,
                                          fontSize: 16),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon:
                                          const Icon(Icons.arrow_forward_sharp),
                                    )))),
                      ),
                      const Text(
                        productYouMayAlsoLike,
                        style: TextStyle(
                            color: darkFontGrey,
                            fontFamily: semibold,
                            fontSize: 16),
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
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: customButton(
                  color: redColor,
                  title: addToCart,
                  press: () {
                    if (controller.quantity.value != 0) {
                      cartController.addToCart(
                          price: data['price'],
                          salerId: data['salerId'],
                          image: data['images'][0],
                          saler: data['salerName'],
                          color: data['colors'][controller.selectedColor.value],
                          totalPrice: controller.totalPrice.value,
                          productName: data['name'],
                          qunatity: controller.quantity.value);
                      utils.flutterToast("Added to cart");
                    } else {
                      utils.flutterToast("Please select quantity first!");
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
