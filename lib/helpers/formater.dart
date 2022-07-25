import 'package:intl/intl.dart';

class Formater {

  /// Retorna a data no formato de "[mês (abreviado)] [dia], [ano]"
  static String toAbrMonthDayYear(DateTime date) {
    return DateFormat('MMM dd, yyyy', 'pt_BR').format(date).toUpperCase();
  }

  /// Retorna a data no formato de "[dia]/[mês]/[ano]"
  static String toDayMonthYear(DateTime date) {
    return DateFormat('dd/MM/yyyy', 'pt_BR').format(date).toUpperCase();
  }

  /// Retorna a data no formato de "[dia]/[mês]/[ano]"
  static String toDayMonthYearHourMin(DateTime date) {
    return DateFormat('dd/MM/yyyy hh:mm', 'pt_BR').format(date).toUpperCase();
  }

  /// Retorna o dia da semana representado pela data
  static String toWeekDay(DateTime date) {
    String weekDay = DateFormat('E', 'pt_BR').format(date);
    return '${weekDay[0].toUpperCase()}${weekDay.substring(1)}';
  }

  /// Retorna a hora e o minuto "[hora]:[minuto]"
  static String toHourMin(DateTime date) {
    return DateFormat('hh:mm', 'pt_BR').format(date);
  }

}