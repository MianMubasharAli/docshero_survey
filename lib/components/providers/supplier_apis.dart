import 'dart:convert';

import 'package:docshero/components/models/suppliers_models/get_all_suppliers_model.dart';
import 'package:docshero/components/models/suppliers_models/terms_of_payment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../reuseable_widgets/custom_loader.dart';
import 'data_provilder.dart';
import 'package:http/http.dart' as http;

class SupplierApis extends ChangeNotifier{

  Future<bool> getAllSuppliers(BuildContext context, String token) async{
    bool check=false;
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"suppliers");
    // Get.dialog(CustomLoader());
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
        GetAllSuppliersModel model=GetAllSuppliersModel.fromJson(apiResponse);
        dataProvider.getAllSuppliersModel=model;
        // Get.back();
      }else{
        // Get.back();
      }
      return check;
    }catch(e){
      // Get.back();
      print("error from getAllSuppliers is: $e");
      return check;
    }
  }
  Future<bool> termsOfPaymentSupplier(BuildContext context, String token) async{
    bool check=false;
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"terms-of-payment");
    // Get.dialog(CustomLoader());
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
        TermsOfPaymentModel model=TermsOfPaymentModel.fromJson(apiResponse);
        dataProvider.termsOfPaymentModel=model;
        // Get.back();
      }else{
        // Get.back();
      }
      return check;
    }catch(e){
      // Get.back();
      print("error from termsOfPaymentSupplier is: $e");
      return check;
    }
  }
  Future<bool> createSupplier(BuildContext context, String token) async{
    bool check=false;
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"suppliers");
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    // LocationApis locationApiProvider = Provider.of<LocationApis>(context,listen:false);
    // Get.dialog(CustomLoader());
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      Map data = {
        "supplierName": "${dataProvider.supplierInputDataModel.supplierName}",
        "supplierNumber": "0",
        "vatId": "${dataProvider.supplierInputDataModel.vatId}",
        "url": "${dataProvider.supplierInputDataModel.url}",
        "fax": "${dataProvider.supplierInputDataModel.fax}",
        "type": "${dataProvider.supplierInputDataModel.type}",
        "phone": "+${dataProvider.supplierInputDataModel.phone}",
        "supplierType": "${dataProvider.supplierInputDataModel.supplierType}",
        "termsOfPayment": dataProvider.supplierInputDataModel.termsOfPayment,
        "addressFirst": "${dataProvider.supplierInputDataModel.addressFirst}",
        "addressSecond": "${dataProvider.supplierInputDataModel.addressSecond}",
        "city": "${dataProvider.supplierInputDataModel.city}",
        "zip": "${dataProvider.supplierInputDataModel.zip}",
        "state": "${dataProvider.supplierInputDataModel.state}",
        "country": "${dataProvider.supplierInputDataModel.country}"
      };

      var body=jsonEncode(data);

      var response = await http.post(url, headers: header,body: body);
      if(response.statusCode == 200){
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        if(apiResponse["success"]==true){
          // Get.back();
          check=true;
          await getAllSuppliers(context,token);
          dataProvider.showSnackbar(context, "${apiResponse['message']}", kOrangeColor);
        }
      }else{
        // Get.back();

      }
      return check;
    }catch(e){
      // Get.back();
      print("Error from createSupplier is: $e");
      dataProvider.showSnackbar(context, "something went wrong in createSupplier", kOrangeColor);
      return check;
    }
  }

}

