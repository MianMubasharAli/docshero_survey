import 'dart:convert';

import 'package:docshero/components/constants.dart';
import 'package:docshero/components/reuseable_widgets/custom_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../models/companies_models/location_by_id.dart';
import 'data_provilder.dart';
import 'package:http/http.dart' as http;

class LocationApis extends ChangeNotifier{


  Future getLocationById(BuildContext context, String token,String id) async{
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"company-locations/company/$id");
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      var response = await http.get(url,headers: header);
      if(response.statusCode == 200){
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        LocationByIdModel model=LocationByIdModel.fromJson(apiResponse);
        dataProvider.locationByIdModel=model;
       await dataProvider.setDefaultLocationId(model.locations?.first?.id);

      }
    }catch(e){
      print("error from getLocationById is: $e");
    }
  }

  Future createLocation(BuildContext context, String token) async{
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"company-locations");
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      Map data = {
        // "id": "abc123",
        "addressFirst": dataProvider.locationData.addess1,
        "addressSecond": dataProvider.locationData.address2,
        "city": dataProvider.locationData.city,
        "country": dataProvider.locationData.country,
        "state": dataProvider.locationData.state,
        "zip": dataProvider.locationData.zip,
        "isHeadQuarters": true,
        "companyId": dataProvider.companyId
      };

      var body=jsonEncode(data);

      var response = await http.post(url,body: body,headers: header);
      if(response.statusCode == 200){
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        if(apiResponse['success'] ==  true){
          await getLocationById(context, token, dataProvider.companyId!);
          Get.back();
          dataProvider.showSnackbar(context, "${apiResponse['message']}", kOrangeColor);
        }

      }
    }catch(e){
      print("error from getLocationById is: $e");
    }
  }

  Future updateLocation(BuildContext context, String token, String id,int index ) async{
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"company-locations/$id");
    Get.dialog(CustomLoader());
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      Map data = {
        "id": "abc123",
        "addressFirst": dataProvider.locationData.addess1,
        "addressSecond": dataProvider.locationData.address2,
        "city": dataProvider.locationData.city,
        "country": dataProvider.locationData.country,
        "state": dataProvider.locationData.state,
        "zip": dataProvider.locationData.zip,
        "isHeadQuarters": true,
        "companyId": dataProvider.companyId
      };

      var body=jsonEncode(data);

      var response = await http.put(url,body: body,headers: header);
      if(response.statusCode == 200){
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        if(apiResponse['success'] ==  true){
          await getLocationById(context, token, dataProvider.companyId!);
          Get.back();
          Get.back();
          dataProvider.showSnackbar(context, "${apiResponse['message']}", kOrangeColor);
        }
      }else{
        Get.back();
        Get.back();
        dataProvider.showSnackbar(context, "Something went wrong",kRedColor);
      }
    }catch(e){
      Get.back();
      print("error from getLocationById is: $e");
    }
  }

  Future deleteLocation(BuildContext context, String token, String id) async{
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"company-locations/$id");
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
        if(apiResponse['success'] ==  true){
          await getLocationById(context, token, dataProvider.companyId!);
          Get.back();
          dataProvider.showSnackbar(context, "${apiResponse['message']}", kOrangeColor);
        }
      }else{
        Get.back();
        dataProvider.showSnackbar(context, "Something went wrong",kRedColor);
      }
    }catch(e){
      Get.back();
      print("error from getLocationById is: $e");
    }
  }
}