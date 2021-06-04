import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceModule {
  final SharedPreferences pref;
  static const String _PREF_TOKEN = "token";

  SharedPreferenceModule({required this.pref});

  void setToken(String token) => pref.setString(_PREF_TOKEN, token);

  String getToken() {
    String token = pref.getString(_PREF_TOKEN) ?? "";
    return token;
  }

  void clear() => pref.clear();

}