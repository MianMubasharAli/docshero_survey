import 'package:flutter/material.dart';
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




int get questionsIndex => _questionsIndex;
int get chaptersQuestionsIndex => _chaptersQuestionIndex;
bool get questionCheck => _questionCheck;
int? get selectedOptionsIndex => _selectedOptionsIndex;
String? get  checkValue => _checkValue;
bool get checkForMultiType => _checkForMultiType;
}