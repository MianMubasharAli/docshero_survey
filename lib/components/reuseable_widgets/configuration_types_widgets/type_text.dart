import 'dart:convert';

import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/option_product2_model.dart';
import '../../providers/data_provilder.dart';
import 'package:dart_eval/dart_eval.dart';

class TypeText extends StatefulWidget {
   TypeText({
     required this.index,
     Key? key}) : super(key: key);
int index;
  @override
  State<TypeText> createState() => _TypeTextState();
}

class _TypeTextState extends State<TypeText> {
  TextEditingController controller=TextEditingController();
  int  check=0;
  Set localProductList=new Set();
  Set localProductListIds = new Set();
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    DataProvider provider=Provider.of<DataProvider>(context,listen: false);
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child:
                provider.surveyModel!.steps![provider.questionsIndex].type == "question" ?
                SizedBox(
                  width: size.width * 0.35,
                  child: mediumText("${provider.surveyModel?.steps?[provider.questionsIndex].value?.configuration?.options?[widget.index].title}",
                      color: kBlackColor,
                      maxLines: 3,
                      softWrap: false,
                      size: size.width * 0.06),
                ) :
                SizedBox(
                  width: size.width * 0.35,
                  child: mediumText("${provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].value?.configuration?.options?[widget.index].title}",
                      color: kBlackColor,
                      maxLines: 3,
                      softWrap: false,
                      size: size.width * 0.06),
                ),

              ),
              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.05,
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "${
                        provider.surveyModel!.steps![provider.questionsIndex].type == "question" ?
                        provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].placeholder :
                        provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].value?.configuration!.options![widget.index].placeholder
                    }",
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: kWhiteColor,
                    filled: true,
                    isDense: true,
                  ),
                  onChanged: (onChanged){
                    // if(onChanged.isNotEmpty ){
                    //   if( check==0){
                    //   if(provider.surveyModel!.steps![provider.questionsIndex].type == "question"){
                    //     for(int i=0; i<provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products!.length ; i++){
                    //       bool checkExistenceOfProduct=false;
                    //       int? matchingIndex;
                    //       for(int j=0;j< provider.productList.length; j++){
                    //         if(provider.productList[j].id == provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].id){
                    //           checkExistenceOfProduct=true;
                    //           matchingIndex=j;
                    //         }
                    //       }
                    //       if(checkExistenceOfProduct==true){
                    //         int index= provider.productList.indexWhere((element) {
                    //           return element.id==provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].id;
                    //         });
                    //         var encodedFoundProduct=jsonEncode(provider.productList[index]);
                    //         Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
                    //         OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);
                    //
                    //         bool? isContains=foundProduct.belongsTo?.contains(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id!);
                    //         if(!isContains!){
                    //           foundProduct.belongsTo?.add(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id!);
                    //         }
                    //         foundProduct.quantity=foundProduct.quantity + provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].quantity;
                    //         foundProduct.salePrice= (int.parse(foundProduct.quantity.toString()) *
                    //             int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].salePrice.toString())).toString();
                    //         provider.productList[index]=foundProduct;
                    //
                    //         // provider.productList[matchingIndex!].quantity=provider.productList[matchingIndex].quantity + 1;
                    //       }else{
                    //         OptionProduct2 product=provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i];
                    //         var encoded=jsonEncode(product);
                    //         Map<String, dynamic> decoded=jsonDecode(encoded) as Map<String, dynamic>;
                    //         OptionProduct2 modifiedProduct=OptionProduct2.fromJson(decoded);
                    //         modifiedProduct.belongsTo?.add(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id!);
                    //         provider.productList.add(modifiedProduct);
                    //       }
                    //       //localProductList.add(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i]);
                    //     }
                    //   }else{
                    //     for(int i=0; i<provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options![widget.index].products!.length ; i++){
                    //       bool checkExistenceOfProduct=false;
                    //       int? matchingIndex;
                    //       for(int j=0;j< provider.productList.length; j++){
                    //         if(provider.productList[j].id == provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options![widget.index].products![i].id){
                    //           checkExistenceOfProduct=true;
                    //           matchingIndex=j;
                    //         }
                    //       }
                    //
                    //       if(checkExistenceOfProduct==true){
                    //         int index= provider.productList.indexWhere((element) {
                    //           return element.id==provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options![widget.index].products![i].id;
                    //         });
                    //
                    //         var encodedFoundProduct=jsonEncode(provider.productList[index]);
                    //         Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
                    //         OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);
                    //
                    //         bool? isContains=foundProduct.belongsTo?.contains(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options![widget.index].id!);
                    //         if(!isContains!){
                    //           foundProduct.belongsTo?.add(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options![widget.index].id!);
                    //         }
                    //         foundProduct.quantity=foundProduct.quantity + provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options![widget.index].products![i].quantity;
                    //         foundProduct.salePrice= (int.parse(foundProduct.quantity.toString()) *
                    //             int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options![widget.index].products![i].salePrice.toString())).toString();
                    //         provider.productList[index]=foundProduct;
                    //
                    //         // provider.productList[matchingIndex!].quantity=provider.productList[matchingIndex].quantity + 1;
                    //       }else{
                    //         OptionProduct2 product=provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options![widget.index].products![i];
                    //         var encoded=jsonEncode(product);
                    //         Map<String, dynamic> decoded=jsonDecode(encoded) as Map<String, dynamic>;
                    //         OptionProduct2 modifiedProduct=OptionProduct2.fromJson(decoded);
                    //         modifiedProduct.belongsTo?.add(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options![widget.index].id!);
                    //         provider.productList.add(modifiedProduct);
                    //
                    //       }
                    //     }
                    //   }
                    //   check=1;
                    //   setState((){
                    //     provider.setCheckValue("1");
                    //   });
                    //   }
                    //
                    //     provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options?[widget.index].value = onChanged;
                    //
                    //
                    //   localProductList=new Set();
                    //   localProductListIds=new Set();
                    //   if(provider.surveyModel!.steps![provider.questionsIndex].type == "question"){
                    //     provider.productList.forEach((element) {
                    //       element.belongsTo?.forEach((element2) {
                    //         provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.conditionsForProductSelection?.forEach((element3) {
                    //           String? discount=element3.discount;
                    //           element3.options?.forEach((element4) {
                    //             String? condition="";
                    //
                    //             List<String> conditionList=[];
                    //             int checkIndexForConditionString=0;
                    //             element3.options?.forEach((option) {
                    //               checkIndexForConditionString++;
                    //               bool abc= option.condition == "contains" ?
                    //               eval("(\"${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options?[widget.index].value.toString()}\""
                    //                   "${".contains(\"${option.value}\")"} )") :
                    //               eval("(\"!${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options?[widget.index].value.toString()}\""
                    //                   "${".contains(\"${option.value}\")"} )");
                    //               conditionList.add("$abc ${ checkIndexForConditionString < element3.options!.length ? element3.options![checkIndexForConditionString].optionOperator : ""}  ");
                    //             });
                    //             condition=conditionList.join("");
                    //             Expression exp = Expression(condition);
                    //
                    //             if(exp.eval().toString() == "0"){
                    //               if(element2 == element3.id){
                    //                 int index=provider.productList.indexWhere((element2) {
                    //                   return element.id==element2.id;
                    //                 });
                    //                 if(index != null){
                    //                   localProductList.add(index);
                    //                   localProductListIds.add(element2);
                    //                 }
                    //               }
                    //             }
                    //           });
                    //         });
                    //       });
                    //     });
                    //
                    //     for(var element in localProductList.toList().reversed){
                    //       localProductListIds.forEach((element2) {
                    //         if(provider.productList[element].belongsTo!.contains(element2)){
                    //           int index=provider.productList[element].belongsTo!.indexWhere((element3) {
                    //             return element2==element3;
                    //           });
                    //           provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.conditionsForProductSelection?.forEach((conditionForProductSelection) {
                    //             double discount=double.parse(conditionForProductSelection.discount.toString());
                    //             if(conditionForProductSelection.id == element2){
                    //               conditionForProductSelection.products?.forEach((product) {
                    //                 if(provider.productList[element].id == product.id){
                    //                   provider.productList[element].quantity = provider.productList[element].quantity - product.quantity;
                    //                   provider.productList[element].salePrice=(provider.productList[element].quantity * int.parse(product.salePrice.toString())).toString();
                    //                 }
                    //               });
                    //             }
                    //           });
                    //           provider.productList[element].belongsTo?.removeAt(index);
                    //         }
                    //       });
                    //       if(provider.productList[element].belongsTo?.length == 0){
                    //         provider.productList.removeAt(element);
                    //       }
                    //
                    //     }
                    //
                    //     provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.conditionsForProductSelection?.forEach((element) {
                    //       String? discount=element.discount;
                    //       String? condition="";
                    //
                    //       List<String> conditionList=[];
                    //       int checkIndexForConditionString=0;
                    //       element.options?.forEach((option) {
                    //         checkIndexForConditionString++;
                    //         bool abc= option.condition == "contains" ?
                    //         eval("(\"${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options?[widget.index].value.toString()}\""
                    //             "${".contains(\"${option.value}\")"} )") :
                    //         eval("(\"!${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options?[widget.index].value.toString()}\""
                    //             "${".contains(\"${option.value}\")"} )");
                    //         conditionList.add("$abc ${ checkIndexForConditionString < element.options!.length ? element.options![checkIndexForConditionString].optionOperator : ""}  ");
                    //       });
                    //       condition=conditionList.join("");
                    //       Expression exp = Expression(condition);
                    //
                    //       if(exp.eval().toString() == "1"){
                    //         element.products?.forEach((element3) {
                    //           bool checkExistenceOfProduct=false;
                    //           int? matchingIndex;
                    //           // print(provider.productList.length);
                    //           for(int j=0;j< provider.productList.length; j++){
                    //             if(provider.productList[j].id == element3.id){
                    //               checkExistenceOfProduct=true;
                    //               matchingIndex=j;
                    //             }
                    //           }
                    //
                    //           if(checkExistenceOfProduct == true){
                    //             int index= provider.productList.indexWhere((element4) {
                    //               return element4.id == element3.id;
                    //             });
                    //
                    //             var encodedFoundProduct=jsonEncode(provider.productList[index]);
                    //             Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
                    //             OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);
                    //
                    //             bool? isContains=foundProduct.belongsTo?.contains(element.id);
                    //             if(!isContains!){
                    //               foundProduct.belongsTo?.add(element.id!);
                    //             }
                    //             List? belong=foundProduct.belongsTo;
                    //             var unique=belong?.toSet().toList();
                    //             foundProduct.belongsTo=unique;
                    //             foundProduct.quantity=foundProduct.quantity + element3.quantity;
                    //             foundProduct.salePrice= (foundProduct.quantity * int.parse(element3.salePrice.toString())  -
                    //                 (foundProduct.quantity *
                    //                     int.parse(element3.salePrice.toString()) *
                    //                     int.parse(discount.toString())) / 100).toString();
                    //             print(foundProduct.salePrice);
                    //             if(exp.eval().toString() == "1"){
                    //               provider.productList[index]=foundProduct;
                    //             }
                    //           }else{
                    //             OptionProduct2 product=element3;
                    //             var encoded=jsonEncode(product);
                    //             Map<String, dynamic> decoded=jsonDecode(encoded) as Map<String, dynamic>;
                    //             OptionProduct2 modifiedProduct=OptionProduct2.fromJson(decoded);
                    //             modifiedProduct.belongsTo?.add(element.id!);
                    //             modifiedProduct.belongsTo?.toSet().toList();
                    //             if(exp.eval().toString() == "1"){
                    //               provider.productList.add(modifiedProduct);
                    //             }
                    //
                    //           }
                    //
                    //         });
                    //       }
                    //       // }
                    //       // });
                    //     });
                    //
                    //   }
                    //   else{
                    //     if(provider.surveyModel!.steps![provider.questionsIndex].type == "chapter"){
                    //
                    //       provider.productList.forEach((element) {
                    //         element.belongsTo?.forEach((element2) {
                    //           provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.conditionsForProductSelection?.forEach((element3) {
                    //             String? discount=element3.discount;
                    //             element3.options?.forEach((element4) {
                    //               String? condition="";
                    //
                    //               List<String> conditionList=[];
                    //               int checkIndexForConditionString=0;
                    //               element3.options?.forEach((option) {
                    //                 checkIndexForConditionString++;
                    //                 bool abc= option.condition == "contains" ?
                    //                 eval("(\"${provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options?[widget.index].value.toString()}\""
                    //                     "${".contains(\"${option.value}\")"} )") :
                    //                 eval("(\"!${provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options?[widget.index].value.toString()}\""
                    //                     "${".contains(\"${option.value}\")"} )");
                    //                 conditionList.add("$abc ${ checkIndexForConditionString < element3.options!.length ? element3.options![checkIndexForConditionString].optionOperator : ""}  ");
                    //               });
                    //               condition=conditionList.join(" ");
                    //               Expression exp = Expression(condition);
                    //
                    //               if(exp.eval().toString() == "0"){
                    //                 if(element2 == element3.id){
                    //                   int index=provider.productList.indexWhere((element2) {
                    //                     return element.id==element2.id;
                    //                   });
                    //                   if(index != null){
                    //                     localProductList.add(index);
                    //                     localProductListIds.add(element2);
                    //                   }
                    //                 }
                    //               }
                    //             });
                    //           });
                    //         });
                    //       });
                    //
                    //       for(var element in localProductList.toList().reversed){
                    //         if( provider.productList[element].quantity > 1){
                    //           provider.productList[element].quantity=provider.productList[element].quantity - 1;
                    //           localProductListIds.forEach((element2) {
                    //             if(provider.productList[element].belongsTo!.contains(element2)){
                    //               int index=provider.productList[element].belongsTo!.indexWhere((element3) {
                    //                 return element2==element3;
                    //               });
                    //               provider.productList[element].belongsTo?.removeAt(index);
                    //             }
                    //           });
                    //         }else{
                    //           provider.productList.removeAt(element);
                    //         }
                    //       }
                    //       provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.conditionsForProductSelection?.forEach((element) {
                    //         String? discount=element.discount;
                    //         String? condition="";
                    //         List<String> conditionList=[];
                    //         int checkIndexForConditionString=0;
                    //         element.options?.forEach((option) {
                    //           checkIndexForConditionString++;
                    //           bool abc= option.condition == "contains" ?
                    //           eval("(\"${provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options?[widget.index].value.toString()}\""
                    //               "${".contains(\"${option.value}\")"} )") :
                    //           eval("(\"!${provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options?[widget.index].value.toString()}\""
                    //               "${".contains(\"${option.value}\")"} )");
                    //           conditionList.add("$abc ${ checkIndexForConditionString < element.options!.length ? element.options![checkIndexForConditionString].optionOperator : ""}  ");
                    //         });
                    //
                    //         condition=conditionList.join(" ");
                    //         Expression exp = Expression(condition);
                    //
                    //         if(exp.eval().toString() == "1"){
                    //           element.products?.forEach((element3) {
                    //             bool checkExistenceOfProduct=false;
                    //             int? matchingIndex;
                    //             // print(provider.productList.length);
                    //             for(int j=0;j< provider.productList.length; j++){
                    //               if(provider.productList[j].id == element3.id){
                    //                 checkExistenceOfProduct=true;
                    //                 matchingIndex=j;
                    //               }
                    //             }
                    //
                    //             if(checkExistenceOfProduct == true){
                    //               int index= provider.productList.indexWhere((element4) {
                    //                 return element4.id == element3.id;
                    //               });
                    //               OptionProduct2 foundProduct=provider.productList[index];
                    //               bool? isContains=foundProduct.belongsTo?.contains(element.id);
                    //               if(!isContains!){
                    //                 foundProduct.belongsTo?.add(element.id!);
                    //               }
                    //               List? belong=foundProduct.belongsTo;
                    //               var unique=belong?.toSet().toList();
                    //               foundProduct.belongsTo=unique;
                    //               foundProduct.quantity=foundProduct.quantity + element3.quantity;
                    //               foundProduct.salePrice= (foundProduct.quantity * int.parse(element3.salePrice.toString())  -
                    //                   (foundProduct.quantity *
                    //                       int.parse(element3.salePrice.toString()) *
                    //                       int.parse(discount.toString())) / 100).toString();
                    //               print(foundProduct.salePrice);
                    //               if(exp.eval().toString() == "1"){
                    //                 provider.productList[index]=foundProduct;
                    //               }
                    //             }else{
                    //               OptionProduct2 product=element3;
                    //               OptionProduct2 modifiedProduct=product;
                    //               modifiedProduct.belongsTo?.add(element.id!);
                    //               modifiedProduct.belongsTo?.toSet().toList();
                    //               if(exp.eval().toString() == "1"){
                    //                 provider.productList.add(modifiedProduct);
                    //               }
                    //
                    //             }
                    //
                    //           });
                    //         }
                    //         // }
                    //         // });
                    //       });
                    //
                    //     }
                    //   }
                    //
                    //    setState((){
                    //     provider.setCheckValue("1");
                    //   });
                    // }
                    // else{
                    //   if(provider.surveyModel!.steps![provider.questionsIndex].type == "question") {
                    //     localProductList=new Set();
                    //     localProductListIds=new Set();
                    //     provider.productList.forEach((element) { //cart products
                    //       //selected option
                    //       element.belongsTo?.forEach((element2) {
                    //         print("${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id}");
                    //         if(element2 == provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id ){
                    //           for(int i=0; i < provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options!.length ; i++){
                    //             if(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id ==
                    //                 provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![i].id){
                    //               if(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![i].id == element2){
                    //                 int index=provider.productList.indexWhere((element2) {
                    //
                    //                   return element.id==element2.id;
                    //                 });
                    //                 if(index != null){
                    //                   localProductList.add(index);
                    //                   localProductListIds.add(element2);
                    //                 }
                    //               }
                    //             }else{
                    //
                    //             }
                    //           }
                    //         }
                    //       });
                    //
                    //     });
                    //     for(int element in localProductList.toList().reversed){
                    //
                    //       localProductListIds.forEach((element2) {
                    //         if(provider.productList[element].belongsTo!.contains(element2)){
                    //           int index=provider.productList[element].belongsTo!.indexWhere((element3) {
                    //             return element2==element3;
                    //           });
                    //           provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options!.forEach((option) {
                    //             if(option.id == element2){
                    //               option.products?.forEach((product) {
                    //                 if(provider.productList[element].id == product.id){
                    //
                    //                   provider.productList[element].quantity=provider.productList[element].quantity - product.quantity;
                    //                   provider.productList[element].salePrice=(provider.productList[element].quantity * int.parse(product.salePrice.toString())).toString();
                    //                 }
                    //               });
                    //             }
                    //           });
                    //           provider.productList[element].belongsTo?.removeAt(index);
                    //         }
                    //       });
                    //       if(provider.productList[element].quantity == 0){
                    //         provider.productList.removeAt(element);
                    //       }
                    //     }
                    //
                    //
                    //   }
                    //   else{
                    //     localProductList=new Set();
                    //     localProductListIds=new Set();
                    //     provider.productList.forEach((element) { //cart products
                    //       //selected option
                    //       element.belongsTo?.forEach((element2) {
                    //         print("${provider.surveyModel!.steps![provider.questionsIndex].value!.questions?[provider.chaptersQuestionsIndex].configuration?.options![widget.index].id}");
                    //         if(element2 == provider.surveyModel!.steps![provider.questionsIndex].value!.questions?[provider.chaptersQuestionsIndex].configuration?.options![widget.index].id ){
                    //           for(int i=0; i < provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options!.length ; i++){
                    //             if(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options![widget.index].id ==
                    //                 provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options![i].id){
                    //               if(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options![i].id == element2){
                    //                 int index=provider.productList.indexWhere((element2) {
                    //
                    //                   return element.id==element2.id;
                    //                 });
                    //                 if(index != null){
                    //                   localProductList.add(index);
                    //                   localProductListIds.add(element2);
                    //                 }
                    //               }
                    //             }else{
                    //
                    //             }
                    //           }
                    //         }
                    //       });
                    //
                    //     });
                    //     for(var element in localProductList.toList().reversed){
                    //       localProductListIds.forEach((element2) {
                    //         if(provider.productList[element].belongsTo!.contains(element2)){
                    //           int index=provider.productList[element].belongsTo!.indexWhere((element3) {
                    //             return element2==element3;
                    //           });
                    //           provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options!.forEach((option) {
                    //             if(option.id == element2){
                    //               option.products?.forEach((product) {
                    //                 if(provider.productList[element].id == product.id){
                    //
                    //                   provider.productList[element].quantity=provider.productList[element].quantity - product.quantity;
                    //                   provider.productList[element].salePrice=(provider.productList[element].quantity * int.parse(product.salePrice.toString())).toString();
                    //                 }
                    //               });
                    //             }
                    //           });
                    //           provider.productList[element].belongsTo?.removeAt(index);
                    //         }
                    //       });
                    //       if(provider.productList[element].quantity == 0){
                    //         provider.productList.removeAt(element);
                    //       }
                    //     }
                    //   }
                    //
                    //   setState(() {
                    //     provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options?[widget.index].value = onChanged;
                    //   });
                    //
                    //   localProductList=new Set();
                    //   localProductListIds=new Set();
                    //
                    //   if(provider.surveyModel!.steps![provider.questionsIndex].type == "question"){
                    //     provider.productList.forEach((element) {
                    //       element.belongsTo?.forEach((element2) {
                    //         provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.conditionsForProductSelection?.forEach((element3) {
                    //           String? discount=element3.discount;
                    //           element3.options?.forEach((element4) {
                    //             String? condition="";
                    //
                    //             List<String> conditionList=[];
                    //             int checkIndexForConditionString=0;
                    //             element3.options?.forEach((option) {
                    //               checkIndexForConditionString++;
                    //               bool abc= option.condition == "contains" ?
                    //               eval("(\"${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options?[widget.index].value.toString()}\""
                    //                   "${".contains(\"${option.value}\")"} )") :
                    //               eval("(\"!${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options?[widget.index].value.toString()}\""
                    //                   "${".contains(\"${option.value}\")"} )");
                    //               conditionList.add("$abc ${ checkIndexForConditionString < element3.options!.length ? element3.options![checkIndexForConditionString].optionOperator : ""}  ");
                    //             });
                    //             condition=conditionList.join("");
                    //             Expression exp = Expression(condition);
                    //
                    //             if(exp.eval().toString() == "0"){
                    //               if(element2 == element3.id){
                    //                 int index=provider.productList.indexWhere((element2) {
                    //                   return element.id==element2.id;
                    //                 });
                    //                 if(index != null){
                    //                   localProductList.add(index);
                    //                   localProductListIds.add(element2);
                    //                 }
                    //               }
                    //             }
                    //           });
                    //         });
                    //       });
                    //     });
                    //
                    //     for(var element in localProductList.toList().reversed){
                    //       localProductListIds.forEach((element2) {
                    //         if(provider.productList[element].belongsTo!.contains(element2)){
                    //           int index=provider.productList[element].belongsTo!.indexWhere((element3) {
                    //             return element2==element3;
                    //           });
                    //           provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.conditionsForProductSelection?.forEach((conditionForProductSelection) {
                    //             double discount=double.parse(conditionForProductSelection.discount.toString());
                    //             if(conditionForProductSelection.id == element2){
                    //               conditionForProductSelection.products?.forEach((product) {
                    //                 if(provider.productList[element].id == product.id){
                    //                   provider.productList[element].quantity = provider.productList[element].quantity - product.quantity;
                    //                   provider.productList[element].salePrice=(provider.productList[element].quantity * int.parse(product.salePrice.toString())).toString();
                    //                 }
                    //               });
                    //             }
                    //           });
                    //           provider.productList[element].belongsTo?.removeAt(index);
                    //         }
                    //       });
                    //       if(provider.productList[element].belongsTo?.length == 0){
                    //         provider.productList.removeAt(element);
                    //       }
                    //
                    //     }
                    //
                    //     provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.conditionsForProductSelection?.forEach((element) {
                    //       String? discount=element.discount;
                    //       String? condition="";
                    //
                    //       List<String> conditionList=[];
                    //       int checkIndexForConditionString=0;
                    //       element.options?.forEach((option) {
                    //         checkIndexForConditionString++;
                    //         bool abc= option.condition == "contains" ?
                    //         eval("(\"${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options?[widget.index].value.toString()}\""
                    //             "${".contains(\"${option.value}\")"} )") :
                    //         eval("(\"!${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options?[widget.index].value.toString()}\""
                    //             "${".contains(\"${option.value}\")"} )");
                    //         conditionList.add("$abc ${ checkIndexForConditionString < element.options!.length ? element.options![checkIndexForConditionString].optionOperator : ""}  ");
                    //       });
                    //       condition=conditionList.join("");
                    //       Expression exp = Expression(condition);
                    //
                    //       if(exp.eval().toString() == "1"){
                    //         element.products?.forEach((element3) {
                    //           bool checkExistenceOfProduct=false;
                    //           int? matchingIndex;
                    //           // print(provider.productList.length);
                    //           for(int j=0;j< provider.productList.length; j++){
                    //             if(provider.productList[j].id == element3.id){
                    //               checkExistenceOfProduct=true;
                    //               matchingIndex=j;
                    //             }
                    //           }
                    //
                    //           if(checkExistenceOfProduct == true){
                    //             int index= provider.productList.indexWhere((element4) {
                    //               return element4.id == element3.id;
                    //             });
                    //
                    //             var encodedFoundProduct=jsonEncode(provider.productList[index]);
                    //             Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
                    //             OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);
                    //
                    //             bool? isContains=foundProduct.belongsTo?.contains(element.id);
                    //             if(!isContains!){
                    //               foundProduct.belongsTo?.add(element.id!);
                    //             }
                    //             List? belong=foundProduct.belongsTo;
                    //             var unique=belong?.toSet().toList();
                    //             foundProduct.belongsTo=unique;
                    //             foundProduct.quantity=foundProduct.quantity + element3.quantity;
                    //             foundProduct.salePrice= (foundProduct.quantity * int.parse(element3.salePrice.toString())  -
                    //                 (foundProduct.quantity *
                    //                     int.parse(element3.salePrice.toString()) *
                    //                     int.parse(discount.toString())) / 100).toString();
                    //             print(foundProduct.salePrice);
                    //             if(exp.eval().toString() == "1"){
                    //               provider.productList[index]=foundProduct;
                    //             }
                    //           }else{
                    //             OptionProduct2 product=element3;
                    //             var encoded=jsonEncode(product);
                    //             Map<String, dynamic> decoded=jsonDecode(encoded) as Map<String, dynamic>;
                    //             OptionProduct2 modifiedProduct=OptionProduct2.fromJson(decoded);
                    //             modifiedProduct.belongsTo?.add(element.id!);
                    //             modifiedProduct.belongsTo?.toSet().toList();
                    //             if(exp.eval().toString() == "1"){
                    //               provider.productList.add(modifiedProduct);
                    //             }
                    //
                    //           }
                    //
                    //         });
                    //       }
                    //       // }
                    //       // });
                    //     });
                    //
                    //   }else{
                    //     if(provider.surveyModel!.steps![provider.questionsIndex].type == "chapter"){
                    //
                    //       provider.productList.forEach((element) {
                    //         element.belongsTo?.forEach((element2) {
                    //           provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.conditionsForProductSelection?.forEach((element3) {
                    //             String? discount=element3.discount;
                    //             element3.options?.forEach((element4) {
                    //               String? condition="";
                    //
                    //               List<String> conditionList=[];
                    //               int checkIndexForConditionString=0;
                    //               element3.options?.forEach((option) {
                    //                 checkIndexForConditionString++;
                    //                 bool abc= option.condition == "contains" ?
                    //                 eval("(\"${provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options?[widget.index].value.toString()}\""
                    //                     "${".contains(\"${option.value}\")"} )") :
                    //                 eval("(\"!${provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options?[widget.index].value.toString()}\""
                    //                     "${".contains(\"${option.value}\")"} )");
                    //                 conditionList.add("$abc ${ checkIndexForConditionString < element3.options!.length ? element3.options![checkIndexForConditionString].optionOperator : ""}  ");
                    //               });
                    //               condition=conditionList.join("");
                    //               Expression exp = Expression(condition);
                    //
                    //               if(exp.eval().toString() == "0"){
                    //                 if(element2 == element3.id){
                    //                   int index=provider.productList.indexWhere((element2) {
                    //                     return element.id==element2.id;
                    //                   });
                    //                   if(index != null){
                    //                     localProductList.add(index);
                    //                     localProductListIds.add(element2);
                    //                   }
                    //                 }
                    //               }
                    //             });
                    //           });
                    //         });
                    //       });
                    //
                    //       for(var element in localProductList.toList().reversed){
                    //         if( provider.productList[element].quantity > 1){
                    //           provider.productList[element].quantity=provider.productList[element].quantity - 1;
                    //           localProductListIds.forEach((element2) {
                    //             if(provider.productList[element].belongsTo!.contains(element2)){
                    //               int index=provider.productList[element].belongsTo!.indexWhere((element3) {
                    //                 return element2==element3;
                    //               });
                    //               provider.productList[element].belongsTo?.removeAt(index);
                    //             }
                    //           });
                    //         }else{
                    //           provider.productList.removeAt(element);
                    //         }
                    //       }
                    //
                    //       provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.conditionsForProductSelection?.forEach((element) {
                    //         String? discount=element.discount;
                    //         String? condition="";
                    //
                    //         List<String> conditionList=[];
                    //         int checkIndexForConditionString=0;
                    //         element.options?.forEach((option) {
                    //           checkIndexForConditionString++;
                    //           bool abc= option.condition == "contains" ?
                    //           eval("(\"${provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options?[widget.index].value.toString()}\""
                    //               "${".contains(\"${option.value}\")"} )") :
                    //           eval("(\"!${provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration!.options?[widget.index].value.toString()}\""
                    //               "${".contains(\"${option.value}\")"} )");
                    //           conditionList.add("$abc ${ checkIndexForConditionString < element.options!.length ? element.options![checkIndexForConditionString].optionOperator : ""}  ");
                    //         });
                    //         condition=conditionList.join("");
                    //         Expression exp = Expression(condition);
                    //
                    //         if(exp.eval().toString() == "1"){
                    //           element.products?.forEach((element3) {
                    //             bool checkExistenceOfProduct=false;
                    //             int? matchingIndex;
                    //             // print(provider.productList.length);
                    //             for(int j=0;j< provider.productList.length; j++){
                    //               if(provider.productList[j].id == element3.id){
                    //                 checkExistenceOfProduct=true;
                    //                 matchingIndex=j;
                    //               }
                    //             }
                    //
                    //             if(checkExistenceOfProduct == true){
                    //               int index= provider.productList.indexWhere((element4) {
                    //                 return element4.id == element3.id;
                    //               });
                    //               OptionProduct2 foundProduct=provider.productList[index];
                    //               bool? isContains=foundProduct.belongsTo?.contains(element.id);
                    //               if(!isContains!){
                    //                 foundProduct.belongsTo?.add(element.id!);
                    //               }
                    //               List? belong=foundProduct.belongsTo;
                    //               var unique=belong?.toSet().toList();
                    //               foundProduct.belongsTo=unique;
                    //               foundProduct.quantity=foundProduct.quantity + element3.quantity;
                    //               foundProduct.salePrice= (foundProduct.quantity * int.parse(element3.salePrice.toString())  -
                    //                   (foundProduct.quantity *
                    //                       int.parse(element3.salePrice.toString()) *
                    //                       int.parse(discount.toString())) / 100).toString();
                    //               print(foundProduct.salePrice);
                    //               if(exp.eval().toString() == "1"){
                    //                 provider.productList[index]=foundProduct;
                    //               }
                    //             }else{
                    //               OptionProduct2 product=element3;
                    //               OptionProduct2 modifiedProduct=product;
                    //               modifiedProduct.belongsTo?.add(element.id!);
                    //               modifiedProduct.belongsTo?.toSet().toList();
                    //               if(exp.eval().toString() == "1"){
                    //                 provider.productList.add(modifiedProduct);
                    //               }
                    //
                    //             }
                    //
                    //           });
                    //         }
                    //         // }
                    //         // });
                    //       });
                    //
                    //     }
                    //   }
                    //   check=0;
                    //   setState((){
                    //     provider.setCheckValue("1");
                    //   });
                    // }
                    if(provider.surveyModel!.steps![provider.questionsIndex].type == "question"){
                      provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options?[widget.index].value = onChanged;
                      provider.optionText(
                          onChanged,
                          provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!,
                          widget.index);
                    }else{
                      provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].value!.configuration!.options?[widget.index].value = onChanged;
                      provider.optionText(
                          onChanged,
                          provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].value!.configuration!,
                          widget.index);
                    }
                      setState((){
                        provider.setCheckValue("1");
                      });

                  },
                  onSaved: (onSaved){

                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
