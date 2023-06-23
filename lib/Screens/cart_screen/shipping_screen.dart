import 'package:get/get.dart';

import '../../constants/const.dart';
import '../../features/cotroller/payment/payment_controller.dart';
import '../payment_screen/payment_screen.dart';

class ShippingDetailScreen extends StatelessWidget {
  ShippingDetailScreen({super.key, this.price});
  final price;
  final cartController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          shippingScreen,
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
            title: 'Continue',
            press: () {
              Get.to(() => PaymentMethodScreen(price: price));
              // if (controller.contactcontroller.text.isNotEmpty &&
              //     controller.postalcontroller.text.isNotEmpty &&
              //     controller.addresscontroller.text.length > 10) {
              //   Get.to(() => const PaymentMethodScreen());
              // } else {
              //   utils.flutterToast('Please fill all the fields');
              // }
            },
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  customTextField(
                    controller: controller.namecontroller,
                    title: "Name",
                    hintText: 'Enter your name',
                  ),
                  customTextField(
                    controller: controller.countrycontroller,
                    title: "Country",
                    hintText: 'Enter your country',
                  ),
                  customTextField(
                    controller: controller.statecontroller,
                    title: "State",
                    hintText: 'Enter your State',
                  ),
                  customTextField(
                    controller: controller.addresscontroller,
                    title: "Adreess",
                    hintText: 'Enter your Adreess',
                  ),
                  customTextField(
                    controller: controller.citycontroller,
                    title: "City",
                    hintText: 'Enter your City',
                  ),
                  customTextField(
                    controller: controller.postalcontroller,
                    title: "PostalCode",
                    hintText: 'Enter your PostalCode',
                  ),
                  customTextField(
                    controller: controller.contactcontroller,
                    title: "Contact",
                    hintText: 'Enter your Contact',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
