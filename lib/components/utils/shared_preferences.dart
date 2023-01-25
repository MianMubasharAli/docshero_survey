import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesData{
  static String Login_Data='login_data_key';
  static String Remember_Me='remember_me_key';
  static String User_Data= 'save_user_data_key';

  static saveRememberMe(bool data) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setBool(Remember_Me, data);
  }
  static saveLoginData(String data) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString(Login_Data, data);
  }
  static saveUserData(String data) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString(User_Data, data);
  }

}