import '../../constants/const.dart';

Widget customTextField({
  String? title,
  String? hintText,
  controller,
  bool ispass = false,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: const TextStyle(
              color: redColor, fontFamily: semibold, fontSize: 18),
        ),
        const SizedBox(
          height: 3,
        ),
        TextFormField(
          obscureText: ispass,
          controller: controller!,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: textfieldGrey,
              fontFamily: semibold,
            ),
            border: InputBorder.none,
            isDense: true,
            fillColor: lightGrey,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: redColor),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    ),
  );
}
