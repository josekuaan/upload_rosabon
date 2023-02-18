import 'package:intl/intl.dart';

String yMDDate(DateTime datetime) {
  var formatDate = DateFormat("dd-MM-yyyy").format(datetime);

  return formatDate;
}
