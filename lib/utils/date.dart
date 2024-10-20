class CustomDateUtils {
  static const List<String> week = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  static const List<String> month = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  static String monthShort(int month) {
    // List of abbreviated month names
    const List<String> monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];

    // Return the month name based on the month number
    return monthNames[month - 1]; // Month number starts from 1
  }

  // get a date exactly one year before based on the referenceDate
  DateTime oneYearBefore(final DateTime referenceDate) =>
      DateTime(referenceDate.year - 1, referenceDate.month, referenceDate.day);

  // change day of referenceDate
  static DateTime changeDay(final DateTime referenceDate, final int dayCount) =>
      DateTime(referenceDate.year, referenceDate.month,
          referenceDate.day + dayCount);

  // get start day of the month
  static DateTime startDayOfMonth(final DateTime referenceDate) =>
      DateTime(referenceDate.year, referenceDate.month, 1);

  // get last day of the month
  static DateTime endDayOfMonth(final DateTime referenceDate) =>
      DateTime(referenceDate.year, referenceDate.month + 1, 0);

  static String getReadableDate(DateTime currentDate) {
    final year = currentDate.year;
    final month = currentDate.month;
    final day = currentDate.day;

    return "$day/$month/$year";
  }

  static DateTime getDate(DateTime currentDate) {
    final year = currentDate.year;
    final month = currentDate.month;
    final day = currentDate.day;

    return DateTime(year, month, day);
  }

  static String getReadableTime(DateTime currentDate) {
    int hour = currentDate.hour;
    int minutes = currentDate.minute;
    int seconds = currentDate.second;

    String period = hour >= 12 ? 'PM' : 'AM';

    hour = hour % 12;
    if (hour == 0) {
      // special case when time is 12 or 0 in 24 hour format
      hour = 12;
    }

    String formattedMin = minutes.toString().padLeft(2, '0');

    return "$hour:$formattedMin $period";
  }
}
