import 'package:emart/Screens/payment_screen/selected_payment_method_screen.dart';
import 'package:get/get.dart';

import '../../constants/const.dart';

import '../../features/cotroller/category/category_controller.dart';
import '../../features/cotroller/payment/payment_controller.dart';

class PaymentMethodScreen extends StatelessWidget {
  PaymentMethodScreen({super.key, this.price});
  final price;
  final paymentController = Get.put(PaymentController());
  final categoryController = Get.put(CategoryModelController());
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();
    final categoryModelController = Get.find<CategoryModelController>();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          paymentscreen,
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: bold,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
          width: size.width,
          height: 50,
          child: customButton(
            color: redColor,
            title: 'Place my order',
            press: () {
              paymentController.placeOrder(
                  paymentMethod: paymentMethod[controller.select.value],
                  toatlprice: price);
              paymentController.clearCart();
              utils.flutterToast('Order placed Successfully');
              Get.off(Home());

              
            },
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Obx(
              () => Column(
                children: List.generate(
                    paymentMethodsimgList.length,
                    (index) => GestureDetector(
                          onTap: () {
                            controller.changeIndex(index);
                          },
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                clipBehavior: Clip.antiAlias,
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    boxShadow: controller.select.value == index
                                        ? const [
                                            BoxShadow(
                                              color: redColor, // shadow color
                                              offset: Offset(0,
                                                  2), // changes position of shadow
                                              blurRadius:
                                                  2.0, // changes length of shadow
                                              spreadRadius:
                                                  1.0, // changes width of shadow
                                            ),
                                          ]
                                        : [],
                                    borderRadius: BorderRadius.circular(
                                        size.height * .02),
                                    border: controller.select.value == index
                                        ? Border.all(color: redColor, width: 3)
                                        : Border.all()),
                                child: Image(
                                  colorBlendMode: BlendMode.darken,
                                  color: controller.select.value == index
                                      ? Colors.black.withOpacity(0.4)
                                      : Colors.transparent,
                                  width: size.width,
                                  fit: BoxFit.cover,
                                  height: size.height * .17,
                                  image: AssetImage(
                                    paymentMethodsimgList[index],
                                  ),
                                ),
                              ),
                              controller.select.value == index
                                  ? Transform.scale(
                                      scale: 1.3,
                                      child: Checkbox(
                                        checkColor: whiteColor,
                                        activeColor: Colors.green,
                                        value: true,
                                        onChanged: (value) {
                                          // controller.changeIndex(index);
                                        },
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
