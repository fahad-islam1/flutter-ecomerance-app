// import 'package:emart/Screens/chat%20screen/components/date_time.dart';

import '../../../constants/const.dart';
import 'package:intl/intl.dart' as intl;

Widget sendMessage(context, data) {
  var t =
      data['createdAt'] == null ? DateTime.now() : data['createdAt'].toDate();
  var time = intl.DateFormat('hh:mm').format(t);
  final size = MediaQuery.of(context).size;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(left: size.width * .05),
        child: Row(
          children: [
            const SizedBox(width: 7),
            Text(
//               TimeFormat.getLastMsgTime(context: context, time:   t 
// ),
      time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      Flexible(
          child: Container(
              padding: EdgeInsets.all(size.width * .03),
              margin: EdgeInsets.symmetric(
                  vertical: size.height * .01, horizontal: size.width * .03),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 156, 235, 195),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              child: Text(
                data['msg'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ))),
    ],
  );
}

Widget recieveMessage(context, data) {
  final size = MediaQuery.of(context).size;
  var t =
      data['createdAt'] == null ? DateTime.now() : data['createdAt'].toDate();
  var time = intl.DateFormat('hh:mm').format(t);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        child: Container(
            padding: EdgeInsets.all(size.height * .03),
            margin: EdgeInsets.symmetric(
                vertical: size.height * .01, horizontal: size.width * .03),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 201, 221, 255),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Text(
              // TimeFormat.getLastMsgTime(context: context, time:  t),
              time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )),
      ),
      Padding(
        padding: EdgeInsets.only(right: size.width * .03),
        child: Text(
          data['msg'],
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      )
    ],
  );
}
