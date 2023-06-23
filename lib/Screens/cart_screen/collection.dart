import '../../constants/const.dart';

Widget cartButton({String? title, count, width}) {
  return Container(
    height: 60,
    width: width,
    decoration: BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.circular(12)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count!,
          style: const TextStyle(
              letterSpacing: 1.5,
              color: darkFontGrey,
              fontFamily: regular,
              fontSize: 14),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          title!,
          style: const TextStyle(
              color: darkFontGrey, fontFamily: regular, fontSize: 14),
        ),
      ],
    ),
  );
}
