import 'dart:convert';

import 'package:docshero/components/models/contact_report_models/get_contact_report_model.dart';
import 'package:docshero/components/models/contact_report_models/single_contact_report_model.dart';
import 'package:docshero/screens/drawer/contact_report/contact_report_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../reuseable_widgets/custom_loader.dart';
import 'data_provilder.dart';

class ContactReportApis extends ChangeNotifier{

  Future getContactReports(BuildContext context, String token) async{
    Get.dialog(CustomLoader());
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"contact-reports");
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      var response = await http.get(url,headers: header);
      if(response.statusCode == 200){
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        GetContactReportModel model=GetContactReportModel.fromJson(apiResponse);
        dataProvider.getContactReportModel=model;
        Get.back();
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ContactReportHome()));
      }

    }catch(e){
      Get.back();
      print("error from getContactReports is: $e");
    }
  }
  Future getContactReportById(BuildContext context, String token,int id) async{
    bool check=false;
    Get.dialog(CustomLoader());
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"contact-reports/$id");
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
        SingleContactReportModel model=SingleContactReportModel.fromJson(apiResponse);
        dataProvider.singleContactReportModel=model;
        Get.back();
      }
      return check;
    }catch(e){
      Get.back();
      print("error from getContactReports is: $e");
      return check;
    }
  }

  Future<bool> createContactReport(BuildContext context, String token) async{
    bool check=false;
    Get.dialog(CustomLoader());
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse("http://admin.docshero.de/api/contact-reports");
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      List companyEmployees=[];
      List employees=[];
      dataProvider.contactReportTalkToPeople.forEach((element) {
        companyEmployees.add(element.value);
      });
      dataProvider.contactReportEmployee.forEach((element) {
        employees.add(element.value);
      });

      Map data={
        // "subject": "Hey",
        // "text": "{\"ops\":[{\"insert\":\"cool\"}]}",
        // "type": "customer",
        // "priority": "low",
        // "categoryId": 1,
        // "contactType": "mail",
        // "initiatedBy": "customer",
        "subject": "${dataProvider.contactReportSubjectText}",
        "text": "${dataProvider.contactReportQuillText}",
        "type": "${dataProvider.contactReportType}",
        "priority": "${dataProvider.contactReportPriority}",
        "categoryId": int.parse(dataProvider.contactReportCategory?.value),
        "contactType": "${dataProvider.contactReportContactType}",
        "initiatedBy": "${dataProvider.contactReportInitiatedBy}",
        "companyId": "${dataProvider.contactReportCompany?.value}",
        "createdByEmployee": "${dataProvider.contactReportCreatedBy?.value}",
        "companyEmployees": companyEmployees,
        "employees": employees
      };

      var body=jsonEncode(data);
      var response = await http.post(url,body: body,headers: header);
      if(response.statusCode == 200){
        check=true;
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        await getContactReports(context, token);
        Get.back();
        Get.back();
        dataProvider.showSnackbar(context, "${apiResponse['message']}", kOrangeColor);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ContactReportHome()));
      }else{
        Get.back();
        dataProvider.showSnackbar(context, "Something went wrong", kRedColor);
      }
      return check;
    }catch(e){
      Get.back();
      print("error from createContactReport is: $e");
      return check;
    }
  }

  Future<bool> updateContactReport(BuildContext context, String token, int id) async{
    bool check=false;
    Get.dialog(CustomLoader());
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"contact-reports/$id");
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      Map data={
        "subject": "${dataProvider.contactReportinitialValueSubjectText}",
        "text": "${dataProvider.contactReportinitialValueQuillText}",
        "type": "${dataProvider.singleContactReportModel!.modelData!.type}",
        "priority": "${dataProvider.contactReportinitialValuePriority?.toLowerCase()}",
        "categoryId": int.parse(dataProvider.singleContactReportModel!.modelData!.categoryId.toString()),
        "contactType": "${dataProvider.contactReportinitialValueContactType?.toLowerCase()}",
        "initiatedBy": "${dataProvider.contactReportinitialValueInitiatedBy?.toLowerCase()}",
        "companyId": "${dataProvider.singleContactReportModel!.modelData!.companyId}",
        "createdByEmployee": "${dataProvider.singleContactReportModel!.modelData!.createdByEmployee}",
        "companyEmployees": dataProvider.singleContactReportModel!.modelData!.companyEmployees,
        "employees": dataProvider.singleContactReportModel!.modelData!.employees
      };

      var body=jsonEncode(data);
      var response = await http.put(url,body: body,headers: header);
      if(response.statusCode == 200){
        check=true;
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        await getContactReports(context, token);
        Get.back();
        Get.back();
        dataProvider.showSnackbar(context, "${apiResponse['message']}", kOrangeColor);
        Navigator.pop(context);
      }else{
        Get.back();
        dataProvider.showSnackbar(context, "Something went wrong", kRedColor);
      }
      return check;
    }catch(e){
      Get.back();
      print("error from createContactReport is: $e");
      return check;
    }
  }

  Future deleteContactReport(BuildContext context, String token, int id) async{
    Get.dialog(CustomLoader());
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    Uri url=Uri.parse(DOCSHERO_BASE_URL+"contact-reports/$id");
    try{
      var header = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

      var response = await http.delete(url,headers: header);
      if(response.statusCode == 200){
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        await getContactReports(context, token);
        await Provider.of<ContactReportApis>(context,listen:false).clearFormValues(context);
        dataProvider.showSnackbar(context, "${apiResponse["message"]}", kOrangeColor);
        Get.back();
        Get.back();
      }

    }catch(e){
      Get.back();
      print("error from deleteContactReport is: $e");
    }
  }

  clearFormValues(BuildContext context){
    DataProvider dataProvider = Provider.of<DataProvider>(context,listen:false);
    dataProvider.companyEmployeeDropDownModel=[];
    dataProvider.docsHeroAllEmployeesDropdownModel=[];
    dataProvider.allCompanyDropDownModel=[];
    dataProvider.docsHeroCategoryDropdownModel=[];
    dataProvider.contactReportCompanyEmplyee=[];

    dataProvider.setContactReportCompany(null);
    dataProvider.setContactReportPriority(null);
    dataProvider.setContactReportType(null);
    dataProvider.setContactReportInitiatedBy(null);
    dataProvider.setContactReportContactType(null);
    dataProvider.setContactReportCategory(null);
    dataProvider.setContactReportCreatedBy(null);
    dataProvider.setContactReportEmployee([]);
    dataProvider.setContactReportTalkToPeople([]);

    //initial Values
    dataProvider.setContactReportinitialValueSubjectText(null);
    dataProvider.setContactReportinitialValueQuillText(null);
    dataProvider.setContactReportinitialValueType(null);
    dataProvider.setContactReportinitialValueCompany(null);
    dataProvider.setContactReportinitialValueTalkedToPeople([]);
    dataProvider.setContactReportinitialValueEmployee([]);
    dataProvider.setContactReportinitialValueCreatedBy(null);
    dataProvider.setContactReportinitialValuePriority(null);
    dataProvider.setContactReportinitialValueCategory(null);
    dataProvider.setContactReportinitialValueContactType(null);
    dataProvider.setContactReportinitialValueInitiatedBy(null);

  }

}