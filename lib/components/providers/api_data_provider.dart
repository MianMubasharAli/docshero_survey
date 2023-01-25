import 'dart:convert';

import 'package:docshero/components/constants.dart';
import 'package:docshero/components/models/companies_models/all_companies_model.dart';
import 'package:docshero/components/models/companies_models/location_by_id.dart';
import 'package:docshero/components/models/companies_models/single_company_data_model.dart';
import 'package:docshero/components/models/login_models/user_model.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:docshero/components/providers/location_apis.dart';
import 'package:docshero/components/reuseable_widgets/custom_loader.dart';
import 'package:docshero/screens/drawer/forms/company_location_details.dart';
import 'package:docshero/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/drawer/company_home.dart';
import '../models/login_models/login_model.dart';
import '../utils/shared_preferences.dart';

class ApiDataProvider extends ChangeNotifier{


  bool _rememberMe=false;

  setRememberMe(bool remember){
    _rememberMe=remember;
    notifyListeners();
  }

  Future login(BuildContext context, String email, String password) async{
    Uri url=Uri.parse(BASE_URL+"login");
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Get.dialog(CustomLoader());
    try{
      Map credentials = {
        'mail': email,
        'password': password,
      };

      var body=jsonEncode(credentials);

      var response = await http.post(url, body: body);
      if(response.statusCode == 200){

        await SharedPreferencesData.saveLoginData(response.body);
        await SharedPreferencesData.saveRememberMe(rememberMe);

        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        LoginModel user=LoginModel.fromJson(apiResponse);
        await dataProvider.setLoginModel(user);
        await getUserData(context, user.tokenInfo!.userId!,user.token!);
        Get.back();
        if(user.refreshToken != "" && user.refreshToken != null){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomeScreen()), (route) => false);
        }
      }else{
        Get.back();
        showSnackbar(context, "Please enter valid credentials", Colors.red);
      }
    }catch(e){
      Get.back();
      print("Error from login is: $e");
    }
  }

  Future getUserData(BuildContext context, String id, String token) async{
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(BASE_URL+"list-user-by-id?id=$id");
    try{
      var header = {
        "Authorization": "Bearer $token",
      };
      var response = await http.get(url,headers: header);
      if(response.statusCode == 200){
        await SharedPreferencesData.saveUserData(response.body);

        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        UserModel user=UserModel.fromJson(apiResponse);
        await dataProvider.setUserModel(user);
      }
    }catch(e){
      print("error from getUserData is: $e");
    }
  }

  Future<bool> getAllCompanies(BuildContext context, String token, {bool isDelete=false}) async{
    bool check=false;
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"companies");
    Get.dialog(CustomLoader());
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      var response = await http.get(url,headers: header);
      if(response.statusCode == 200){
        check=true;
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        AllCompaniesModel model=AllCompaniesModel.fromJson(apiResponse);
        await dataProvider.setAllCommpaniesModel(model);
        Get.back();
        if(isDelete==false){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Companies()));
        }
      }else{
        Get.back();
      }
      return check;
    }catch(e){
      Get.back();
      print("error from getAllCompanies is: $e");
      return check;
    }
  }

  Future createCompany(BuildContext context, String token) async{
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"companies");
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    LocationApis locationApiProvider = Provider.of<LocationApis>(context,listen:false);
    Get.dialog(CustomLoader());
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      Map data = {
        "companyName": dataProvider.name,
        "vatId": dataProvider.vatId,
        "url": dataProvider.url,
        "phone": dataProvider.phone,
        "fax": null,
        "type": dataProvider.type,
        "customerType": dataProvider.customerType,
        "addressFirst": dataProvider.address1,
        "addressSecond": dataProvider.address2,
        "city": dataProvider.city,
        "country": dataProvider.country,
        "state": dataProvider.state,
        "zip": dataProvider.zip
      };

      var body=jsonEncode(data);

      var response = await http.post(url, headers: header,body: body);
      if(response.statusCode == 200){
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        if(apiResponse["success"]==true){
          showSnackbar(context, "${apiResponse["message"]}", kOrangeColor);
          await locationApiProvider.getLocationById(context, token, apiResponse["company_id"]);
          dataProvider.setComapnyId(apiResponse["company_id"]);
          Get.back();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CompanyLocationDetails()));
        }
      }else{
        Get.back();
        showSnackbar(context, "Something went wrong", Colors.red);
      }

    }catch(e){
      Get.back();
      print("Error from login is: $e");
    }
  }
  Future updateCompany(BuildContext context, String? token,String id) async{
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"companies/$id");
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    LocationApis locationApiProvider = Provider.of<LocationApis>(context,listen:false);
    Get.dialog(CustomLoader());
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      Map data = {
        "companyName": dataProvider.name,
        "vatId": dataProvider.vatId,
        "url": dataProvider.url,
        "phone": dataProvider.phone,
        "fax": dataProvider.fax,
        "type": dataProvider.type,
        "customerType": dataProvider.customerType,
        "addressFirst": dataProvider.address1,
        "addressSecond": dataProvider.address2,
        "city": dataProvider.city,
        "country": dataProvider.country,
        "state": dataProvider.state,
        "zip": dataProvider.zip,
        "location_id":dataProvider.defaultLocationId
      };

      var body=jsonEncode(data);

      var response = await http.put(url, headers: header,body: body);
      if(response.statusCode == 200){
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        if(apiResponse["success"]==true){
          showSnackbar(context, "${apiResponse["message"]}", kOrangeColor);
           await locationApiProvider.getLocationById(context, token!, dataProvider.companyId!);
          // dataProvider.setComapnyId(apiResponse["company_id"]);
          Get.back();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CompanyLocationDetails()));
        }
      }else{
        Get.back();
        showSnackbar(context, "Something went wrong", Colors.red);
      }

    }catch(e){
      Get.back();
      print("Error from updateCompany is: $e");
    }
  }

  Future showCompanyById(BuildContext context, String token,String id) async{
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    LocationApis locationApis = Provider.of<LocationApis>(context,listen:false);
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"companies/$id");
    Get.dialog(CustomLoader());
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      var response = await http.get(url,headers: header);
      if(response.statusCode == 200){
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        SingleCompanyDataModel model=SingleCompanyDataModel.fromJson(apiResponse);
        dataProvider.singleCompanyDataModel=model;
        dataProvider.setComapnyId(model.modelData?.id);
        await locationApis.getLocationById(context, dataProvider.loginModel!.token!, model.modelData!.id!);
        Get.back();

      }else{
        Get.back();
      }
    }catch(e){
      Get.back();
      print("error from showCompanyById is: $e");
    }
  }

  Future deleteCompanyById(BuildContext context, String token,String id) async{
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"companies/$id");
    Get.dialog(CustomLoader());
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      var response = await http.delete(url,headers: header);
      if(response.statusCode == 200){
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        Get.back();
        await getAllCompanies(context, dataProvider.loginModel!.token!,isDelete: true);
        dataProvider.showSnackbar(context, "${apiResponse['message']}", kOrangeColor);

      }else{
        Get.back();
      }
    }catch(e){
      Get.back();
      print("error from deleteCompanyById is: $e");
    }
  }


  void showSnackbar(BuildContext context,String text,Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(seconds: 3),
        backgroundColor: color,
      ),
    );
  }


  //getters
bool get rememberMe => _rememberMe;
}