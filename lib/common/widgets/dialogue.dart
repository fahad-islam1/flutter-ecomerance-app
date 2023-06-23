import 'package:flutter/services.dart';

import '../../constants/const.dart';

Widget alertDialogue(context) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    child: Dialog(
        child: Padding(
      padding: EdgeInsets.all(13),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Confirm",
            style:
                TextStyle(color: darkFontGrey, fontFamily: bold, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Are you want to exit ?",
            style:
                TextStyle(color: darkFontGrey, fontFamily: bold, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customButton(
                  title: 'Yes',
                  color: redColor,
                  press: () {
                    SystemNavigator.pop();
                  },
                  textColor: golden),
              customButton(
                  title: 'No',
                  color: redColor,
                  press: () {
                    Navigator.pop(context);
                  },
                  textColor: golden)
            ],
          )
        ],
      ),
    )),
  );
}
