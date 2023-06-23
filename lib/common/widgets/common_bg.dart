import '../../constants/const.dart';

Widget customBg({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
          image: AssetImage(
            imgBackground,
          ),
          fit: BoxFit.fill),
    ),
    child: child,
  );
}
