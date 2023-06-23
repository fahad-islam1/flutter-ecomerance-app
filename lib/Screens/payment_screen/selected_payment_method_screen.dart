import 'package:emart/features/cotroller/payment/payment_controller.dart';
import 'package:get/get.dart';

import '../../constants/const.dart';

class SelectedMethod extends StatelessWidget {
  SelectedMethod({super.key});
  final paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentController>();
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
            title: 'Continue',
            press: () {
            },
          )),
    );
  }
}
