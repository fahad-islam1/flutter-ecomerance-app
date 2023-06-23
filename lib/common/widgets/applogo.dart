import '../../constants/const.dart';

Widget appLogoWidget() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16)),
    width: 76,
    height: 76,
    child: Image.asset(
      iconAppLogo,
      fit: BoxFit.fill,
    ),
  );
}
