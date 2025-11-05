import 'package:get_storage/get_storage.dart';

class TokenService {
  static final _storage = GetStorage();

  static String? get token => _storage.read('token');

  static void save(String token, String name) {
    _storage.write('token', token);
    _storage.write('user_name', name);
    print("📝 Token saved: $token");
    print("📝 User name saved: $name");
  }

  static void clear() {
    _storage.remove('token');
    _storage.remove('user_name');
  }
}
