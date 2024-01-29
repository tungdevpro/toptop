import '../helper/helper.dart';

extension ListExts on Iterable {
  bool inArray(dynamic value, var array) {
    if (!empty(value) && !empty(array)) {
      if (array is List || array is Map) {
        if (array is Map) {
          return array.containsValue(value);
        }
        if (array is List) {
          return array.contains(value);
        }
      }
      return false;
    }
    return false;
  }
}
