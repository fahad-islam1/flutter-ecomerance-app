import '../../constants/const.dart';
import 'components/custom_order_details.dart';
import 'components/order_icons.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          orderdetailsScreen,
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics:const BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(
                icon: const Icon(Icons.done_rounded, color: redColor),
                color: redColor,
                status: true,
                // status: data != null ? data['order_place'] : false,
                // status: data['order_place'],
                title: 'Order Placed'),
            orderStatus(
                icon: const Icon(Icons.thumb_up_alt, color: Colors.blue),
                color: Colors.blue,
                status: true,
                // status: data['order_place'],
                title: 'Confirmed'),
            orderStatus(
                icon: const Icon(Icons.commute_sharp, color: Colors.yellow),
                color: Colors.yellow,
                status: true,
                // status: data['order_place'],
                title: 'On Delivered'),
            orderStatus(
                icon: const Icon(Icons.done_rounded, color: redColor),
                color: redColor,
                status: true,
                // status: '${data['order_place']}',
                title: 'Delivery'),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            customOrderDetails(
                title1: 'Order Code',
                subtitle1: '${data['order_code']}',
                title2: 'Shipping Method',
                subtitle2: '${data['delivery']}'),
            customOrderDetails(
                title1: 'Order Date',
                subtitle1: intl.DateFormat()
                    .add_yMd()
                    .format((data['order_date'].toDate())),
                title2: 'Payment Method',
                subtitle2: '${data['paymentMethod']}'),
            customOrderDetails(
                title1: 'Payment Status',
                subtitle1: 'Unpaid',
                title2: 'Delivery Status',
                subtitle2: 'Order placed'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Shipping Address",
                        style: TextStyle(
                          fontSize: 16,
                          color: darkFontGrey,
                          fontFamily: bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${data['name']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: darkFontGrey,
                          fontFamily: semibold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        data['email'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: darkFontGrey,
                          fontFamily: semibold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        // '${ }',
                        '${data['contact']}',

                        style: const TextStyle(
                          fontSize: 16,
                          color: darkFontGrey,
                          fontFamily: semibold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${data['address']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: darkFontGrey,
                          fontFamily: semibold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        data['city'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: darkFontGrey,
                          fontFamily: semibold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        data['state'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: darkFontGrey,
                          fontFamily: semibold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        data['country'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: darkFontGrey,
                          fontFamily: semibold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${data['postal_code']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: darkFontGrey,
                          fontFamily: semibold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Ammount",
                          style: TextStyle(
                            fontSize: 18,
                            color: darkFontGrey,
                            fontFamily: bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Rs  ${data['totalPrice']}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: redColor,
                            fontFamily: bold,
                          ),
                        ),
                      ]),
                ],
              ),
            ),
            const Divider(
              thickness: .5,
              color: fontGrey,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Order List',
                style: TextStyle(
                  fontSize: 20,
                  color: darkFontGrey,
                  fontFamily: bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(data['orders_list'].length, (index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customOrderDetails(
                        title1: '${data['orders_list'][index]['productName']}',
                        subtitle1:
                            '${data['orders_list'][index]['qunatity']} x',
                        title2: ' RS ${data['orders_list'][index]['Price']}',
                        subtitle2: 'Non Refundable'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: Container(
                        width: 30,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Color(data['orders_list'][index]['color']),
                        ),
                      ),
                    )
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
