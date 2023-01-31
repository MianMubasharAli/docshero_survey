import 'dart:convert';

import 'package:docshero/components/constants.dart';
import 'package:docshero/components/models/docshero_models/category_model.dart';
import 'package:docshero/components/models/docshero_models/docshero_all_employees_model.dart';
import 'package:docshero/components/models/login_models/user_model.dart';
import 'package:docshero/components/providers/api_data_provider.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../models/login_models/login_model.dart';
import '../reuseable_widgets/custom_loader.dart';
import '../utils/shared_preferences.dart';
import 'data_provilder.dart';


class DocsheroApisProvider extends ChangeNotifier{
  Future getDocsheroAllEmployees(BuildContext context, String token) async{
    bool check=false;
    Get.dialog(CustomLoader());
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(BASE_URL+"list-users");
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
        DocsheroAllEmployeesModel model=DocsheroAllEmployeesModel.fromJson(apiResponse);
        dataProvider.docsheroAllEmployeesModel=model;
        Get.back();
      }
      return check;
    }catch(e){
      Get.back();
      print("error from getDocsheroAllEmployees is: $e");
      return check;
    }
  }
  Future getDocsheroCategoris(BuildContext context, String token) async{
    bool check=false;
    Get.dialog(CustomLoader());
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"report-category?per_page=0&page=1");
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
        CategoryModel model=CategoryModel.fromJson(apiResponse);
        dataProvider.categoryModel=model;
        dataProvider.docsHeroCategoryDropdownModel=[];
        model.data?.forEach((element) {
          dataProvider.docsHeroCategoryDropdownModel.add(DropDownValueModel(name: '${element.name}', value: '${element.id}'));
        });
        Get.back();
      }
      return check;
    }catch(e){
      Get.back();
      print("error from getDocsheroCategoris is: $e");
      return check;
    }
  }

  Future<bool> updateUserProfile(BuildContext context, String token) async{
    bool check=false;
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
        "id": "${dataProvider.userModel?.id}",
        "email": "${dataProvider.userModel?.email}",
        "first_name": "${dataProvider.userModel?.firstName}",
        "last_name": "${dataProvider.userModel?.lastName}",
        "city": "${dataProvider.userModel?.city}",
        "zip": "${dataProvider.userModel?.zip}",
        "street": "${dataProvider.userModel?.street}",
        "street_number": "${dataProvider.userModel?.streetNumber}",
        "mobile": "${dataProvider.userModel?.mobile}",
        "fax": "${dataProvider.userModel?.fax ?? ""}",
        "department": "${dataProvider.userModel?.id ?? ""}",
        "position": "${dataProvider.userModel?.position ?? ""}",
        "location_id": "${dataProvider.userModel?.locationId ?? ""}",
        "company_id": "${dataProvider.userModel?.id ?? ""}",
        "roles": dataProvider.userModel?.roles,
        "creation_date": null,
        "types": dataProvider.userModel?.types
      };

      var body=jsonEncode(data);

      var response = await http.post(url,body: body,headers: header);

      if(response.statusCode == 200){
        await SharedPreferencesData.saveUserData(response.body);
        check=true;
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        UserModel user=UserModel.fromJson(apiResponse);
        await dataProvider.setUserModel(user);
        // await Provider.of<ApiDataProvider>(context,listen: false).getUserData(context, user.tokenInfo!.userId!,user.token!);
        Get.back();
        dataProvider.showSnackbar(context, "Profile Updated", kOrangeColor);
      }
      return check;
    }catch(e){
      Get.back();
      print("error from updateUserProfile is: $e");
      return check;
    }
  }


}