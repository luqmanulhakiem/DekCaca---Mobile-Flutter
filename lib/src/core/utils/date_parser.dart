import 'package:intl/intl.dart';

String dateParses(String dateTimeString, String status) {
  // Parse the string into DateTime
  DateTime parsedDateTime = DateTime.parse(
      dateTimeString == "" ? "2024-09-13 12:00:00" : dateTimeString);
  if (status == 'date') {
    // Format for date only
    String formattedDate = DateFormat('d MMM yyyy').format(parsedDateTime);

    return formattedDate;
  } else {
    // Format for time only
    String formattedTime = DateFormat('HH:mm').format(parsedDateTime);

    return formattedTime;
  }
}
