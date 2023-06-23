import '../../constants/const.dart';

Widget customButton({press, String? title, Color? color, textColor}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color
    ),
    onPressed: press, child: Text(title!,
        style: TextStyle(
            color:textColor, fontFamily: semibold, fontSize: 18),
      ),);
}
