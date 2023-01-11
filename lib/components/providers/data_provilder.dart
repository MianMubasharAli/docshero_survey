import 'dart:convert';

import 'package:dart_eval/dart_eval.dart';
import 'package:docshero/components/models/option2.dart';
import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/option_product2_model.dart';
import '../models/survey_model.dart';
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





setCheckForMultiType(bool check){
  _checkForMultiType=check;
  notifyListeners();
}
setCheckValue(String? s){
  _checkValue=s;
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


bool isJSON(str) {
  try {
    var a=jsonDecode(str);
    a;
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

executeFormula(OptionProduct2 item){
if(item.quantity == 0) return 1;
bool a=isInt(item.quantity);
if(a==true){
  return int.parse(item.quantity.toString());
}
if(checkForFormula(item.quantity)){
  RegExp regExp = new RegExp(
    r"\$(\w+)",
    caseSensitive: false,
    multiLine: false,
  );
  var quantity=item.quantity;
  final matches=regExp.allMatches(item.quantity.toString());
  matches.forEach((match) {
    print(match.group(0));
    print(match.group(1));
    Option2? foundOption;
    if(surveyModel!.steps![questionsIndex].type == "question"){
      foundOption=surveyModel!.steps![questionsIndex].value!.configuration!.options!.firstWhereOrNull((option) {
        return option.title?.toLowerCase() == match.group(1).toString().toLowerCase();
      });
      if(foundOption != null){
        quantity = quantity.replaceAll(
            "\$${match.group(1)}",
            foundOption.value.toString()
        );
        print(quantity);
      }
    }
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
result(quantity){
var numberInputs=jsonDecode(quantity);
int result=0;
numberInputs.forEach((input) {
  if(input['operator'] != null){
    String condition="$result ${input["operator"]} ${calculateResult(input)}";
    // Expression exp = Expression(condition);
    String abc=eval(condition).toString();
    result=int.parse(abc);
  }else{
    result= calculateResult(input);
  }
});
return result;
}

calculateResult(numberInput){

  int result = 0;
  List numberInputList=numberInput["parenthesis"];
  if(numberInputList.length == 0){
    Option2? option;
    if(surveyModel!.steps![questionsIndex].type == "question"){
      option = (surveyModel!.steps![questionsIndex].value!.configuration!.options ?? []
      ).firstWhereOrNull((option) => option.id == numberInput["id"]);
    }else{
      option = (surveyModel!.steps![questionsIndex].value!.questions![chaptersQuestionsIndex].configuration2!.options ?? []
      ).firstWhereOrNull((option) => option.id == numberInput["id"]);
    }

    result = option?.value.round() ?? int.parse(numberInput["value"].toString());
  }else{
    Option2? option;
    if(surveyModel!.steps![questionsIndex].type == "question"){
      option = (surveyModel!.steps![questionsIndex].value!.configuration!.options ?? []
      ).firstWhereOrNull((option) => option.id == numberInput["id"]);
    }else{
      option = (surveyModel!.steps![questionsIndex].value!.questions![chaptersQuestionsIndex].configuration2!.options ?? []
      ).firstWhereOrNull((option) => option.id == numberInput["id"]);
    }

    result= int.parse(option?.value.toString() ?? numberInput["value"].toString());
    numberInputList.forEach((input){
      String condition="$result ${input["operator"]} ${calculateResult(input)}";
      // Expression exp = Expression(condition);
      String abc=eval(condition).toString();
      result=int.parse(abc);
    });
  }
  return result;
}




int get questionsIndex => _questionsIndex;
int get chaptersQuestionsIndex => _chaptersQuestionIndex;
bool get questionCheck => _questionCheck;
int? get selectedOptionsIndex => _selectedOptionsIndex;
String? get  checkValue => _checkValue;
bool get checkForMultiType => _checkForMultiType;
}