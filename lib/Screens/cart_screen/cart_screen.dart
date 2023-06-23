import 'package:emart/Screens/cart_screen/shipping_screen.dart';
import 'package:emart/common/widgets/loading.dart';
import 'package:get/get.dart';

import '../../constants/const.dart';
import '../../features/cotroller/cart/cart_controller.dart';
import '../../features/cotroller/firestore/firestore_services.dart';
import '../../features/cotroller/payment/payment_controller.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final fireStoreController = Get.put(FireStore());
  final cartController = Get.put(CartController());
  final paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    final paymentcontroller = Get.find<PaymentController>();
    final controller = Get.find<CartController>();

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: const Text(
          shoppingCart,
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: bold,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: fireStoreController.getCartProducts(uid: currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Loading();
            } else {
              var data = snapshot.data!.docs;
              paymentcontroller.productSnapshot = data;
              cartController.changePrice(data);

              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                              leading: CircleAvatar(
                                radius: size.width * .058,
                                backgroundImage:
                                    NetworkImage('${data[index]['img']}'),
                              ),
                              title: Text(
                                '${data[index]['productName']}  (x ${data[index]['qunatity']})',
                                style: const TextStyle(
                                    color: darkFontGrey,
                                    fontFamily: semibold,
                                    fontSize: 16),
                              ),
                              subtitle: Text(
                                'Rs ${data[index]['totalPrice']}',
                                style: const TextStyle(
                                    color: redColor,
                                    fontFamily: semibold,
                                    fontSize: 14),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  cartController.deleteCart(data[index].id);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: redColor,
                                  size: 30,
                                ),
                              )),
                        ),
                      );
                    },
                  )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    width: size.width,
                    color: lightGolden,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Price",
                          style: TextStyle(
                            color: darkFontGrey,
                            fontSize: 18,
                            fontFamily: bold,
                          ),
                        ),
                        Obx(
                          () => RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                const TextSpan(
                                  text: 'Rs  ',
                                  style: TextStyle(
                                    color: redColor,
                                    fontSize: 18,
                                    fontFamily: bold,
                                  ),
                                ),
                                TextSpan(
                                  text: '${controller.totalPrice.value}',
                                  style: const TextStyle(
                                    color: darkFontGrey,
                                    fontSize: 18,
                                    fontFamily: bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: size.width,
                      height: 50,
                      child: customButton(
                        color: redColor,
                        title: proceedToShipping,
                        press: () {
                          print(controller.totalPrice.value);
                          Get.to(() => ShippingDetailScreen(
                                price: controller.totalPrice.value,
                              ));
                        },
                      ))
                ],
              );
            }
          }),
    );
  }
}
