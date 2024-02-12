class Utils {
  static bool contains(String value, String elem, {bool ignoreCase = false}) {
    if (!ignoreCase) {
      return value.toString().contains(elem);
    }
    return value.toString().toLowerCase().contains(elem.toLowerCase());
  }
}
