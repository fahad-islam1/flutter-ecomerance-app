import '../../../constants/const.dart';

Widget customOrderDetails({title1, subtitle1, title2, subtitle2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title1,
              style: const TextStyle(
                fontSize: 18,
                color: darkFontGrey,
                fontFamily: bold,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              subtitle1,
              style: const TextStyle(
                fontSize: 14,
                color: fontGrey,
                fontFamily: semibold,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title2,
              style: const TextStyle(
                fontSize: 18,
                color: darkFontGrey,
                fontFamily: bold,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              subtitle2,
              style: const TextStyle(
                fontSize: 14,
                color: darkFontGrey,
                fontFamily: semibold,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
