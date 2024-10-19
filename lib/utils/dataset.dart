// import 'package:scapia/utils/date.dart';

// class DatasetsUtil {
//   // Filtering datasets where the key is on the same month of referenceDate
//   static Map<DateTime, int> filterMonth(
//       Map<DateTime, int>? datasets, DateTime referenceDate) {
//     return Map.from(datasets ?? {})
//       ..removeWhere(
//         (date, value) => !(date
//                     .isAfter(CustomDateUtils.startDayOfMonth(referenceDate)) &&
//                 date.isBefore(CustomDateUtils.endDayOfMonth(referenceDate)) ||
//             date == CustomDateUtils.endDayOfMonth(referenceDate) ||
//             date == CustomDateUtils.startDayOfMonth(referenceDate)),
//       );
//   }

//   // Get maximum value of datasets.
//   static double getMaxValue(Map<DateTime, double>? datasets) {
//     double result = 0;

//     datasets?.forEach((date, value) {
//       if (value > result) {
//         result = value;
//       }
//     });

//     return result;
//   }
// }
