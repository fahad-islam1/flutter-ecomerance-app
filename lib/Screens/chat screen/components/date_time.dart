import '../../../constants/const.dart';

class TimeFormat{
   static getLastMsgTime(
      {required BuildContext context, required String time, showyear = false}) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();

    if (now.day == date.day &&
        now.month == date.month &&
        now.year == date.year) {
      return TimeOfDay.fromDateTime(date).format(context);
    } else {
      return showyear
          ? '${date.day} ${getMonth(date)} ${date.year}'
          : '${date.day} ${getMonth(date)}';
    }
  }
    static getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'March';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'Invalid month';
    }
  }
}