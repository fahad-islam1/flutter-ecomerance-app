import '../../../constants/const.dart';

Widget orderStatus({color, title, status, icon}) {
  return ListTile(
      leading: Container(
        decoration: BoxDecoration(border: Border.all(color: color)),
        child: icon,
      ),
      trailing: SizedBox(
        width: 150,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: darkFontGrey,
                fontFamily: bold,
              ),
            ),
            status
                ? const Icon(
                    Icons.done,
                    color: Colors.green,
                    size: 28,
                  )
                : Container()
          ],
        ),
      ));
}
