import 'dart:convert';

import 'package:docshero/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../components/models/survey_model.dart';
import '../components/models/survey_model2.dart';
import '../components/providers/data_provilder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  loadAssets() async{
    final String response = await rootBundle.loadString("assets/files/surveyJson.js");
    var data= await jsonDecode(response);
    Welcome2 surveyModel=Welcome2.fromJson(data);
    Provider.of<DataProvider>(context,listen: false).surveyModel=surveyModel;
    print("data is: ${data}");
    if(data != null){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeScreen()), (route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAssets();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Splash Screen"),
        ),
      ),
    );
  }
}
