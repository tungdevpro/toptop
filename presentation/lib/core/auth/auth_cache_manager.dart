import 'package:domain/model/user_model.dart';
import 'package:presentation/import.dart';

class AuthCacheManager {
  static final AuthCacheManager _inst = AuthCacheManager._internal();

  AuthCacheManager._internal();

  factory AuthCacheManager() {
    return _inst;
  }

  Future<bool> isLoggedIn() async {
    final result = await CacheManager.get<String>(AppKeyCaches.token.path);
    return (result == null) ? false : result;
  }

  Future<void> saveAcc({UserModel? model, String? token}) async {
    if (token != null) CacheManager.put(AppKeyCaches.token.path, token);
    // if(model != null) _cache.
  }

  Future<void> clear() async {
    CacheManager.delete(AppKeyCaches.token.path);
  }
}
