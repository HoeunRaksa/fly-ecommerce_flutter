class StringUtils {
  // Static method approach
  static String truncate(String text, {int maxLength = 30}) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  // Truncate with custom suffix
  static String truncateWithSuffix(
    String text, {
    int maxLength = 30,
    String suffix = '...',
  }) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}$suffix';
  }

  // Truncate in the middle (useful for file names)
  static String truncateMiddle(String text, {int maxLength = 30}) {
    if (text.length <= maxLength) {
      return text;
    }

    final halfLength = (maxLength - 3) ~/ 2;
    final start = text.substring(0, halfLength);
    final end = text.substring(text.length - halfLength);

    return '$start...$end';
  }
}