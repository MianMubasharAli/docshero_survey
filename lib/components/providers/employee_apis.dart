import 'dart:convert';

import 'package:docshero/components/models/companies_models/get_employee_by_id_model.dart';
import 'package:docshero/components/models/companies_models/post_employee_model.dart';
import 'package:docshero/components/reuseable_widgets/custom_loader.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../screens/drawer/forms/company_employee_details.dart';
import '../constants.dart';
import 'data_provilder.dart';
import 'package:http/http.dart' as http;

class EmployeeApis extends ChangeNotifier{

  Future<bool> getEmployeeById(BuildContext context, String token,String? id) async{
    bool check=false;
    Get.dialog(CustomLoader());
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(BASE_URL+"list-users?company_id=$id");
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      var response = await http.get(url,headers: header);
      if(response.statusCode == 200){
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        GetEmployeeByIdModel model=GetEmployeeByIdModel.fromJson(apiResponse);
        dataProvider.getEmployeeByIdModel=model;
        dataProvider.companyEmployeeDropDownModel=[];
        model.data.forEach((element) {
          dataProvider.companyEmployeeDropDownModel.add(DropDownValueModel(name: '${element.firstName}', value: '${element.id}'));
        });
        print(dataProvider.companyEmployeeDropDownModel);
        Get.back();

        check= true;
      }
      return check;
    }catch(e){
      Get.back();
      print("error from getEmployeeById is: $e");
      return check;
    }
  }
  Future createEmployee(BuildContext context, String token, String companyId, String locationId) async{
    Get.dialog(CustomLoader());
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(BASE_URL+"create-user");
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      Map data = {
        "mobile": dataProvider.postEmployeeModel.mobile,
        "fax": dataProvider.postEmployeeModel.fax,
        "position": dataProvider.postEmployeeModel.position,
        "department": dataProvider.postEmployeeModel.department,
        "first_name": dataProvider.postEmployeeModel.firstName,
        "last_name": dataProvider.postEmployeeModel.lastName,
        "mail": dataProvider.postEmployeeModel.email,
        "password": dataProvider.postEmployeeModel.password,
        "location_id": locationId,
        "types": [
          "customer"
        ],
        "company_id": companyId
      };

      var body=jsonEncode(data);

      var response = await http.post(url,body: body,headers: header);
      if(response.statusCode == 200){
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        PostEmployeeModel model=PostEmployeeModel.fromJson(apiResponse);
        await getEmployeeById(context, dataProvider.loginModel!.token!, model.companyId!);
        dataProvider.setSelectedValueForLocation(null);
          Get.back();
          Get.back();
      }
    }catch(e){
      Get.back();
      print("error from getLocationById is: $e");
    }
  }

  Future updateEmployee(BuildContext context, String id,String token, String locationId, String companyId) async{
    Get.dialog(CustomLoader());
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(BASE_URL+"update-user");
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      Map data = {
        "id":id,
        "mobile": dataProvider.postEmployeeModel.mobile,
        "fax": dataProvider.postEmployeeModel.fax,
        "position": dataProvider.postEmployeeModel.position,
        "department": dataProvider.postEmployeeModel.department,
        "first_name": dataProvider.postEmployeeModel.firstName,
        "last_name": dataProvider.postEmployeeModel.lastName,
        "mail": dataProvider.postEmployeeModel.email,
        "password": dataProvider.postEmployeeModel.password,
        "location_id": locationId,
        "types": [
          "customer"
        ],
        "company_id": companyId
      };

      var body=jsonEncode(data);

      var response = await http.put(url,body: body,headers: header);
      if(response.statusCode == 200){
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        PostEmployeeModel model=PostEmployeeModel.fromJson(apiResponse);
        getEmployeeById(context, dataProvider.loginModel!.token!, model.companyId!);
        Get.back();
        Get.back();
        dataProvider.showSnackbar(context, "Recorde updated", kOrangeColor);
      }else{
        Get.back();
      }
    }catch(e){
      Get.back();
      print("error from updateEmployee is: $e");
    }
  }
  Future deleteEmployee(BuildContext context, String id,String token,) async{
    Get.dialog(CustomLoader());
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(BASE_URL+"delete-user");
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      Map data = {
        "id":id,
      };

      var body=jsonEncode(data);

      var response = await http.post(url,body: body,headers: header);
      if(response.statusCode == 200){
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        if(apiResponse["msg"]=="Success"){
          await getEmployeeById(context, dataProvider.loginModel!.token!, dataProvider.companyId!);
          Get.back();
          Get.back();
          dataProvider.showSnackbar(context, "Record Deleted", kOrangeColor);
        }

      }else{
        Get.back();
      }
    }catch(e){
      Get.back();
      print("error from deleteEmployee is: $e");
    }
  }


}