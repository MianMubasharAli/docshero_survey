import 'dart:convert';

import 'package:docshero/components/constants.dart';
import 'package:docshero/components/models/docshero_models/category_model.dart';
import 'package:docshero/components/models/docshero_models/docshero_all_employees_model.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../reuseable_widgets/custom_loader.dart';
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
}