bool empty([dynamic data, bool acceptZero = false]) {
  if (data != null) {
    if ((data is Map || data is List) && data.length == 0) {
      return true;
    }
    if ((data is Map || data is Iterable) && data.isEmpty) {
      return true;
    }
    if (data is bool) {
      return !data;
    }
    if ((data is String || data is num) && (data == '0' || data == 0)) {
      if (acceptZero) {
        return false;
      } else {
        return true;
      }
    }
    if (data.toString().isNotEmpty) {
      return false;
    }
  }
  return true;
}
