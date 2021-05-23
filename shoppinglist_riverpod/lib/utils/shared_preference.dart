import 'package:shared_preferences/shared_preferences.dart';


SharedPreferences? sharedPreferences;
final String userSignUpStep = "userSignUpStep";

Future<void> initSharedPref() async {
  sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences?.getString(userSignUpStep) == null) {
    sharedPreferences?.setString(userSignUpStep, "noSignUp");
  }
}
