import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en_US',
    ).format(number);

    return formattedNumber;
  }

  static String date(String date) {
    final DateTime dateTime = DateTime.parse(date);
    final DateFormat formatter = DateFormat('MMMM  dd', 'es_ES');
    final String formatted = formatter.format(dateTime);
    // Primera letra en mayuscula
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  // Quitar el punto y devolverlo como porcentaje
  static String percentage(double number) {
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol: '',
      locale: 'en_US',
    ).format(number);

    return formattedNumber.replaceAll('.', '');
  }
}
