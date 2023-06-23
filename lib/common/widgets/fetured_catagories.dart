import '../../constants/const.dart';

Widget featuredButton({
  String? title,
  icon,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        Image.asset(
          icon,
          width: 40,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          title!,
          style: const TextStyle(
              color: fontGrey, fontFamily: semibold, fontSize: 18),
        ),
      ],
    ),
  );
}
