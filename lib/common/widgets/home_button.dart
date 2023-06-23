import '../../constants/const.dart';

Widget homeScreenButton({String? title, icon, height, width}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.circular(10)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 25,
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title!,
            style: const TextStyle(
                color: fontGrey, fontFamily: semibold, fontSize: 18),
          ),
        ),
      ],
    ),
  );
}
