import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceModule {
  final SharedPreferences pref;
  static const String _PREF_USER = "user_data";

  SharedPreferenceModule({required this.pref});

  void clear() => pref.clear();

  void saveUserData(String userDataInJson) => pref.setString(_PREF_USER, userDataInJson);

  String getUserData() {
    String userDataInJson = pref.getString(_PREF_USER) ?? "";
    return userDataInJson;
  }



}