
import 'package:intl/intl.dart';

String dateFormat(DateTime date) {
  return DateFormat('dd MMMM, hh:mm a').format(date);
}
