import 'dart:convert';

import 'package:dart_eval/dart_eval.dart';
import 'package:docshero/components/models/companies_models/all_companies_model.dart';
import 'package:docshero/components/models/companies_models/company_form_model.dart';
import 'package:docshero/components/models/companies_models/get_employee_by_id_model.dart';
import 'package:docshero/components/models/companies_models/location_by_id.dart';
import 'package:docshero/components/models/contact_report_models/get_contact_report_model.dart';
import 'package:docshero/components/models/contact_report_models/single_contact_report_model.dart';
import 'package:docshero/components/models/docshero_models/category_model.dart';
import 'package:docshero/components/models/login_models/login_model.dart';
import 'package:docshero/components/models/login_models/user_model.dart';
import 'package:docshero/components/models/option2.dart';
import 'package:docshero/components/models/suppliers_models/get_all_suppliers_model.dart';
import 'package:docshero/components/models/suppliers_models/supplier_input_data_model.dart';
import 'package:docshero/components/models/value_element2_model.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../models/companies_models/post_employee_model.dart';
import '../models/companies_models/single_company_data_model.dart';
import '../models/conditions_for_product_selection.dart';
import '../models/configuration2_model.dart';
import '../models/docshero_models/docshero_all_employees_model.dart';
import '../models/option_product2_model.dart';

import '../models/question_model.dart';
import '../models/suppliers_models/terms_of_payment_model.dart';
import '../models/survey_model2.dart';



class DataProvider extends ChangeNotifier{
Welcome2? surveyModel;
int _questionsIndex=0;
int _chaptersQuestionIndex=0;
int? _selectedOptionsIndex;
bool _questionCheck=false;
String? _checkValue;
bool _checkForMultiType=false;
List<int> questionCheckedItems=[];
List<OptionProduct2> productList=[];
bool _checkForDialog=false;


// Suppliers models
  GetAllSuppliersModel? getAllSuppliersModel;
  TermsOfPaymentModel? termsOfPaymentModel;
  SupplierInputDataModel supplierInputDataModel=SupplierInputDataModel();

//ContactReport models
  GetContactReportModel? getContactReportModel;
  SingleContactReportModel? singleContactReportModel;
  DocsheroAllEmployeesModel? docsheroAllEmployeesModel;
  CategoryModel? categoryModel;

  List<DropDownValueModel> docsHeroCategoryDropdownModel=[];
  List<DropDownValueModel> docsHeroAllEmployeesDropdownModel=[];
  List<DropDownValueModel> contactReportCompanyEmplyee=[];
  List<DropDownValueModel> companyEmployeeDropDownModel=[];
  List<DropDownValueModel> allCompanyDropDownModel=[];

  DropDownValueModel? _contactReportCompany;
  DropDownValueModel? _contactReportCategory;
  List<DropDownValueModel> _contactReportTalkToPeople=[];
  List<DropDownValueModel> _contactReportEmployee=[];
  DropDownValueModel? _contactReportCreatedBy;
  String? _contactReportContactType;
  String? _contactReportInitiatedBy;
  String? _contactReporttype;
  String? _contactReportPriority;
  String? _quillText;
  String? _contactReportSubjectText;

  String? _contactReportinitialValueSubjectText;
  String? _contactReportinitialValueQuillText;
  String? _contactReportinitialValueType;
  String? _contactReportinitialValueCompany;
  List<String> _contactReportinitialValueTalkedToPeople=[];
  List<String> _contactReportinitialValueEmployee=[];
  String? _contactReportinitialValueCreatedBy;
  String? _contactReportinitialValuePriority;
  String? _contactReportinitialValueCategory;
  String? _contactReportinitialValueContactType;
  String? _contactReportinitialValueInitiatedBy;






//single company model
  SingleCompanyDataModel? singleCompanyDataModel;

  // Employee models
  GetEmployeeByIdModel? getEmployeeByIdModel;


//Post Employee output model for form use
  PostEmployeeModel postEmployeeModel=PostEmployeeModel(
      id: null,
      email: null,
      firstName: null,
      lastName: null,
      mobile: null,
      fax: null,
      department: null,
      position: null,
      locationId: null,
      companyId: null,
      roles: null,
      types: null);
  Location? _selectedValueForLocation;

//create company form
String? _name;
String? _type;
String? _customerType;
String? _url;
String? _addess1;
String? _address2;
String? _city;
String? _zip;
String? _country;
String? _state;
String? _vatId;
String? _phone;
int? _fax;
String? _termsOfPayment;

bool? _cameBack;

//Create Company Form Output
String? _companyId;

//location data
CompanyFormModel locationData=CompanyFormModel(addess1: "",address2: "",city: "",state: "",country: "",zip: "");
LocationByIdModel? locationByIdModel;
String? _defaultLocationId;



UserModel? _userModel;
AllCompaniesModel? _allCompaniesModel;
LoginModel? _loginModel;


//ContactReport models
  setContactReportCompany(DropDownValueModel? p){
    _contactReportCompany=p;
    notifyListeners();
  }
  setContactReportCategory(DropDownValueModel? p){
    _contactReportCategory=p;
    notifyListeners();
  }
  setContactReportTalkToPeople(List<DropDownValueModel> p){
    _contactReportTalkToPeople=p;
    notifyListeners();
  }
  setContactReportEmployee(List<DropDownValueModel> p){
    _contactReportEmployee=p;
    notifyListeners();
  }
  setContactReportCreatedBy(DropDownValueModel? p){
    _contactReportCreatedBy=p;
    notifyListeners();
  }
  setContactReportContactType(String? s){
    _contactReportContactType=s;
    notifyListeners();
  }
  setContactReportInitiatedBy(String? s){
    _contactReportInitiatedBy=s;
    notifyListeners();
  }
  setContactReportType(String? s){
    _contactReporttype=s;
    notifyListeners();
  }
  setContactReportPriority(String? s){
    _contactReportPriority=s;
    notifyListeners();
  }
  setContactReportQuillText(String? s){
    _quillText=s;
    notifyListeners();
  }
  setContactReportSubjectText(String? s){
    _contactReportSubjectText=s;
    notifyListeners();
  }

  setContactReportinitialValueSubjectText(String? abc){
    _contactReportinitialValueSubjectText=abc;
    notifyListeners();
  }
  setContactReportinitialValueQuillText(String? abc){
    _contactReportinitialValueQuillText=abc;
    notifyListeners();
  }
  setContactReportinitialValueType(String? abc){
    _contactReportinitialValueType=abc;
    notifyListeners();
  }
  setContactReportinitialValueCompany(String? abc){
    _contactReportinitialValueCompany=abc;
    notifyListeners();
  }
  setContactReportinitialValueTalkedToPeople(List<String> abc){
    _contactReportinitialValueTalkedToPeople=abc;
    notifyListeners();
  }
  setContactReportinitialValueEmployee(List<String> abc){
    _contactReportinitialValueEmployee=abc;
    notifyListeners();
  }
  setContactReportinitialValueCreatedBy(String? abc){
    _contactReportinitialValueCreatedBy=abc;
    notifyListeners();
  }
  setContactReportinitialValuePriority(String? abc){
    _contactReportinitialValuePriority=abc;
    notifyListeners();
  }
  setContactReportinitialValueCategory(String? abc){
    _contactReportinitialValueCategory=abc;
    notifyListeners();
  }
  setContactReportinitialValueContactType(String? abc){
    _contactReportinitialValueContactType=abc;
    notifyListeners();
  }
  setContactReportinitialValueInitiatedBy(String? abc){
    _contactReportinitialValueInitiatedBy=abc;
    notifyListeners();
  }

//Post Employee output model for form use
  setSelectedValueForLocation(Location? vaue){
    _selectedValueForLocation=vaue;
    notifyListeners();
  }
//Create Company Form Output
  setComapnyId(String? id){
    _companyId=id;
  }


  //Location data
  setDefaultLocationId(String? id){
    _defaultLocationId=id;
    notifyListeners();
  }


setCameBackCheck(bool back){
    _cameBack=back;
    notifyListeners();
}
setLoginModel(LoginModel model){
  _loginModel=model;
}
setAllCommpaniesModel(AllCompaniesModel model){
  _allCompaniesModel=model;
}
setUserModel(UserModel model){
  _userModel=model;
}
setCheckForMultiType(bool check){
  _checkForMultiType=check;
  notifyListeners();
}
setCheckValue(var s){
  _checkValue=s.toString();
  notifyListeners();
}
setselectedOptionsIndex(int i){
  _selectedOptionsIndex=i;
  notifyListeners();
}
setQuestionIndex(int i){
  _questionsIndex=i;
  notifyListeners();
}
setChaptersquestionIndex(int i){
  _chaptersQuestionIndex=i;
  notifyListeners();
}
setQuestionCheck(bool i){
  _questionCheck=i;
  notifyListeners();
}

//create company form
  setName(String? name){
  _name=name;
  }
  setType(String? name){
    _type=name;
  }
  setCustomerType(String? name){
    _customerType=name;
  }
  setUrl(String? name){
    _url=name;
  }
  setAddess1(String? name){
    _addess1=name;
  }
  setAddress2(String? name){
    _address2=name;
  }
  setCity(String? name){
    _city=name;
  }
  setZip(String? name){
    _zip=name;
  }
  setCountry(String? name){
    _country=name;
  }
  setState(String? name){
    _state=name;
  }
  setVatId(String? name){
    _vatId=name;
  }
  setPhone(String? name){
    _phone=name;
  }
  setFax(int? name){
    _fax=name;
  }
  setTermsOfPayment(String? name){
    _termsOfPayment=name;
  }
  setCheckForDialog(bool c){
    _checkForDialog=c;
    notifyListeners();
  }


bool isJSON(str) {
  try {
    bool check=isInt(str);
    if(check==true){
      return false;
    }
    var a=jsonDecode(str);
  } catch (e) {
    return false;
  }
  return true;
}
bool isInt(str){
  try{
    int.parse(str.toString());
  }catch(e){
    return false;
  }
  return true;
}
bool checkForFormula(formula){
  bool res=isJSON(formula);
  if(res){
    return false;
  }
  try{
    return isInt(formula) ? false : true;
  }catch(e){
    return false;
  }
}

executeFormula(OptionProduct2 item, {var customValue=null}){
if(item.quantity == 0) return 1;
bool a=isInt(item.quantity);
if(a==true){
  return int.parse(item.quantity.toString());
}
if(checkForFormula(item.quantity)){
  RegExp regExp = new RegExp(
    r"(?<=\$).+?(?=\+|\*|\-|\/|\%|\^|\)|$)",
    caseSensitive: false,
    multiLine: false,
  );
  var quantity=item.quantity;
  final matches=regExp.allMatches(item.quantity.toString());

  matches.forEach((match) {
    // print(match.group(0));
    // print(item.quantity);
    Option2? foundOption;
    // if(surveyModel!.steps![questionsIndex].type == "question"){
      for(int i=0; i < questions.length ; i++){
        ValueElement2? question = questions[i];

        foundOption = question?.configuration?.options?.firstWhereOrNull((op) {
         return op.uuid == match.group(0).toString();
        });
        if(foundOption != null){
          break;
        }
      }
    quantity = quantity.replaceAll(
        "\$${match.group(0)}",
        "\$${foundOption?.title?.toLowerCase()}"
    );
      if(customValue != null){
        quantity = quantity.replaceAll(
          "\$${foundOption?.title?.toLowerCase()}",
          "$customValue"
        );
      }else{
        quantity = quantity.replaceAll(
            "\$${foundOption?.title?.toLowerCase()}",
            foundOption?.value.toString()
        );
      }

    // }
    // if(surveyModel!.steps![questionsIndex].type == "question"){
    //   foundOption=surveyModel!.steps![questionsIndex].value!.configuration!.options!.firstWhereOrNull((option) {
    //     return option.title?.toLowerCase() == match.group(1).toString().toLowerCase();
    //   });
    //   if(foundOption != null){
    //     quantity = quantity.replaceAll(
    //         "\$${match.group(1)}",
    //         foundOption.value.toString()
    //     );
    //     print(quantity);
    //   }
    // }
  });
  try{

    Expression expression= Expression(quantity.substring(1));
    quantity=int.parse(expression.eval().toString());
  }catch(e){
    quantity = 1;
  }

  return quantity;
}else{
   return item.quantity;
}
}
result(quantity, {var customValue=null}){
var numberInputs=jsonDecode(quantity);
int result=0;
numberInputs.forEach((input) {
  if(input['operator'] != null){
    String condition="$result ${input["operator"]} ${calculateResult(input,customValue: customValue)}";
    // Expression exp = Expression(condition);
    String abc=eval(condition).toString();
    result=int.parse(abc);
  }else{
    result= calculateResult(input,customValue: customValue);
  }
});
return result;
}

calculateResult(numberInput, {var customValue=null}){

  int result = 0;
  List numberInputList=numberInput["parenthesis"];
  if(numberInputList.length == 0){
    Option2? foundOption;
    for(int i=0; i < questions.length ; i++){
      ValueElement2? question=questions[i];
      foundOption=question?.configuration?.options?.firstWhereOrNull((op){
        return op.uuid == numberInput["id"];
      });

      if(foundOption != null){
        break;
      }
    }
    if(customValue != null){
      result = double.parse(customValue.toString()).round() ?? int.parse(double.parse(numberInput["value"].toString()).round().toString());
    }else{
      result = foundOption?.value.round() ?? int.parse(numberInput["value"].toString());
    }
    // if(surveyModel!.steps![questionsIndex].type == "question"){
    //   option = (surveyModel!.steps![questionsIndex].value!.configuration!.options ?? []
    //   ).firstWhereOrNull((option) => option.id == numberInput["id"]);
    // }else{
    //   option = (surveyModel!.steps![questionsIndex].value!.questions![chaptersQuestionsIndex].configuration!.options ?? []
    //   ).firstWhereOrNull((option) => option.id == numberInput["id"]);
    // }
  }else{
    Option2? foundOption;
    for(int i=0; i < questions.length ; i++){
      ValueElement2? question=questions[i];
      foundOption=question?.configuration?.options?.firstWhereOrNull((op){
        return op.uuid == numberInput["id"];
      });

      if(foundOption != null){
        break;
      }
    }
    // if(surveyModel!.steps![questionsIndex].type == "question"){
    //   option = (surveyModel!.steps![questionsIndex].value!.configuration!.options ?? []
    //   ).firstWhereOrNull((option) => option.id == numberInput["id"]);
    // }else{
    //   option = (surveyModel!.steps![questionsIndex].value!.questions![chaptersQuestionsIndex].configuration!.options ?? []
    //   ).firstWhereOrNull((option) => option.id == numberInput["id"]);
    // }

    result= int.parse(foundOption?.value.toString() ?? numberInput["value"].toString());
    numberInputList.forEach((input){
      String condition="$result ${input["operator"]} ${calculateResult(input, customValue: customValue)}";
      // Expression exp = Expression(condition);
      String abc=eval(condition).toString();
      result=int.parse(abc);
    });
  }
  return result;
}

Map<String, dynamic> previousValueMap={};
List<ValueElement2?> questions=[];
Map selectedInputs={};
//function
  //for number type
  optionSelected(DataProvider ppp, Configuration2 selectedQuestion, int index){
    DataProvider provider=Provider.of<DataProvider>(Get.context!,listen: false);

    Option2 option=selectedQuestion.options![index];

    List<OptionProduct2> selectedProducts = [...?option.products];
    if((option.value == "" ? 0 : option.value) > 0){
      // if(surveyModel!.steps![provider.questionsIndex].type == "question"){
      //   surveyModel!.steps![provider.questionsIndex].value!.next=option.next;
      // }else{
      //   surveyModel!.steps![provider.questionsIndex].value?.questions?[chaptersQuestionsIndex].next=option.next;
      // }
      String? selectedQuestionId=surveyModel!.steps![provider.questionsIndex].type == "question"
          ? surveyModel!.steps![provider.questionsIndex].value?.id.toString()
          : surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].id.toString();
      // if(selectedInputs['$selectedQuestionId'] != null){
      //   var json=jsonEncode(option);
      //   Map<String, dynamic> decodedString=jsonDecode(json) as Map<String, dynamic>;
      //   Option2 optionForSelectedInput=Option2.fromJson(decodedString);
      //   selectedInputs[selectedQuestionId][
      //     "options"
      //   ][option.id] = optionForSelectedInput;
      //   selectedInputs[selectedQuestionId]["options"].value=selectedQuestion.options?[index].value;
      // }else{
      //   selectedInputs[selectedQuestionId]={
      //     "options":{},
      //     "conditions":{}
      //   };
      //   var json=jsonEncode(option);
      //   Map<String, dynamic> decodedString=jsonDecode(json) as Map<String, dynamic>;
      //   Option2 optionForSelectedInput=Option2.fromJson(decodedString);
      //   selectedInputs[selectedQuestionId]['options'][option.id]=optionForSelectedInput;
      //   selectedInputs[selectedQuestionId]["options"].value=selectedQuestion.options?[index].value;
      // }

      selectedProducts.forEach((product) {
        var parsedQuantity=provider.checkForFormula(product.quantity)
            ? provider.executeFormula(product)
            : provider.isJSON(product.quantity)
            ? provider.result(product.quantity)
            : int.parse(product.quantity.toString());
        if(provider.productList.any((cp) => cp.id == product.id)){
          int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
            return selectedProduct.id== product.id;
          });

          var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
          Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
          OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);

          foundProduct.quantity = parsedQuantity;
          int quantity=0;
          foundProduct.belongsTo?.forEach((optionId) {
            if(optionId != option.uuid){

              // Option2? foundOption = selectedQuestion.options!.firstWhereOrNull((op) {
              //   return op.id == optionId;
              // });

              Option2? foundOption;
              ConditionsForProductSelection? foundOption2;
              for(int i=0; i < questions.length ; i++){
                ValueElement2? question=questions[i];
                foundOption=question?.configuration?.options?.firstWhereOrNull((op) {
                  return op.uuid == optionId;
                });

                if(foundOption != null){
                  break;
                }

                if(foundOption == null){

                  foundOption2=question?.configuration?.conditionsForProductSelection?.firstWhereOrNull((cond) {
                    return cond.id == optionId;
                  });
                  if(foundOption2 != null){
                    break;
                  }
                }

              }



              OptionProduct2? foundProductOther2;
              if(foundOption != null){
                foundProductOther2 = foundOption.products?.firstWhereOrNull((pr){
                  return pr.id == product.id;
                });
              }else{
                if(foundOption2 != null){
                  foundProductOther2 = foundOption2.products?.firstWhereOrNull((pr){
                    return pr.id == product.id;
                  }) ;
                }
              }

              var encodedFoundProduct2=jsonEncode(foundProductOther2 ?? {});
              Map<String, dynamic> decodedFoundProduct2=jsonDecode(encodedFoundProduct2) as Map<String, dynamic>;
              OptionProduct2 foundProductOther=OptionProduct2.fromJson(decodedFoundProduct2);

              var parsedQuantityFoundProduct=provider.checkForFormula(foundProductOther.quantity)
                  ? provider.executeFormula(foundProductOther)
                  : provider.isJSON(foundProductOther.quantity)
                  ? provider.result(foundProductOther.quantity)
                  : int.parse(foundProductOther.quantity.toString());

              foundProduct.quantity = foundProduct.quantity + parsedQuantityFoundProduct;
              //quantity=foundProduct.quantity + parsedQuantityFoundProduct;
            }
          });

          if(!foundProduct.belongsTo!.contains(option.uuid)){
            var salePriceProduct=
            double.parse(product.salePrice.toString()) * int.parse(parsedQuantity.toString());
          foundProduct.salePrice = (double.parse(foundProduct.salePrice.toString()) + salePriceProduct).toString();
          }else{
            var salePriceProduct=
                double.parse(
                    product.salePrice.toString()) * int.parse(parsedQuantity.toString());
            foundProduct.salePrice = (double.parse(foundProduct.salePrice.toString()) + salePriceProduct).toString();

            var previousQuantity=provider.checkForFormula(product.quantity)
                ? provider.executeFormula(product,customValue: previousValueMap["${option.uuid}"] )
                : provider.isJSON(product.quantity)
                ? provider.result(product.quantity,customValue:previousValueMap["${option.uuid}"] )
                : int.parse(product.quantity.toString());

            var saleProceProductPrevious =
            double.parse(product.salePrice.toString()) * int.parse(previousQuantity.toString());
            foundProduct.salePrice = (
                double.parse(foundProduct.salePrice.toString()) -
                double.parse(saleProceProductPrevious.toString())
            ).toString();
          }
          // foundProduct.quantity=quantity;
          // foundProduct.salePrice = (foundProduct.quantity * double.parse(product.salePrice.toString())).toString();
          foundProduct.belongsTo?.add(option.uuid);

          List? belong=foundProduct.belongsTo;
          var unique=belong?.toSet().toList();
          foundProduct.belongsTo=[...?unique];

          var encodedFoundProduct3=jsonEncode(foundProduct);
          Map<String, dynamic> decodedFoundProduct3=jsonDecode(encodedFoundProduct3) as Map<String, dynamic>;
          OptionProduct2 foundProductOther3 = OptionProduct2.fromJson(decodedFoundProduct3);


          provider.productList[foundProductIndex] = foundProductOther3;

        }
        else{
          var encodedFoundProduct4=jsonEncode(product);
          Map<String, dynamic> decodedFoundProduct4=jsonDecode(encodedFoundProduct4) as Map<String, dynamic>;
          OptionProduct2 foundProductOther4=OptionProduct2.fromJson(decodedFoundProduct4);

          OptionProduct2 cartProduct= foundProductOther4;
          cartProduct.quantity= parsedQuantity;
          cartProduct.belongsTo?.add(option.uuid);
          cartProduct.salePrice= (parsedQuantity * int.parse(product.salePrice.toString())).toString();
          provider.productList.add(cartProduct);
        }
      });
    }
    else{

      selectedProducts.forEach((product) {
        // var parsedQuantity=provider.checkForFormula(product.quantity)
        //     ? provider.executeFormula(product)
        //     : provider.isJSON(product.quantity)
        //     ? provider.result(product.quantity)
        //     : int.parse(product.quantity.toString());
        int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
          return selectedProduct.id== product.id;
        });
        if(foundProductIndex == -1) return;
        var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
        Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
        OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);

        if(foundProduct.belongsTo!.contains(option.uuid)){
          var previousQuantity=provider.checkForFormula(product.quantity)
              ? provider.executeFormula(product,customValue: previousValueMap[option.uuid])
              : provider.isJSON(product.quantity)
              ? provider.result(product.quantity,customValue: previousValueMap[option.uuid])
              : int.parse(product.quantity.toString());
          var salePriceProductPrevious=
          int.parse(product.salePrice.toString()) * previousQuantity;
          foundProduct.quantity = foundProduct.quantity - previousQuantity;
          foundProduct.salePrice = (double.parse(foundProduct.salePrice.toString()) -
                                      salePriceProductPrevious).toString();
          foundProduct.belongsTo = foundProduct.belongsTo?.where((id) {
            return id != option.uuid;
          }).toList();
          if(foundProduct.belongsTo?.length == 0){
            provider.productList.removeAt(foundProductIndex);
          }else{
            provider.productList[foundProductIndex] = foundProduct;
          }
        }
      });
    }

    selectedQuestion.conditionsForProductSelection?.forEach((condition) {
      String? conditionString="";
      List<String> conditionList=[];
      int checkIndexForConditionString=0;
      condition.options?.forEach((element2) {
        checkIndexForConditionString++;
        conditionList.add("(${selectedQuestion.options?[index].value} "
            "${element2.condition} ${element2.value}) ${ checkIndexForConditionString < condition.options!.length ? condition.options![checkIndexForConditionString].optionOperator : ""}");
      });

      conditionString=conditionList.join(" ");
      Expression exp = Expression(conditionString);

      // try{
        selectedProducts = [...?condition.products];

        productList;

        if(exp.eval().toString() == "1"){
          selectedProducts.forEach((product) {
            var parsedQuantity=provider.checkForFormula(product.quantity)
                ? provider.executeFormula(product)
                : provider.isJSON(product.quantity)
                ? provider.result(product.quantity)
                : int.parse(product.quantity.toString());
            if(provider.productList.any((cp) => cp.id == product.id)){
              int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
                return selectedProduct.id== product.id;
              });

              var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
              Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
              OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);

              foundProduct.quantity = parsedQuantity;
              int quantity=0;
              foundProduct.belongsTo?.forEach((conditionId) {
                if(conditionId != condition.id){
                  ConditionsForProductSelection? foundCondition;
                  Option2? foundCondition2;
                  for(int i=0; i< questions.length; i++){
                    ValueElement2? question=questions[i];
                    foundCondition=question?.configuration?.conditionsForProductSelection?.firstWhereOrNull((cond) {
                      return cond.id == conditionId;
                    });
                    if(foundCondition != null){
                      break;
                    }

                    if(foundCondition == null){
                      foundCondition2=question?.configuration?.options!.firstWhereOrNull((op) {
                        return op.id == conditionId;
                      });
                    }
                    if(foundCondition2 != null){
                      break;
                    }

                  }

                  // ConditionsForProductSelection? foundCondition = selectedQuestion.conditionsForProductSelection!.firstWhereOrNull((cond) {
                  //   return cond.id == conditionId;
                  // });


                  OptionProduct2? foundProductOther2;
                  if(foundCondition != null){
                    foundProductOther2 = foundCondition.products?.firstWhereOrNull((pr){
                      return pr.id == product.id;
                    }) ;
                  }else{
                    if(foundCondition2 != null){
                      foundProductOther2 = foundCondition2.products?.firstWhereOrNull((pr){
                        return pr.id == product.id;
                      });
                    }
                  }
                  var encodedFoundProduct2=jsonEncode(foundProductOther2 ?? {});
                  Map<String, dynamic> decodedFoundProduct2=jsonDecode(encodedFoundProduct2) as Map<String, dynamic>;
                  OptionProduct2 foundProductOther=OptionProduct2.fromJson(decodedFoundProduct2);

                  var parsedQuantityFoundProduct=provider.checkForFormula(foundProductOther.quantity)
                      ? provider.executeFormula(foundProductOther)
                      : provider.isJSON(foundProductOther.quantity)
                      ? provider.result(foundProductOther.quantity)
                      : int.parse(foundProductOther.quantity.toString());
                  foundProduct.quantity = foundProduct.quantity + parsedQuantityFoundProduct;
                  //quantity=foundProduct.quantity + parsedQuantityFoundProduct;
                }
              });

              if(!foundProduct.belongsTo!.contains(condition.id)){
                var salePriceCondition =
                    double.parse(product.salePrice.toString()) *
                    parsedQuantity -
                        (double.parse(product.salePrice.toString()) *
                        parsedQuantity *
                            int.parse(condition.discount.toString())
                        ) / 100;
                foundProduct.salePrice = (
                    double.parse(foundProduct.salePrice.toString()) +
                    salePriceCondition
                ).toString();
              }
              else{
                var salePriceProduct =
                    double.parse(product.salePrice.toString()) *
                    parsedQuantity -
                        (
                            double.parse(product.salePrice.toString()) *
                            parsedQuantity *
                            int.parse(condition.discount.toString())
                        ) / 100;
                foundProduct.salePrice = (
                double.parse(foundProduct.salePrice.toString()) +
                    salePriceProduct
                ).toString();
                var previousQuantity=provider.checkForFormula(product.quantity)
                    ? provider.executeFormula(product,customValue: previousValueMap[option.uuid])
                    : provider.isJSON(product.quantity)
                    ? provider.result(product.quantity,customValue: previousValueMap[option.uuid])
                    : int.parse(product.quantity.toString());

                var salePriceProductprevious =
                    double.parse(product.salePrice.toString()) *
                        previousQuantity;
                foundProduct.salePrice = (
                double.parse(foundProduct.salePrice.toString()) -
                    salePriceProductprevious
                ).toString();
              }

              // foundProduct.quantity=quantity;
              // foundProduct.salePrice = (foundProduct.quantity *
              //     double.parse(product.salePrice.toString())  -
              //     (foundProduct.quantity *
              //         double.parse(product.salePrice.toString()) *
              //         double.parse(condition.discount.toString())) / 100).toString();
              foundProduct.belongsTo?.add(condition.id);

              List? belong=foundProduct.belongsTo;
              var unique=belong?.toSet().toList();
              foundProduct.belongsTo=[...?unique];

              var encodedFoundProduct3=jsonEncode(foundProduct);
              Map<String, dynamic> decodedFoundProduct3=jsonDecode(encodedFoundProduct3) as Map<String, dynamic>;
              OptionProduct2 foundProductOther3=OptionProduct2.fromJson(decodedFoundProduct3);

              provider.productList[foundProductIndex] = foundProductOther3;

            } else{
              var encodedFoundProduct4=jsonEncode(product);
              Map<String, dynamic> decodedFoundProduct4=jsonDecode(encodedFoundProduct4) as Map<String, dynamic>;
              OptionProduct2 foundProductOther4=OptionProduct2.fromJson(decodedFoundProduct4);

              OptionProduct2 cartProduct= foundProductOther4;
              cartProduct.quantity= parsedQuantity;
              cartProduct.belongsTo?.add(condition.id);
              cartProduct.salePrice =
                  (parsedQuantity *
                      double.parse(product.salePrice.toString()) -
                      (parsedQuantity * double.parse(product.salePrice.toString()) *
                          double.parse(condition.discount.toString())) / 100).toString();
              provider.productList.add(cartProduct);
            }

          });
          String? selectedQuestionId=surveyModel!.steps![provider.questionsIndex].type == "question"
              ? surveyModel!.steps![provider.questionsIndex].value?.id.toString()
              : surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].id.toString();
          // if(selectedInputs['$selectedQuestionId'] != null){
          //   var json=jsonEncode(condition);
          //   Map<String, dynamic> decodedString=jsonDecode(json) as Map<String, dynamic>;
          //   Option2 optionForSelectedInput=Option2.fromJson(decodedString);
          //   selectedInputs[selectedQuestionId][
          //   "conditions"
          //   ][condition.id] = optionForSelectedInput;
          //   // selectedInputs[selectedQuestionId]["options"].value=selectedQuestion.options?[index].value;
          // }else{
          //   selectedInputs[selectedQuestionId]={
          //     "options":{},
          //     "conditions":{}
          //   };
          //   var json=jsonEncode(condition);
          //   Map<String, dynamic> decodedString=jsonDecode(json) as Map<String, dynamic>;
          //   Option2 conditionForSelectedInput=Option2.fromJson(decodedString);
          //   selectedInputs[selectedQuestionId]['conditions'][condition.id]=conditionForSelectedInput;
          //   // selectedInputs[selectedQuestionId]["options"].value=selectedQuestion.options?[index].value;
          // }
        }else{
          selectedProducts.forEach((product) {
            // var parsedQuantity=provider.checkForFormula(product.quantity)
            //     ? provider.executeFormula(product)
            //     : provider.isJSON(product.quantity)
            //     ? provider.result(product.quantity)
            //     : int.parse(product.quantity.toString());
            int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
              return selectedProduct.id== product.id;
            });
            if(foundProductIndex == -1) return;
            var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
            Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
            OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);

            if(foundProduct.belongsTo!.contains(condition.id)){

              var parsedQuantityPrevious=provider.checkForFormula(product.quantity)
                  ? provider.executeFormula(product,customValue: previousValueMap[option.uuid])
                  : provider.isJSON(product.quantity)
                  ? provider.result(product.quantity,customValue: previousValueMap[option.uuid])
                  : int.parse(product.quantity.toString());
              var salePriceProductPrevious =
              double.parse(product.salePrice.toString()) *
                  parsedQuantityPrevious -
                  (
                      double.parse(product.salePrice.toString()) *
                      parsedQuantityPrevious *
                      int.parse(condition.discount.toString())
                  ) / 100;
              foundProduct.quantity = foundProduct.quantity - parsedQuantityPrevious;
              foundProduct.salePrice =
                  (
                  double.parse(foundProduct.salePrice.toString()) -
                      salePriceProductPrevious
                  ).toString();
              foundProduct.belongsTo = foundProduct.belongsTo?.where((id) {
                return id != condition.id;
              }).toList();
              if(foundProduct.belongsTo?.length == 0){
                provider.productList.removeAt(foundProductIndex);
              }else{
                provider.productList[foundProductIndex] = foundProduct;
              }
            }
          });
          String? selectedQuestionId=surveyModel!.steps![provider.questionsIndex].type == "question"
              ? surveyModel!.steps![provider.questionsIndex].value?.id.toString()
              : surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].id.toString();

          // selectedInputs[selectedQuestionId][condition.id]
        }
      // }catch(e){
      //   print("Error in condition part : $e" );
      // }
    });
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   provider.setCheckValue("");
    // });
  }

  //for type single
  optionSingle(Configuration2 selectedQuestion, int index){
    DataProvider provider=Provider.of<DataProvider>(Get.context!,listen: false);
    selectedQuestion.options?.forEach((option) {
      List<OptionProduct2> selectedProducts = [...?option.products];
      if(option.id ==
      selectedQuestion.options?[index].id
      ){
        selectedProducts.forEach((product) {
          var parsedQuantity=checkForFormula(product.quantity)
              ? provider.executeFormula(product)
              : provider.isJSON(product.quantity)
              ? provider.result(product.quantity)
              : int.parse(product.quantity.toString());
          if(provider.productList.any((cp) => cp.id == product.id)){
            int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
              return selectedProduct.id== product.id;
            });

            var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
            Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
            OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);

            foundProduct.quantity = parsedQuantity;
            int quantity=0;
            foundProduct.belongsTo?.forEach((optionId) {
              if(optionId != option.uuid){

                // Option2? foundOption = selectedQuestion.options!.firstWhereOrNull((op) {
                //   return op.id == optionId;
                // });

                Option2? foundOption;
                ConditionsForProductSelection? foundOption2;
                for(int i=0; i < questions.length ; i++){
                  ValueElement2? question=questions[i];
                  foundOption=question?.configuration?.options?.firstWhereOrNull((op) {
                    return op.id == optionId;
                  });

                  if(foundOption != null){
                    break;
                  }

                  if(foundOption == null){

                    foundOption2=question?.configuration?.conditionsForProductSelection?.firstWhereOrNull((cond) {
                      return cond.id == optionId;
                    });
                    if(foundOption2 != null){
                      break;
                    }
                  }

                }



                OptionProduct2? foundProductOther2;
                if(foundOption != null){
                  foundProductOther2 = foundOption.products?.firstWhereOrNull((pr){
                    return pr.id == product.id;
                  });
                }else{
                  if(foundOption2 != null){
                    foundProductOther2 = foundOption2.products?.firstWhereOrNull((pr){
                      return pr.id == product.id;
                    }) ;
                  }
                }

                var encodedFoundProduct2=jsonEncode(foundProductOther2 ?? {});
                Map<String, dynamic> decodedFoundProduct2=jsonDecode(encodedFoundProduct2) as Map<String, dynamic>;
                OptionProduct2 foundProductOther=OptionProduct2.fromJson(decodedFoundProduct2);

                var parsedQuantityFoundProduct=provider.checkForFormula(foundProductOther.quantity)
                    ? provider.executeFormula(foundProductOther)
                    : provider.isJSON(foundProductOther.quantity)
                    ? provider.result(foundProductOther.quantity)
                    : int.parse(foundProductOther.quantity.toString());

                foundProduct.quantity = foundProduct.quantity + parsedQuantityFoundProduct;
                //quantity=foundProduct.quantity + parsedQuantityFoundProduct;
              }
            });

            foundProduct.salePrice = (
                int.parse(foundProduct.quantity.toString()) *
                double.parse(product.salePrice.toString())
            ).toString();
            foundProduct.belongsTo?.add(option.uuid);

            List? belong=foundProduct.belongsTo;
            var unique=belong?.toSet().toList();
            foundProduct.belongsTo=[...?unique];

            var encodedFoundProduct3=jsonEncode(foundProduct);
            Map<String, dynamic> decodedFoundProduct3=jsonDecode(encodedFoundProduct3) as Map<String, dynamic>;
            OptionProduct2 foundProductOther3 = OptionProduct2.fromJson(decodedFoundProduct3);


            provider.productList[foundProductIndex] = foundProductOther3;

          } else{
            var encodedFoundProduct3=jsonEncode(product);
            Map<String, dynamic> decodedFoundProduct3=jsonDecode(encodedFoundProduct3) as Map<String, dynamic>;
            OptionProduct2 cartProduct = OptionProduct2.fromJson(decodedFoundProduct3);

            cartProduct.belongsTo?.add(option.uuid);
            cartProduct.quantity = parsedQuantity;
            cartProduct.salePrice = (
                int.parse(parsedQuantity.toString()) *
                    double.parse(product.salePrice.toString())
            ).toString();

            var encodedFoundProduct4=jsonEncode(cartProduct);
            Map<String, dynamic> decodedFoundProduct4=jsonDecode(encodedFoundProduct4) as Map<String, dynamic>;
            OptionProduct2 foundProductOther4 = OptionProduct2.fromJson(decodedFoundProduct4);

            provider.productList.add(foundProductOther4);

          }
        });
      } else{
        selectedProducts.forEach((product) {

          var parsedQuantity=provider.checkForFormula(product.quantity)
              ? provider.executeFormula(product)
              : provider.isJSON(product.quantity)
              ? provider.result(product.quantity)
              : int.parse(product.quantity.toString());
          int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
            return selectedProduct.id== product.id;
          });

          if(foundProductIndex == -1) return;
          var encodedFoundProduct4=jsonEncode(provider.productList[foundProductIndex]);
          Map<String, dynamic> decodedFoundProduct4=jsonDecode(encodedFoundProduct4) as Map<String, dynamic>;
          OptionProduct2 foundProduct = OptionProduct2.fromJson(decodedFoundProduct4);

          if(foundProduct.belongsTo!.contains(option.uuid)){

            foundProduct.quantity =
                int.parse(foundProduct.quantity.toString()) - parsedQuantity;

            foundProduct.salePrice = (
                int.parse(foundProduct.quantity.toString()) *
                    double.parse(product.salePrice.toString())
            ).toString();

            foundProduct.belongsTo = foundProduct.belongsTo?.where((id) {
              return id != option.uuid;
            }).toList();
            if(foundProduct.belongsTo?.length == 0){
              provider.productList.removeAt(foundProductIndex);
            }else{
              provider.productList[foundProductIndex] = foundProduct;
            }
          }
        });
      };
    });
  }

  //for type text
  optionText(String text, Configuration2 selectedQuestion, int index){
    DataProvider provider=Provider.of<DataProvider>(Get.context!,listen: false);

    Option2 option=selectedQuestion.options![index];

    List<OptionProduct2> selectedProducts = [...?option.products];
    if(text.length != 0){

      selectedProducts.forEach((product) {
        var parsedQuantity=provider.checkForFormula(product.quantity)
            ? provider.executeFormula(product)
            : provider.isJSON(product.quantity)
            ? provider.result(product.quantity)
            : int.parse(product.quantity.toString());
        if(provider.productList.any((cp) => cp.id == product.id)){
          int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
            return selectedProduct.id== product.id;
          });

          var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
          Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
          OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);

          foundProduct.quantity = parsedQuantity;
          int quantity=0;
          foundProduct.belongsTo?.forEach((optionId) {
            if(optionId != option.uuid){

              Option2? foundOption;
              ConditionsForProductSelection? foundOption2;
              for(int i=0; i < questions.length ; i++){
                ValueElement2? question=questions[i];
                foundOption=question?.configuration?.options?.firstWhereOrNull((op) {
                  return op.id == optionId;
                });

                if(foundOption != null){
                  break;
                }

                if(foundOption == null){

                  foundOption2=question?.configuration?.conditionsForProductSelection?.firstWhereOrNull((cond) {
                    return cond.id == optionId;
                  });
                  if(foundOption2 != null){
                    break;
                  }
                }

              }



              OptionProduct2? foundProductOther2;
              if(foundOption != null){
                foundProductOther2 = foundOption.products?.firstWhereOrNull((pr){
                  return pr.id == product.id;
                });
              }else{
                if(foundOption2 != null){
                  foundProductOther2 = foundOption2.products?.firstWhereOrNull((pr){
                    return pr.id == product.id;
                  }) ;
                }
              }

              var encodedFoundProduct2=jsonEncode(foundProductOther2 ?? {});
              Map<String, dynamic> decodedFoundProduct2=jsonDecode(encodedFoundProduct2) as Map<String, dynamic>;
              OptionProduct2 foundProductOther=OptionProduct2.fromJson(decodedFoundProduct2);

              var parsedQuantityFoundProduct=provider.checkForFormula(foundProductOther.quantity)
                  ? provider.executeFormula(foundProductOther)
                  : provider.isJSON(foundProductOther.quantity)
                  ? provider.result(foundProductOther.quantity)
                  : int.parse(foundProductOther.quantity.toString());

              foundProduct.quantity = foundProduct.quantity + parsedQuantityFoundProduct;
              //quantity=foundProduct.quantity + parsedQuantityFoundProduct;
            }
          });

          if(!foundProduct.belongsTo!.contains(option.uuid)){
            var salePriceProduct=
                double.parse(product.salePrice.toString()) * int.parse(parsedQuantity.toString());
            foundProduct.salePrice = (double.parse(foundProduct.salePrice.toString()) + salePriceProduct).toString();
          }
          // else{
          //   var salePriceProduct=
          //       double.parse(
          //           product.salePrice.toString()) * int.parse(parsedQuantity.toString());
          //   foundProduct.salePrice = (double.parse(foundProduct.salePrice.toString()) + salePriceProduct).toString();
          //
          //   var previousQuantity=provider.checkForFormula(product.quantity)
          //       ? provider.executeFormula(product,customValue: previousValueMap["${option.uuid}"] )
          //       : provider.isJSON(product.quantity)
          //       ? provider.result(product.quantity,customValue:previousValueMap["${option.uuid}"] )
          //       : int.parse(product.quantity.toString());
          //
          //   var saleProceProductPrevious =
          //       double.parse(product.salePrice.toString()) * int.parse(previousQuantity.toString());
          //   foundProduct.salePrice = (
          //       double.parse(foundProduct.salePrice.toString()) -
          //           double.parse(saleProceProductPrevious.toString())
          //   ).toString();
          // }
          foundProduct.belongsTo?.add(option.uuid);

          List? belong=foundProduct.belongsTo;
          var unique=belong?.toSet().toList();
          foundProduct.belongsTo=[...?unique];

          var encodedFoundProduct3=jsonEncode(foundProduct);
          Map<String, dynamic> decodedFoundProduct3=jsonDecode(encodedFoundProduct3) as Map<String, dynamic>;
          OptionProduct2 foundProductOther3 = OptionProduct2.fromJson(decodedFoundProduct3);


          provider.productList[foundProductIndex] = foundProductOther3;

        }
        else{
          var encodedFoundProduct4=jsonEncode(product);
          Map<String, dynamic> decodedFoundProduct4=jsonDecode(encodedFoundProduct4) as Map<String, dynamic>;
          OptionProduct2 foundProductOther4=OptionProduct2.fromJson(decodedFoundProduct4);

          OptionProduct2 cartProduct= foundProductOther4;
          cartProduct.quantity= parsedQuantity;
          cartProduct.belongsTo?.add(option.uuid);
          cartProduct.salePrice= (parsedQuantity * int.parse(product.salePrice.toString())).toString();
          provider.productList.add(cartProduct);
        }
      });
    }
    else{

      selectedProducts.forEach((product) {
        var parsedQuantity=provider.checkForFormula(product.quantity)
            ? provider.executeFormula(product)
            : provider.isJSON(product.quantity)
            ? provider.result(product.quantity)
            : int.parse(product.quantity.toString());
        int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
          return selectedProduct.id== product.id;
        });
        if(foundProductIndex == -1) return;
        var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
        Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
        OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);

        if(foundProduct.belongsTo!.contains(option.uuid)){
          // var previousQuantity=provider.checkForFormula(product.quantity)
          //     ? provider.executeFormula(product,customValue: previousValueMap[option.uuid])
          //     : provider.isJSON(product.quantity)
          //     ? provider.result(product.quantity,customValue: previousValueMap[option.uuid])
          //     : int.parse(product.quantity.toString());
          var salePriceProduct=
              int.parse(product.salePrice.toString()) * parsedQuantity;
          foundProduct.quantity = foundProduct.quantity - parsedQuantity;
          foundProduct.salePrice = (double.parse(foundProduct.salePrice.toString()) -
              salePriceProduct).toString();
          foundProduct.belongsTo = foundProduct.belongsTo?.where((id) {
            return id != option.uuid;
          }).toList();
          if(foundProduct.belongsTo?.length == 0){
            provider.productList.removeAt(foundProductIndex);
          }else{
            provider.productList[foundProductIndex] = foundProduct;
          }
        }
      });
    }

    selectedQuestion.conditionsForProductSelection?.forEach((condition) {
      String? conditionString="";
      List<String> conditionList=[];
      int checkIndexForConditionString=0;
      condition.options?.forEach((option) {
        checkIndexForConditionString++;
        bool abc= option.condition == "contains" ?
        eval("(\"${selectedQuestion.options?[index].value.toString()}\""
            "${".contains(\"${option.value}\")"} )") :
        eval("(\"!${selectedQuestion.options?[index].value.toString()}\""
            "${".contains(\"${option.value}\")"} )");
        conditionList.add("$abc ${ checkIndexForConditionString < condition.options!.length ? condition.options![checkIndexForConditionString].optionOperator : ""}  ");
      });

      conditionString=conditionList.join(" ");
      Expression exp = Expression(conditionString);

      // try{
      List<OptionProduct2> selectedProducts = [...?condition.products];


      if(exp.eval().toString() == "1"){
        selectedProducts.forEach((product) {
          var parsedQuantity=provider.checkForFormula(product.quantity)
              ? provider.executeFormula(product)
              : provider.isJSON(product.quantity)
              ? provider.result(product.quantity)
              : int.parse(product.quantity.toString());
          if(provider.productList.any((cp) => cp.id == product.id)){
            int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
              return selectedProduct.id== product.id;
            });

            var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
            Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
            OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);

            foundProduct.quantity = parsedQuantity;
            int quantity=0;
            foundProduct.belongsTo?.forEach((conditionId) {
              if(conditionId != condition.id){
                ConditionsForProductSelection? foundCondition;
                Option2? foundCondition2;

                  foundCondition=selectedQuestion.conditionsForProductSelection?.firstWhereOrNull((cond) {
                    return cond.id == conditionId;
                  });

                  if(foundCondition == null){
                    foundCondition2=selectedQuestion.options!.firstWhereOrNull((op) {
                      return op.id == conditionId;
                    });
                  }


                OptionProduct2? foundProductOther2;
                if(foundCondition != null){
                  foundProductOther2 = foundCondition.products?.firstWhereOrNull((pr){
                    return pr.id == product.id;
                  }) ;
                }else{
                  if(foundCondition2 != null){
                    foundProductOther2 = foundCondition2.products?.firstWhereOrNull((pr){
                      return pr.id == product.id;
                    });
                  }
                }
                var encodedFoundProduct2=jsonEncode(foundProductOther2 ?? {});
                Map<String, dynamic> decodedFoundProduct2=jsonDecode(encodedFoundProduct2) as Map<String, dynamic>;
                OptionProduct2 foundProductOther=OptionProduct2.fromJson(decodedFoundProduct2);

                var parsedQuantityFoundProduct=provider.checkForFormula(foundProductOther.quantity)
                    ? provider.executeFormula(foundProductOther)
                    : provider.isJSON(foundProductOther.quantity)
                    ? provider.result(foundProductOther.quantity)
                    : int.parse(foundProductOther.quantity.toString());
                foundProduct.quantity = foundProduct.quantity + parsedQuantityFoundProduct;
                //quantity=foundProduct.quantity + parsedQuantityFoundProduct;
              }
            });

            if(!foundProduct.belongsTo!.contains(condition.id)){
              var salePriceCondition =
                  double.parse(product.salePrice.toString()) *
                      parsedQuantity -
                      (double.parse(product.salePrice.toString()) *
                          parsedQuantity *
                          int.parse(condition.discount.toString())
                      ) / 100;
              foundProduct.salePrice = (
                  double.parse(foundProduct.salePrice.toString()) +
                      salePriceCondition
              ).toString();
            }
            // else{
            //   var salePriceProduct =
            //       double.parse(product.salePrice.toString()) *
            //           parsedQuantity -
            //           (
            //               double.parse(product.salePrice.toString()) *
            //                   parsedQuantity *
            //                   int.parse(condition.discount.toString())
            //           ) / 100;
            //   foundProduct.salePrice = (
            //       double.parse(foundProduct.salePrice.toString()) +
            //           salePriceProduct
            //   ).toString();
            //   var previousQuantity=provider.checkForFormula(product.quantity)
            //       ? provider.executeFormula(product,customValue: previousValueMap[option.uuid])
            //       : provider.isJSON(product.quantity)
            //       ? provider.result(product.quantity,customValue: previousValueMap[option.uuid])
            //       : int.parse(product.quantity.toString());
            //
            //   var salePriceProductprevious =
            //       double.parse(product.salePrice.toString()) *
            //           previousQuantity;
            //   foundProduct.salePrice = (
            //       double.parse(foundProduct.salePrice.toString()) -
            //           salePriceProductprevious
            //   ).toString();
            // }

            foundProduct.belongsTo?.add(condition.id);

            List? belong=foundProduct.belongsTo;
            var unique=belong?.toSet().toList();
            foundProduct.belongsTo=[...?unique];

            var encodedFoundProduct3=jsonEncode(foundProduct);
            Map<String, dynamic> decodedFoundProduct3=jsonDecode(encodedFoundProduct3) as Map<String, dynamic>;
            OptionProduct2 foundProductOther3=OptionProduct2.fromJson(decodedFoundProduct3);

            provider.productList[foundProductIndex] = foundProductOther3;

          } else{
            var encodedFoundProduct4=jsonEncode(product);
            Map<String, dynamic> decodedFoundProduct4=jsonDecode(encodedFoundProduct4) as Map<String, dynamic>;
            OptionProduct2 foundProductOther4=OptionProduct2.fromJson(decodedFoundProduct4);

            OptionProduct2 cartProduct= foundProductOther4;
            cartProduct.quantity= parsedQuantity;
            cartProduct.belongsTo?.add(condition.id);
            cartProduct.salePrice =
                (parsedQuantity *
                    double.parse(product.salePrice.toString()) -
                    (parsedQuantity * double.parse(product.salePrice.toString()) *
                        double.parse(condition.discount.toString())) / 100).toString();
            provider.productList.add(cartProduct);
          }

        });

      }else{
        selectedProducts.forEach((product) {
          var parsedQuantity=provider.checkForFormula(product.quantity)
              ? provider.executeFormula(product)
              : provider.isJSON(product.quantity)
              ? provider.result(product.quantity)
              : int.parse(product.quantity.toString());
          int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
            return selectedProduct.id== product.id;
          });
          if(foundProductIndex == -1) return;
          var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
          Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
          OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);

          if(foundProduct.belongsTo!.contains(condition.id)){

            // var parsedQuantityPrevious=provider.checkForFormula(product.quantity)
            //     ? provider.executeFormula(product,customValue: previousValueMap[option.uuid])
            //     : provider.isJSON(product.quantity)
            //     ? provider.result(product.quantity,customValue: previousValueMap[option.uuid])
            //     : int.parse(product.quantity.toString());

            foundProduct.quantity = foundProduct.quantity - parsedQuantity;
            var salePriceCondition =
                double.parse(product.salePrice.toString()) *
                    parsedQuantity -
                    (
                        double.parse(product.salePrice.toString()) *
                            parsedQuantity *
                            int.parse(condition.discount.toString())
                    ) / 100;
            foundProduct.salePrice =
                (
                    double.parse(foundProduct.salePrice.toString()) -
                        salePriceCondition
                ).toString();
            foundProduct.belongsTo = foundProduct.belongsTo?.where((id) {
              return id != condition.id;
            }).toList();
            if(foundProduct.belongsTo?.length == 0){
              provider.productList.removeAt(foundProductIndex);
            }else{
              provider.productList[foundProductIndex] = foundProduct;
            }
          }
        });
        String? selectedQuestionId=surveyModel!.steps![provider.questionsIndex].type == "question"
            ? surveyModel!.steps![provider.questionsIndex].value?.id.toString()
            : surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].id.toString();

        // selectedInputs[selectedQuestionId][condition.id]
      }
      // }catch(e){
      //   print("Error in condition part : $e" );
      // }
    });
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   provider.setCheckValue("");
    // });
  }

  //for type multiple
  optionMultiple(bool isSelected, Configuration2 selectedQuestion, int index){
    DataProvider provider=Provider.of<DataProvider>(Get.context!,listen: false);

    Option2 option=selectedQuestion.options![index];

    List<OptionProduct2> selectedProducts = [...?option.products];
    if(isSelected == true){

      selectedProducts.forEach((product) {
        var parsedQuantity=provider.checkForFormula(product.quantity)
            ? provider.executeFormula(product)
            : provider.isJSON(product.quantity)
            ? provider.result(product.quantity)
            : int.parse(product.quantity.toString());
        if(provider.productList.any((cp) => cp.id == product.id)){
          int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
            return selectedProduct.id== product.id;
          });

          var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
          Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
          OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);

          foundProduct.quantity = parsedQuantity;
          int quantity=0;
          foundProduct.belongsTo?.forEach((optionId) {
            if(optionId != option.uuid){

              Option2? foundOption;
              ConditionsForProductSelection? foundOption2;
              for(int i=0; i < questions.length ; i++){
                ValueElement2? question=questions[i];
                foundOption=question?.configuration?.options?.firstWhereOrNull((op) {
                  return op.id == optionId;
                });

                if(foundOption != null){
                  break;
                }

                if(foundOption == null){

                  foundOption2=question?.configuration?.conditionsForProductSelection?.firstWhereOrNull((cond) {
                    return cond.id == optionId;
                  });
                  if(foundOption2 != null){
                    break;
                  }
                }

              }



              OptionProduct2? foundProductOther2;
              if(foundOption != null){
                foundProductOther2 = foundOption.products?.firstWhereOrNull((pr){
                  return pr.id == product.id;
                });
              }else{
                if(foundOption2 != null){
                  foundProductOther2 = foundOption2.products?.firstWhereOrNull((pr){
                    return pr.id == product.id;
                  }) ;
                }
              }

              var encodedFoundProduct2=jsonEncode(foundProductOther2 ?? {});
              Map<String, dynamic> decodedFoundProduct2=jsonDecode(encodedFoundProduct2) as Map<String, dynamic>;
              OptionProduct2 foundProductOther=OptionProduct2.fromJson(decodedFoundProduct2);

              var parsedQuantityFoundProduct=provider.checkForFormula(foundProductOther.quantity)
                  ? provider.executeFormula(foundProductOther)
                  : provider.isJSON(foundProductOther.quantity)
                  ? provider.result(foundProductOther.quantity)
                  : int.parse(foundProductOther.quantity.toString());

              foundProduct.quantity = foundProduct.quantity + parsedQuantityFoundProduct;
              //quantity=foundProduct.quantity + parsedQuantityFoundProduct;
            }
          });

          if(!foundProduct.belongsTo!.contains(option.uuid)){
            var salePriceProduct=
                double.parse(product.salePrice.toString()) * int.parse(parsedQuantity.toString());
            foundProduct.salePrice = (double.parse(foundProduct.salePrice.toString()) + salePriceProduct).toString();
          }
          // else{
          //   var salePriceProduct=
          //       double.parse(
          //           product.salePrice.toString()) * int.parse(parsedQuantity.toString());
          //   foundProduct.salePrice = (double.parse(foundProduct.salePrice.toString()) + salePriceProduct).toString();
          //
          //   var previousQuantity=provider.checkForFormula(product.quantity)
          //       ? provider.executeFormula(product,customValue: previousValueMap["${option.uuid}"] )
          //       : provider.isJSON(product.quantity)
          //       ? provider.result(product.quantity,customValue:previousValueMap["${option.uuid}"] )
          //       : int.parse(product.quantity.toString());
          //
          //   var saleProceProductPrevious =
          //       double.parse(product.salePrice.toString()) * int.parse(previousQuantity.toString());
          //   foundProduct.salePrice = (
          //       double.parse(foundProduct.salePrice.toString()) -
          //           double.parse(saleProceProductPrevious.toString())
          //   ).toString();
          // }
          foundProduct.belongsTo?.add(option.uuid);

          List? belong=foundProduct.belongsTo;
          var unique=belong?.toSet().toList();
          foundProduct.belongsTo=[...?unique];

          var encodedFoundProduct3=jsonEncode(foundProduct);
          Map<String, dynamic> decodedFoundProduct3=jsonDecode(encodedFoundProduct3) as Map<String, dynamic>;
          OptionProduct2 foundProductOther3 = OptionProduct2.fromJson(decodedFoundProduct3);


          provider.productList[foundProductIndex] = foundProductOther3;

        }
        else{
          var encodedFoundProduct4=jsonEncode(product);
          Map<String, dynamic> decodedFoundProduct4=jsonDecode(encodedFoundProduct4) as Map<String, dynamic>;
          OptionProduct2 foundProductOther4=OptionProduct2.fromJson(decodedFoundProduct4);

          OptionProduct2 cartProduct= foundProductOther4;
          cartProduct.quantity= parsedQuantity;
          cartProduct.belongsTo?.add(option.uuid);
          cartProduct.salePrice= (parsedQuantity * int.parse(product.salePrice.toString())).toString();
          provider.productList.add(cartProduct);
        }
      });
    }
    else{

      selectedProducts.forEach((product) {
        var parsedQuantity=provider.checkForFormula(product.quantity)
            ? provider.executeFormula(product)
            : provider.isJSON(product.quantity)
            ? provider.result(product.quantity)
            : int.parse(product.quantity.toString());
        int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
          return selectedProduct.id== product.id;
        });
        if(foundProductIndex == -1) return;
        var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
        Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
        OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);

        if(foundProduct.belongsTo!.contains(option.uuid)){
          // var previousQuantity=provider.checkForFormula(product.quantity)
          //     ? provider.executeFormula(product,customValue: previousValueMap[option.uuid])
          //     : provider.isJSON(product.quantity)
          //     ? provider.result(product.quantity,customValue: previousValueMap[option.uuid])
          //     : int.parse(product.quantity.toString());
          var salePriceProduct=
              int.parse(product.salePrice.toString()) * parsedQuantity;
          foundProduct.quantity = foundProduct.quantity - parsedQuantity;
          foundProduct.salePrice = (double.parse(foundProduct.salePrice.toString()) -
              salePriceProduct).toString();
          foundProduct.belongsTo = foundProduct.belongsTo?.where((id) {
            return id != option.uuid;
          }).toList();
          if(foundProduct.belongsTo?.length == 0){
            provider.productList.removeAt(foundProductIndex);
          }else{
            provider.productList[foundProductIndex] = foundProduct;
          }
        }
      });
    }

    selectedQuestion.conditionsForProductSelection?.forEach((condition) {
      String? conditionString="";
      List<String> conditionList=[];
      int checkIndexForConditionString=0;

      condition.options?.forEach((option) {
        checkIndexForConditionString++;
        bool abc=false;

        selectedQuestion.options?.forEach((aboveOption) {
          if(aboveOption.id==option.option?.id){
            abc= option.condition == "checked" ? aboveOption.isSelected == true ? true : false : aboveOption.isSelected == false ? true : false;
          }
        });
        conditionList.add("$abc ${ checkIndexForConditionString < condition.options!.length ? condition.options![checkIndexForConditionString].optionOperator : ""}  ");
      });

      conditionString=conditionList.join("");
      Expression exp = Expression(conditionString);

      // try{
       selectedProducts = [...?condition.products];


      if(exp.eval().toString() == "1"){
        selectedProducts.forEach((product) {
          var parsedQuantity=provider.checkForFormula(product.quantity)
              ? provider.executeFormula(product)
              : provider.isJSON(product.quantity)
              ? provider.result(product.quantity)
              : int.parse(product.quantity.toString());
          if(provider.productList.any((cp) => cp.id == product.id)){
            int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
              return selectedProduct.id== product.id;
            });

            var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
            Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
            OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);

            foundProduct.quantity = parsedQuantity;
            int quantity=0;
            foundProduct.belongsTo?.forEach((conditionId) {
              if(conditionId != condition.id){
                ConditionsForProductSelection? foundCondition;
                Option2? foundCondition2;

                for(int i=0; i< questions.length; i++){
                  ValueElement2? question=questions[i];
                  foundCondition=question?.configuration?.conditionsForProductSelection?.firstWhereOrNull((cond) {
                    return cond.id == conditionId;
                  });
                  if(foundCondition != null){
                    break;
                  }

                  if(foundCondition == null){
                    foundCondition2=question?.configuration?.options!.firstWhereOrNull((op) {
                      return op.id == conditionId;
                    });
                  }
                  if(foundCondition2 != null){
                    break;
                  }

                }


                OptionProduct2? foundProductOther2;
                if(foundCondition != null){
                  foundProductOther2 = foundCondition.products?.firstWhereOrNull((pr){
                    return pr.id == product.id;
                  }) ;
                }else{
                  if(foundCondition2 != null){
                    foundProductOther2 = foundCondition2.products?.firstWhereOrNull((pr){
                      return pr.id == product.id;
                    });
                  }
                }
                var encodedFoundProduct2=jsonEncode(foundProductOther2 ?? {});
                Map<String, dynamic> decodedFoundProduct2=jsonDecode(encodedFoundProduct2) as Map<String, dynamic>;
                OptionProduct2 foundProductOther=OptionProduct2.fromJson(decodedFoundProduct2);

                var parsedQuantityFoundProduct=provider.checkForFormula(foundProductOther.quantity)
                    ? provider.executeFormula(foundProductOther)
                    : provider.isJSON(foundProductOther.quantity)
                    ? provider.result(foundProductOther.quantity)
                    : int.parse(foundProductOther.quantity.toString());
                foundProduct.quantity = foundProduct.quantity + parsedQuantityFoundProduct;
                //quantity=foundProduct.quantity + parsedQuantityFoundProduct;
              }
            });

            if(!foundProduct.belongsTo!.contains(condition.id)){
              var salePriceCondition =
                  double.parse(product.salePrice.toString()) *
                      parsedQuantity -
                      (double.parse(product.salePrice.toString()) *
                          parsedQuantity *
                          int.parse(condition.discount.toString())
                      ) / 100;
              foundProduct.salePrice = (
                  double.parse(foundProduct.salePrice.toString()) +
                      salePriceCondition
              ).toString();
            }
            // else{
            //   var salePriceProduct =
            //       double.parse(product.salePrice.toString()) *
            //           parsedQuantity -
            //           (
            //               double.parse(product.salePrice.toString()) *
            //                   parsedQuantity *
            //                   int.parse(condition.discount.toString())
            //           ) / 100;
            //   foundProduct.salePrice = (
            //       double.parse(foundProduct.salePrice.toString()) +
            //           salePriceProduct
            //   ).toString();
            //   var previousQuantity=provider.checkForFormula(product.quantity)
            //       ? provider.executeFormula(product,customValue: previousValueMap[option.uuid])
            //       : provider.isJSON(product.quantity)
            //       ? provider.result(product.quantity,customValue: previousValueMap[option.uuid])
            //       : int.parse(product.quantity.toString());
            //
            //   var salePriceProductprevious =
            //       double.parse(product.salePrice.toString()) *
            //           previousQuantity;
            //   foundProduct.salePrice = (
            //       double.parse(foundProduct.salePrice.toString()) -
            //           salePriceProductprevious
            //   ).toString();
            // }

            foundProduct.belongsTo?.add(condition.id);

            List? belong=foundProduct.belongsTo;
            var unique=belong?.toSet().toList();
            foundProduct.belongsTo=[...?unique];

            var encodedFoundProduct3=jsonEncode(foundProduct);
            Map<String, dynamic> decodedFoundProduct3=jsonDecode(encodedFoundProduct3) as Map<String, dynamic>;
            OptionProduct2 foundProductOther3=OptionProduct2.fromJson(decodedFoundProduct3);

            provider.productList[foundProductIndex] = foundProductOther3;

          } else{
            var encodedFoundProduct4=jsonEncode(product);
            Map<String, dynamic> decodedFoundProduct4=jsonDecode(encodedFoundProduct4) as Map<String, dynamic>;
            OptionProduct2 foundProductOther4=OptionProduct2.fromJson(decodedFoundProduct4);

            OptionProduct2 cartProduct= foundProductOther4;
            cartProduct.quantity= parsedQuantity;
            cartProduct.belongsTo?.add(condition.id);
            cartProduct.salePrice =
                (parsedQuantity *
                    double.parse(product.salePrice.toString()) -
                    (parsedQuantity * double.parse(product.salePrice.toString()) *
                        double.parse(condition.discount.toString())) / 100).toString();
            provider.productList.add(cartProduct);
          }

        });

      }else{
        selectedProducts.forEach((product) {
          var parsedQuantity=provider.checkForFormula(product.quantity)
              ? provider.executeFormula(product)
              : provider.isJSON(product.quantity)
              ? provider.result(product.quantity)
              : int.parse(product.quantity.toString());
          int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
            return selectedProduct.id== product.id;
          });
          if(foundProductIndex == -1) return;
          var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
          Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
          OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);

          if(foundProduct.belongsTo!.contains(condition.id)){

            // var parsedQuantityPrevious=provider.checkForFormula(product.quantity)
            //     ? provider.executeFormula(product,customValue: previousValueMap[option.uuid])
            //     : provider.isJSON(product.quantity)
            //     ? provider.result(product.quantity,customValue: previousValueMap[option.uuid])
            //     : int.parse(product.quantity.toString());

            foundProduct.quantity = foundProduct.quantity - parsedQuantity;
            var salePriceCondition =
                double.parse(product.salePrice.toString()) *
                    parsedQuantity -
                    (
                        double.parse(product.salePrice.toString()) *
                            parsedQuantity *
                            int.parse(condition.discount.toString())
                    ) / 100;
            foundProduct.salePrice =
                (
                    double.parse(foundProduct.salePrice.toString()) -
                        salePriceCondition
                ).toString();
            foundProduct.belongsTo = foundProduct.belongsTo?.where((id) {
              return id != condition.id;
            }).toList();
            if(foundProduct.belongsTo?.length == 0){
              provider.productList.removeAt(foundProductIndex);
            }else{
              provider.productList[foundProductIndex] = foundProduct;
            }
          }
        });
        String? selectedQuestionId=surveyModel!.steps![provider.questionsIndex].type == "question"
            ? surveyModel!.steps![provider.questionsIndex].value?.id.toString()
            : surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].id.toString();

        // selectedInputs[selectedQuestionId][condition.id]
      }
      // }catch(e){
      //   print("Error in condition part : $e" );
      // }
    });
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   provider.setCheckValue("");
    // });
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

  data(){

    setName(null);
    setType(null);
    setCustomerType(null);
    setUrl(null);
    setAddess1(null);
    setAddress2(null);
    setCity(null);
    setZip(null);
    setCountry(null);
    setState(null);
    setPhone(null);
    setVatId(null);
    setFax(null);
    setTermsOfPayment(null);
    setComapnyId(null);
    setCameBackCheck(false);
  }

  Future<bool> loadJsonData() async{
    bool check=false;
    final String response = await rootBundle.loadString("assets/files/surveyJson4.js");
    var data= await jsonDecode(response);
    Welcome2 model=Welcome2.fromJson(data);
    model.steps?.forEach((step) {
      if(step.type == "question"){
        questions.add(step.value);
      }else{
        if(step.type == "chapter"){
          step.value?.questions?.forEach((chapterQuestions) {
            questions.add(chapterQuestions.value);
          });
        }
      }
    });
    surveyModel=model;
    if(data != null){
      check=true;
    }
    return check;
  }


int get questionsIndex => _questionsIndex;
int get chaptersQuestionsIndex => _chaptersQuestionIndex;
bool get questionCheck => _questionCheck;
int? get selectedOptionsIndex => _selectedOptionsIndex;
String? get  checkValue => _checkValue;
bool get checkForMultiType => _checkForMultiType;
  UserModel? get userModel => _userModel;
  AllCompaniesModel? get allCompaniesModel => _allCompaniesModel;
  LoginModel? get loginModel => _loginModel;

//create company form
String? get name => _name;
  String? get type => _type;
  String? get customerType => _customerType;
  String? get url => _url;
  String? get address1 => _addess1;
  String? get address2 => _address2;
  String? get city => _city;
  String? get zip => _zip;
  String? get country => _country;
  String? get state => _state;
  String? get vatId => _vatId;
  String? get phone => _phone;
  int? get fax => _fax;
  String? get termsOfPayment => _termsOfPayment;
  String? get companyId => _companyId;
  bool get cameBack => _cameBack ?? false;

  String? get defaultLocationId => _defaultLocationId;
  Location? get selectedValueForLocation => _selectedValueForLocation;
  bool get checkForDialog => _checkForDialog;

//ContactReport models
  DropDownValueModel? get contactReportCompany => _contactReportCompany;
  DropDownValueModel? get contactReportCategory => _contactReportCategory;
  List<DropDownValueModel> get contactReportTalkToPeople => _contactReportTalkToPeople;
  List<DropDownValueModel> get contactReportEmployee => _contactReportEmployee;
  DropDownValueModel? get contactReportCreatedBy => _contactReportCreatedBy;
  String? get contactReportInitiatedBy => _contactReportInitiatedBy;
  String? get contactReportContactType => _contactReportContactType;
  String? get contactReportType => _contactReporttype;
  String? get contactReportPriority => _contactReportPriority;
  String? get contactReportQuillText => _quillText;
  String? get contactReportSubjectText => _contactReportSubjectText;

      //initial values contact report form
  String? get contactReportinitialValueSubjectText => _contactReportinitialValueSubjectText;
  String? get contactReportinitialValueQuillText => _contactReportinitialValueQuillText;
  String? get contactReportinitialValueType => _contactReportinitialValueType;
  String? get contactReportinitialValueCompany => _contactReportinitialValueCompany;
  List<String>? get contactReportinitialValueTalkedToPeople => _contactReportinitialValueTalkedToPeople;
  List<String>? get contactReportinitialValueEmployee => _contactReportinitialValueEmployee;
  String? get contactReportinitialValueCreatedBy => _contactReportinitialValueCreatedBy;
  String? get contactReportinitialValuePriority => _contactReportinitialValuePriority;
  String? get contactReportinitialValueCategory => _contactReportinitialValueCategory;
  String? get contactReportinitialValueContactType => _contactReportinitialValueContactType;
  String? get contactReportinitialValueInitiatedBy => _contactReportinitialValueInitiatedBy;


}