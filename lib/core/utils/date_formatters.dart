
class DateFormatter {
  /// Converts a full ISO date string to 'YYYY-MM-DD'
  static String toYearMonthDay(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      return '${dateTime.year.toString().padLeft(4, '0')}-'
          '${dateTime.month.toString().padLeft(2, '0')}-'
          '${dateTime.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return isoDate; // fallback if parsing fails
    }
  }

  /// Optional: more human-readable format like 'Aug 30, 2025'
  static String toReadable(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      return '${_monthName(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
    } catch (e) {
      return isoDate;
    }
  }

  static String _monthName(int month) {
    const months = [
      '', // placeholder for 0 index
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }
}
