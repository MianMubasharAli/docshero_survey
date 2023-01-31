import 'dart:async';
import 'dart:convert';

import 'package:docshero/components/constants.dart';
import 'package:docshero/components/models/login_models/user_model.dart';
import 'package:docshero/screens/dashboard_screen.dart';
import 'package:docshero/screens/survey_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/models/login_models/login_model.dart';
import '../components/models/survey_model.dart';
import '../components/models/survey_model2.dart';
import '../components/providers/api_data_provider.dart';
import '../components/providers/data_provilder.dart';
import '../components/utils/shared_preferences.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  loadAssets() async{
    SharedPreferences _prefs= await SharedPreferences.getInstance() ;
    bool? saveMe= _prefs.getBool(SharedPreferencesData.Remember_Me) ?? false;
    final String response = await rootBundle.loadString("assets/files/surveyJson.js");
    // var data= await jsonDecode(response);
    // Welcome2 surveyModel=Welcome2.fromJson(data);
    // Provider.of<DataProvider>(context,listen: false).surveyModel=surveyModel;



        Timer(Duration(seconds: 3), () async {
          if(saveMe==true) {
            // String? userData= _prefs.getString(SharedPreferencesData.User_Data) ?? "";
            // Map<String, dynamic> apiResponse = jsonDecode(userData);
            // UserModel user=UserModel.fromJson(apiResponse);
            //  await Provider.of<DataProvider>(context,listen: false).setUserModel(user);

           String? loginData=_prefs.getString(SharedPreferencesData.Login_Data) ?? "";
            Map<String, dynamic> response = jsonDecode(loginData);
            LoginModel loginModel=LoginModel.fromJson(response);

           await Provider.of<ApiDataProvider>(context,listen: false).getUserData(context, loginModel.tokenInfo!.userId!, loginModel.token!);
            await Provider.of<DataProvider>(context,listen: false).setLoginModel(loginModel);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => DashboardScreen()), (
                    route) => false);
          }else{
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) => LoginScreen()), (
                    route) => false);
          }
        });




  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAssets();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 200,
              width: 200,
              padding: EdgeInsets.all(5),

              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: kOrangeColor,
                shape: BoxShape.circle
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset("assets/images/logo.png",height: 120,width: 120,),
                  ),
                  Align(

                  )
                ],
              ),
            ),
          ),
          mediumText("DocsHero Survey",color: kOrangeColor, ),

          SizedBox(height: 20,),
          CircularProgressIndicator(color: kOrangeColor,)
        ],
      ),
    );
  }
}
