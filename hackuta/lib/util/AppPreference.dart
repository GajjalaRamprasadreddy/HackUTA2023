
import 'package:philia/model/UserInfo.dart';

class AppPreference {
  static final AppPreference _singleton = AppPreference._internal();

  factory AppPreference() {
    return _singleton;
  }

  AppPreference._internal();

  Users? user;
}
