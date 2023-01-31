import 'dart:convert';

import 'package:docshero/components/models/configuration2_model.dart';
import 'package:docshero/components/models/option2.dart';
import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/conditions_for_product_selection.dart';
import '../../models/option_product2_model.dart';
import '../../providers/data_provilder.dart';

class TypeNumber extends StatefulWidget {
  TypeNumber({
    required this.index,
    Key? key}) : super(key: key);

  int index;

  @override
  State<TypeNumber> createState() => _TypeNumberState();
}

class _TypeNumberState extends State<TypeNumber> {

  String? checkValue;
  List<Map<String, dynamic>> productListTemporary=[];
  Set localProductList=new Set();
  Set localProductListIds = new Set();
  String? onChanedId;
  Map<String, dynamic> map={};
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
              SizedBox(
                width: size.width * 0.45,
                child: Row(
                  children: [
                    Container(
                      child:
                      provider.surveyModel!.steps![provider.questionsIndex].type == "question" ?
                      SizedBox(
                        width: size.width * 0.4,
                        child: mediumText("${provider.surveyModel?.steps?[provider.questionsIndex].value?.configuration?.options?[widget.index].title}",
                            color: kBlackColor,
                            maxLines: 3,
                            size:  size.shortestSide < 550 ? 20 : 35,
                            softWrap: false),
                      ) :
                      SizedBox(
                        width: size.width * 0.4,
                        child: mediumText("${provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.options?[widget.index].title}",
                            color: kBlackColor,
                            maxLines: 3,
                            size:  size.shortestSide < 550 ? 20 : 35,
                            softWrap: false),
                      ),

                    ),
                  ],
                ),
              ),
              Container(
                width:  size.shortestSide < 550 ? size.width * 0.3 : size.width * 0.4,
                decoration: BoxDecoration(
                    color: kWhiteColor
                ),
                child: Row(
                  children: [
                    Consumer<DataProvider>(
                      builder: (context,data,snap) {

                        if(provider.surveyModel!.steps![provider.questionsIndex].type == "question"){
                          provider.optionSelected(data,provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!,widget.index);
                        }else{
                          provider.optionSelected(data,provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!,widget.index);
                        }

                        WidgetsBinding.instance.addPostFrameCallback((_){
                          provider.setCheckValue(onChanedId);
                        });


                        return Flexible(
                          fit: FlexFit.loose,
                          child: TextFormField(
                            enabled: false,
                            controller:
                            provider.surveyModel!.steps![provider.questionsIndex].type == "question" ?
                            TextEditingController(text: "${
                                provider.surveyModel?.steps?[provider.questionsIndex].value?.configuration?.options?[widget.index].value}")
                                :
                            TextEditingController(text: "${provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.options?[widget.index].value}"),
                            style: TextStyle(
                                color: kBlackColor,
                                fontSize: size.width * 0.05
                            ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: size.width * 0.05
                              ),
                              border: InputBorder.none,
                              fillColor: kWhiteColor,
                              filled: true,
                              isDense: true,
                            ),
                            onChanged: (onChanged){
                              if(onChanged.isNotEmpty){
                                if(provider.surveyModel!.steps![provider.questionsIndex].type == "question"){
                                  provider.surveyModel?.steps?[provider.questionsIndex].value?.configuration?.options?[widget.index].value=int.parse(onChanged);
                                }else{
                                  provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.options?[widget.index].value=int.parse(onChanged);
                                }
                              }
                            },
                            onSaved: (onSaved){
                              if(onSaved != null && onSaved != ""){
                                if(provider.surveyModel!.steps![provider.questionsIndex].type == "question"){
                                  provider.surveyModel?.steps?[provider.questionsIndex].value?.configuration?.options?[widget.index].value=int.parse(onSaved);
                                }else{
                                  provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.options?[widget.index].value=int.parse(onSaved);
                                }                                }
                            },
                          ),
                        );
                      }
                    ),
                    IconButton(onPressed: (){
                      if(provider.surveyModel!.steps![provider.questionsIndex].type == "question"){
                        if(int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].value.toString()) > int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].min.toString())){

                          provider.previousValueMap["${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id}"] = provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].value;

                          setState(() {
                            provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].value=(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].value! - int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].step.toString()));
                          });

                          // if(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].value != 0){
                          //   localProductListIds=new Set();
                          //   localProductList= new Set();
                          //
                          //   provider.productList.forEach((element) {
                          //     element.belongsTo?.forEach((element2) {
                          //       provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.conditionsForProductSelection?.forEach((element3) {
                          //         String? discount=element3.discount;
                          //         element3.options?.forEach((element4) {
                          //           String? operator=element4.optionOperator;
                          //           String? condition="";
                          //
                          //           List<String> conditionList=[];
                          //           int checkIndexForConditionString=0;
                          //           element3.options?.forEach((option) {
                          //             checkIndexForConditionString++;
                          //             conditionList.add("(${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options?[widget.index].value} "
                          //                 "${option.condition} ${option.value}) ${ checkIndexForConditionString < element3.options!.length ? element3.options![checkIndexForConditionString].optionOperator : ""}");
                          //           });
                          //           condition=conditionList.join("");
                          //           Expression exp = Expression(condition);
                          //           if(exp.eval().toString() == "0"){
                          //             if(element2 == element3.id){
                          //               int index=provider.productList.indexWhere((element2) {
                          //                 return element.id==element2.id;
                          //               });
                          //               if(index != null){
                          //                 localProductList.add(index);
                          //                 localProductListIds.add(element2);
                          //               }
                          //             }
                          //           }
                          //         });
                          //       });
                          //     });
                          //   });
                          //
                          //   for(var element in localProductList.toList().reversed){
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
                          //
                          //                   var parsedQuantity=provider.checkForFormula(product.quantity)
                          //                       ? provider.executeFormula(product)
                          //                       : provider.isJSON(product.quantity)
                          //                       ? provider.result(product.quantity)
                          //                       : int.parse(product.quantity.toString());
                          //                   if(provider.isInt(product.quantity)){
                          //
                          //                   }else{
                          //                     provider.productList[element].quantity=provider.productList[element].quantity - int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].step.toString());
                          //                   }
                          //                   provider.productList[element].quantity=provider.productList[element].quantity - parsedQuantity;
                          //                  // provider.productList[element].quantity=provider.productList[element].quantity - product.quantity;
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
                          //   }
                          // }
                          //
                          // if(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].value==0){
                          //   localProductList=new Set();
                          //   localProductListIds=new Set();
                          //
                          //   provider.productList.forEach((element) { //cart products
                          //     //selected option
                          //     element.belongsTo?.forEach((element2) {
                          //       if(element2 == provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id ){
                          //         for(int i=0; i < provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options!.length ; i++){
                          //           if(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id ==
                          //               provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![i].id){
                          //             if(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![i].id == element2){
                          //               int index=provider.productList.indexWhere((element2) {
                          //
                          //                 return element.id==element2.id;
                          //               });
                          //               if(index != null){
                          //                 localProductList.add(index);
                          //                 localProductListIds.add(element2);
                          //               }
                          //             }
                          //           }else{
                          //
                          //           }
                          //         }
                          //       }
                          //     });
                          //   });
                          //   for(int element in localProductList.toList().reversed){
                          //     localProductListIds.forEach((element2) {
                          //       if(provider.productList[element].belongsTo!.contains(element2)){
                          //         int index=provider.productList[element].belongsTo!.indexWhere((element3) {
                          //           return element2==element3;
                          //         });
                          //         provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options!.forEach((option) {
                          //           if(option.id == element2){
                          //             option.products?.forEach((product) {
                          //               if(provider.productList[element].id == product.id){
                          //
                          //                 var parsedQuantity=provider.checkForFormula(product.quantity)
                          //                     ? provider.executeFormula(product)
                          //                     : provider.isJSON(product.quantity)
                          //                     ? provider.result(product.quantity)
                          //                     : int.parse(product.quantity.toString());
                          //                 ////////
                          //                 if(provider.isInt(product.quantity)){
                          //
                          //                 }else{
                          //                   provider.productList[element].quantity=provider.productList[element].quantity - int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].step.toString());
                          //                 }
                          //                 provider.productList[element].quantity=provider.productList[element].quantity - parsedQuantity;
                          //                 //provider.productList[element].quantity=provider.productList[element].quantity - product.quantity;
                          //                 provider.productList[element].salePrice=(provider.productList[element].quantity * int.parse(product.salePrice.toString())).toString();
                          //               }
                          //             });
                          //           }
                          //         });
                          //         provider.productList[element].belongsTo?.removeAt(index);
                          //       }
                          //     });
                          //     if(provider.productList[element].belongsTo?.length == 0){
                          //       provider.productList.removeAt(element);
                          //     }
                          //   }
                          // }
                          //
                          // provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.conditionsForProductSelection?.forEach((element) {
                          //   String? discount=element.discount;
                          //   String? condition="";
                          //   List<String> conditionList=[];
                          //   int checkIndexForConditionString=0;
                          //   element.options?.forEach((element2) {
                          //     checkIndexForConditionString++;
                          //     conditionList.add("(${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options?[widget.index].value} "
                          //         "${element2.condition} ${element2.value}) ${ checkIndexForConditionString < element.options!.length ? element.options![checkIndexForConditionString].optionOperator : ""}");
                          //   });
                          //
                          //   condition=conditionList.join(" ");
                          //   Expression exp = Expression(condition);
                          //
                          //   if(exp.eval().toString() == "1"){
                          //     element.products?.forEach((element3) {
                          //       bool checkExistenceOfProduct=false;
                          //       int? matchingIndex;
                          //       // print(provider.productList.length);
                          //       for(int j=0;j< provider.productList.length; j++){
                          //         if(provider.productList[j].id == element3.id){
                          //           checkExistenceOfProduct=true;
                          //           matchingIndex=j;
                          //         }
                          //       }
                          //
                          //       if(checkExistenceOfProduct == true){
                          //         int index= provider.productList.indexWhere((element4) {
                          //           return element4.id == element3.id;
                          //         });
                          //         var encodedFoundProduct=jsonEncode(provider.productList[index]);
                          //         Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
                          //
                          //         OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);
                          //         bool? isContains=foundProduct.belongsTo?.contains(element.id);
                          //         if(!isContains!){
                          //           foundProduct.belongsTo?.add(element.id!);
                          //         }
                          //         List? belong=foundProduct.belongsTo;
                          //         var unique=belong?.toSet().toList();
                          //         foundProduct.belongsTo=unique;
                          //         var parsedQuantityFoundProduct=provider.checkForFormula(foundProduct.quantity)
                          //             ? provider.executeFormula(foundProduct)
                          //             : provider.isJSON(foundProduct.quantity)
                          //             ? provider.result(foundProduct.quantity)
                          //             : int.parse(foundProduct.quantity.toString());
                          //         var parsedQuantity=provider.checkForFormula(element3.quantity)
                          //             ? provider.executeFormula(element3)
                          //             : provider.isJSON(element3.quantity)
                          //             ? provider.result(element3.quantity)
                          //             : int.parse(element3.quantity.toString());
                          //         foundProduct.quantity=parsedQuantityFoundProduct + parsedQuantity;
                          //         foundProduct.salePrice= (foundProduct.quantity * int.parse(element3.salePrice.toString())  -
                          //             (foundProduct.quantity *
                          //                 int.parse(element3.salePrice.toString()) *
                          //                 int.parse(discount.toString())) / 100).toString();
                          //         print(foundProduct.salePrice);
                          //         if(exp.eval().toString() == "1"){
                          //           provider.productList[index]=foundProduct;
                          //         }
                          //       }else{
                          //         OptionProduct2 product=element3;
                          //         var encoded=jsonEncode(product);
                          //         Map<String, dynamic> decoded=jsonDecode(encoded) as Map<String, dynamic>;
                          //         OptionProduct2 modifiedProduct=OptionProduct2.fromJson(decoded);
                          //         var parsedQuantity=provider.checkForFormula(modifiedProduct.quantity)
                          //             ? provider.executeFormula(modifiedProduct)
                          //             : provider.isJSON(modifiedProduct.quantity)
                          //             ? provider.result(modifiedProduct.quantity)
                          //             : int.parse(modifiedProduct.quantity.toString());
                          //         modifiedProduct.quantity=parsedQuantity;
                          //         modifiedProduct.salePrice=(double.parse(modifiedProduct.quantity.toString()) * double.parse(element3.salePrice.toString())).toString();
                          //         modifiedProduct.belongsTo?.add(element.id!);
                          //         modifiedProduct.belongsTo?.toSet().toList();
                          //         if(exp.eval().toString() == "1"){
                          //           provider.productList.add(modifiedProduct);
                          //         }
                          //
                          //       }
                          //
                          //     });
                          //   }
                          //   // }
                          //   // });
                          // });
                        }
                      }
                      else{
                        if(int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].value.toString())
                            > int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].min.toString())){

                          provider.previousValueMap["${provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].id}"] = provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].value;
                          setState(() {
                            provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].value
                            =(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].value!
                                - int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].step.toString()));
                          });

                          // if(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].value != 0){
                          //   localProductListIds=new Set();
                          //   localProductList= new Set();
                          //
                          //   provider.productList.forEach((element) {
                          //     element.belongsTo?.forEach((element2) {
                          //       provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.conditionsForProductSelection?.forEach((element3) {
                          //         String? discount=element3.discount;
                          //         element3.options?.forEach((element4) {
                          //           bool value=false;
                          //           String? condition="";
                          //           List<String> conditionList=[];
                          //           int checkIndexForConditionString=0;
                          //           element3.options?.forEach((option) {
                          //             checkIndexForConditionString++;
                          //             conditionList.add("(${provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options?[widget.index].value} "
                          //                 "${option.condition} ${option.value}) ${ checkIndexForConditionString < element3.options!.length ? element3.options![checkIndexForConditionString].optionOperator : ""}");
                          //           });
                          //           condition=conditionList.join("");
                          //           Expression exp = Expression(condition);
                          //           if(exp.eval().toString() == "0"){
                          //             if(element2 == element3.id){
                          //               int index=provider.productList.indexWhere((element2) {
                          //                 return element.id==element2.id;
                          //               });
                          //               if(index != null){
                          //                 localProductList.add(index);
                          //                 localProductListIds.add(element2);
                          //               }
                          //             }
                          //           }
                          //         });
                          //       });
                          //     });
                          //   });
                          //
                          //   for(var element in localProductList.toList().reversed){
                          //     localProductListIds.forEach((element2) {
                          //       if(provider.productList[element].belongsTo!.contains(element2)){
                          //         int index=provider.productList[element].belongsTo!.indexWhere((element3) {
                          //           return element2==element3;
                          //         });
                          //         provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.conditionsForProductSelection?.forEach((conditionForProductSelection) {
                          //           double discount=double.parse(conditionForProductSelection.discount.toString());
                          //           if(conditionForProductSelection.id == element2){
                          //             conditionForProductSelection.products?.forEach((product) {
                          //               if(provider.productList[element].id == product.id){
                          //
                          //                 var parsedQuantity=provider.checkForFormula(product.quantity)
                          //                     ? provider.executeFormula(product)
                          //                     : provider.isJSON(product.quantity)
                          //                     ? provider.result(product.quantity)
                          //                     : int.parse(product.quantity.toString());
                          //
                          //                 if(provider.isInt(product.quantity)){
                          //
                          //                 }else{
                          //                   provider.productList[element].quantity=provider.productList[element].quantity - int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].step.toString());
                          //                 }
                          //                 provider.productList[element].quantity=provider.productList[element].quantity - parsedQuantity;
                          //                 // provider.productList[element].quantity=provider.productList[element].quantity - product.quantity;
                          //                 provider.productList[element].salePrice=(provider.productList[element].quantity * double.parse(product.salePrice.toString())).toString();
                          //               }
                          //             });
                          //           }
                          //         });
                          //         provider.productList[element].belongsTo?.removeAt(index);
                          //       }
                          //     });
                          //     if(provider.productList[element].quantity == 0){
                          //       provider.productList.removeAt(element);
                          //     }
                          //
                          //   }
                          // }
                          //
                          //
                          // if(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].value == 0){
                          //   provider.productList.forEach((element) { //cart products
                          //     //selected option
                          //     element.belongsTo?.forEach((element2) {
                          //       print("${provider.surveyModel!.steps![provider.questionsIndex].value!.questions?[provider.chaptersQuestionsIndex].configuration2?.options![widget.index].id}");
                          //       if(element2 == provider.surveyModel!.steps![provider.questionsIndex].value!.questions?[provider.chaptersQuestionsIndex].configuration2?.options![widget.index].id ){
                          //         for(int i=0; i < provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options!.length ; i++){
                          //           if(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].id ==
                          //               provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![i].id){
                          //             if(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![i].id == element2){
                          //               int index=provider.productList.indexWhere((element2) {
                          //
                          //                 return element.id==element2.id;
                          //               });
                          //               if(index != null){
                          //                 localProductList.add(index);
                          //                 localProductListIds.add(element2);
                          //               }
                          //             }
                          //           }else{
                          //
                          //           }
                          //         }
                          //       }
                          //     });
                          //
                          //   });
                          //   for(int element in localProductList.toList().reversed){
                          //
                          //     localProductListIds.forEach((element2) {
                          //       if(provider.productList[element].belongsTo!.contains(element2)){
                          //         int index=provider.productList[element].belongsTo!.indexWhere((element3) {
                          //           return element2==element3;
                          //         });
                          //         provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options!.forEach((option) {
                          //           if(option.id == element2){
                          //             option.products?.forEach((product) {
                          //               if(provider.productList[element].id == product.id){
                          //                 var parsedQuantity=provider.checkForFormula(product.quantity)
                          //                     ? provider.executeFormula(product)
                          //                     : provider.isJSON(product.quantity)
                          //                     ? provider.result(product.quantity)
                          //                     : int.parse(product.quantity.toString());
                          //
                          //                 if(provider.isInt(product.quantity)){
                          //
                          //                 }else{
                          //                   provider.productList[element].quantity=provider.productList[element].quantity - int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].step.toString());
                          //                 }
                          //                 provider.productList[element].quantity=provider.productList[element].quantity - parsedQuantity;
                          //                 provider.productList[element].salePrice=(provider.productList[element].quantity * int.parse(product.salePrice.toString())).toString();
                          //               }
                          //             });
                          //           }
                          //         });
                          //         provider.productList[element].belongsTo?.removeAt(index);
                          //       }
                          //     });
                          //     if(provider.productList[element].quantity == 0){
                          //       provider.productList.removeAt(element);
                          //     }
                          //   }
                          // }
                          //
                          // provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.conditionsForProductSelection?.forEach((element) {
                          //   String? discount=element.discount;
                          //   String? condition="";
                          //   List<String> conditionList=[];
                          //   int checkIndexForConditionString=0;
                          //   element.options?.forEach((element2) {
                          //     checkIndexForConditionString++;
                          //     conditionList.add("(${provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options?[widget.index].value} "
                          //         "${element2.condition} ${element2.value}) ${ checkIndexForConditionString < element.options!.length ? element.options![checkIndexForConditionString].optionOperator : ""}");
                          //   });
                          //
                          //   condition=conditionList.join(" ");
                          //   Expression exp = Expression(condition);
                          //   print(exp.eval().toString());
                          //
                          //
                          //   if(exp.eval().toString() == "1"){
                          //     element.products?.forEach((element3) {
                          //       bool checkExistenceOfProduct=false;
                          //       int? matchingIndex;
                          //       // print(provider.productList.length);
                          //       for(int j=0;j< provider.productList.length; j++){
                          //         if(provider.productList[j].id == element3.id){
                          //           checkExistenceOfProduct=true;
                          //           matchingIndex=j;
                          //         }
                          //       }
                          //
                          //       if(checkExistenceOfProduct == true){
                          //         int index= provider.productList.indexWhere((element4) {
                          //           return element4.id == element3.id;
                          //         });
                          //         var encodedFoundProduct=jsonEncode(provider.productList[index]);
                          //         Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
                          //
                          //         OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);
                          //         bool? isContains=foundProduct.belongsTo?.contains(element.id);
                          //         if(!isContains!){
                          //           foundProduct.belongsTo?.add(element.id!);
                          //         }
                          //         List? belong=foundProduct.belongsTo;
                          //         var unique=belong?.toSet().toList();
                          //         foundProduct.belongsTo=unique;
                          //         var parsedQuantityFoundProduct=provider.checkForFormula(foundProduct.quantity)
                          //             ? provider.executeFormula(foundProduct)
                          //             : provider.isJSON(foundProduct.quantity)
                          //             ? provider.result(foundProduct.quantity)
                          //             : int.parse(foundProduct.quantity.toString());
                          //         var parsedQuantity=provider.checkForFormula(element3.quantity)
                          //             ? provider.executeFormula(element3)
                          //             : provider.isJSON(element3.quantity)
                          //             ? provider.result(element3.quantity)
                          //             : int.parse(element3.quantity.toString());
                          //         foundProduct.quantity=parsedQuantityFoundProduct + parsedQuantity;
                          //         foundProduct.salePrice= (foundProduct.quantity * int.parse(element3.salePrice.toString())  -
                          //             (foundProduct.quantity *
                          //                 int.parse(element3.salePrice.toString()) *
                          //                 int.parse(discount.toString())) / 100).toString();
                          //         if(exp.eval().toString() == "1"){
                          //           provider.productList[index]=foundProduct;
                          //         }
                          //       }else{
                          //         OptionProduct2 product=element3;
                          //
                          //         var encoded=jsonEncode(product);
                          //         Map<String, dynamic> decoded=jsonDecode(encoded) as Map<String, dynamic>;
                          //         OptionProduct2 modifiedProduct=OptionProduct2.fromJson(decoded);
                          //
                          //         modifiedProduct.belongsTo?.add(element.id!);
                          //         var parsedQuantity=provider.checkForFormula(modifiedProduct.quantity)
                          //             ? provider.executeFormula(modifiedProduct)
                          //             : provider.isJSON(modifiedProduct.quantity)
                          //             ? provider.result(modifiedProduct.quantity)
                          //             : int.parse(modifiedProduct.quantity.toString());
                          //         modifiedProduct.quantity=parsedQuantity;
                          //         modifiedProduct.salePrice=(double.parse(modifiedProduct.quantity.toString()) * double.parse(element3.salePrice.toString())).toString();
                          //         modifiedProduct.belongsTo?.toSet().toList();
                          //         if(exp.eval().toString() == "1"){
                          //           provider.productList.add(modifiedProduct);
                          //         }
                          //
                          //       }
                          //
                          //     });
                          //   }
                          //   // }
                          //   // });
                          // });
                        }
                      }
                      // setState(() {
                      //   provider.setCheckValue(onChanedId);
                      // });

                    },
                        icon: Icon(Icons.remove,color: kGreenColor,size: size.width * 0.07,),
                        constraints: size.shortestSide < 550 ? BoxConstraints() : BoxConstraints(minHeight: 48,minWidth: 48),
                        padding: size.shortestSide < 550 ? EdgeInsets.only() :EdgeInsets.only(right: 30,),),
                    IconButton(onPressed: (){
                      if(provider.surveyModel!.steps![provider.questionsIndex].type == "question"){
                        if(int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].value.toString()) < int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].max.toString())){


                          // if(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].value == 0){
                          //   localProductList=new Set();
                          //   localProductListIds= new Set();
                          //
                          //   for(int i=0; i<provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products!.length ; i++){
                          //     bool checkExistenceOfProduct=false;
                          //     int? matchingIndex;
                          //     print(provider.productList.length);
                          //     for(int j=0;j< provider.productList.length; j++){
                          //       if(provider.productList[j].id == provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].id){
                          //         checkExistenceOfProduct=true;
                          //         matchingIndex=j;
                          //       }
                          //     }
                          //     if(checkExistenceOfProduct==true){
                          //       int index= provider.productList.indexWhere((element) {
                          //         return element.id==provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].id;
                          //       });
                          //
                          //       var encodedFoundProduct=jsonEncode(provider.productList[index]);
                          //       Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
                          //       OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);
                          //
                          //       bool? isContains=foundProduct.belongsTo?.contains(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id!);
                          //       if(!isContains!){
                          //         foundProduct.belongsTo?.add(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id!);
                          //       }
                          //       var parsedQuantityForFoundProduct=provider.checkForFormula(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].quantity)
                          //           ? provider.executeFormula(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i])
                          //           : provider.isJSON(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].quantity)
                          //           ? provider.result(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].quantity)
                          //           : int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].quantity.toString());
                          //       var parsedQuantity=provider.checkForFormula(foundProduct.quantity)
                          //           ? provider.executeFormula(foundProduct)
                          //           : provider.isJSON(foundProduct.quantity)
                          //           ? provider.result(foundProduct.quantity)
                          //           : int.parse(foundProduct.quantity.toString());
                          //
                          //       foundProduct.quantity=parsedQuantityForFoundProduct + parsedQuantity;
                          //       foundProduct.salePrice=(foundProduct.quantity * int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].salePrice.toString())).toString();
                          //       provider.productList[index]=foundProduct;
                          //
                          //       // provider.productList[matchingIndex!].quantity=provider.productList[matchingIndex].quantity + 1;
                          //     }else{
                          //       OptionProduct2 product=provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i];
                          //
                          //       var encoded=jsonEncode(product);
                          //       Map<String, dynamic> decoded=jsonDecode(encoded) as Map<String, dynamic>;
                          //       OptionProduct2 modifiedProduct=OptionProduct2.fromJson(decoded);
                          //
                          //       modifiedProduct.belongsTo?.add(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id!);
                          //       var parsedQuantity=provider.checkForFormula(modifiedProduct.quantity)
                          //           ? provider.executeFormula(modifiedProduct)
                          //           : provider.isJSON(modifiedProduct.quantity)
                          //           ? provider.result(modifiedProduct.quantity)
                          //           : int.parse(modifiedProduct.quantity.toString());
                          //       modifiedProduct.quantity=parsedQuantity;
                          //       modifiedProduct.salePrice=(modifiedProduct.quantity * int.parse(modifiedProduct.salePrice.toString())).toString();
                          //       provider.productList.add(modifiedProduct);
                          //     }
                          //     //localProductList.add(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i]);
                          //   }
                          // }
                          // else{
                          //   provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products?.forEach((product) {
                          //     var parsedQuantity=provider.checkForFormula(product.quantity)
                          //         ? provider.executeFormula(product)
                          //         : provider.isJSON(product.quantity)
                          //         ? provider.result(product.quantity)
                          //         : int.parse(product.quantity.toString());
                          //     int? foundProductIndex = provider.productList.indexWhere((selectedProduct) {
                          //       return selectedProduct.id == product.id;
                          //     });
                          //     if(foundProductIndex == -1) return;
                          //     // OptionProduct2 foundProduct = provider.productList[foundProductIndex];
                          //     var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
                          //     Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
                          //     OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);
                          //
                          //     if(foundProduct.belongsTo!.contains(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id)){
                          //       foundProduct.quantity = foundProduct.quantity - parsedQuantity;
                          //       foundProduct.salePrice
                          //     }
                          //
                          //   });
                          // }

                          provider.previousValueMap["${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id}"] = provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].value;
                            setState(() {
                              provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].value=(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].value! + int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].step.toString()));
                            });



                            // provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.conditionsForProductSelection?.forEach((element) {
                            //   String? discount=element.discount == "" ? "0" : element.discount;
                            //   String? condition="";
                            //   List<String> conditionList=[];
                            //   int checkIndexForConditionString=0;
                            //   element.options?.forEach((element2) {
                            //     checkIndexForConditionString++;
                            //     conditionList.add("(${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options?[widget.index].value} "
                            //         "${element2.condition} ${element2.value}) ${ checkIndexForConditionString < element.options!.length ? element.options![checkIndexForConditionString].optionOperator : ""}");
                            //   });
                            //
                            //   condition=conditionList.join(" ");
                            //   Expression exp = Expression(condition);
                            //
                            //   if(exp.eval().toString() == "1"){
                            //     element.products?.forEach((element3) {
                            //       bool checkExistenceOfProduct=false;
                            //       int? matchingIndex;
                            //       // print(provider.productList.length);
                            //       for(int j=0;j< provider.productList.length; j++){
                            //         if(provider.productList[j].id == element3.id){
                            //           checkExistenceOfProduct=true;
                            //           matchingIndex=j;
                            //         }
                            //       }
                            //
                            //       if(checkExistenceOfProduct == true){
                            //         int index= provider.productList.indexWhere((element4) {
                            //           return element4.id == element3.id;
                            //         });
                            //
                            //         var encodedFoundProduct=jsonEncode(provider.productList[index]);
                            //         Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
                            //         OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);
                            //
                            //         bool? isContains=foundProduct.belongsTo?.contains(element.id);
                            //         if(!isContains!){
                            //           foundProduct.belongsTo?.add(element.id!);
                            //         }
                            //         List? belong=foundProduct.belongsTo;
                            //         var unique=belong?.toSet().toList();
                            //         foundProduct.belongsTo=unique;
                            //         // var parsedQuantityFoundProduct=provider.checkForFormula(foundProduct.quantity)
                            //         //     ? provider.executeFormula(foundProduct)
                            //         //     : provider.isJSON(foundProduct.quantity)
                            //         //     ? provider.result(foundProduct.quantity)
                            //         //     : int.parse(foundProduct.quantity.toString());
                            //         var parsedQuantity=provider.checkForFormula(element3.quantity)
                            //             ? provider.executeFormula(element3)
                            //             : provider.isJSON(element3.quantity)
                            //             ? provider.result(element3.quantity)
                            //             : int.parse(element3.quantity.toString());
                            //         map["${foundProduct.id}"] = foundProduct.quantity;
                            //         foundProduct.quantity=foundProduct.quantity + parsedQuantity;
                            //         foundProduct.salePrice= (foundProduct.quantity * int.parse(element3.salePrice.toString())  -
                            //             (foundProduct.quantity *
                            //                 int.parse(element3.salePrice.toString()) *
                            //                 int.parse(discount.toString())) / 100).toString();
                            //         print(foundProduct.salePrice);
                            //
                            //         if(exp.eval().toString() == "1"){
                            //           provider.productList[index]=foundProduct;
                            //         }
                            //       }
                            //       else{
                            //         OptionProduct2 product=element3;
                            //
                            //         var encoded=jsonEncode(product);
                            //         Map<String, dynamic> decoded=jsonDecode(encoded) as Map<String, dynamic>;
                            //         OptionProduct2 modifiedProduct=OptionProduct2.fromJson(decoded);
                            //
                            //         var parsedQuantity=provider.checkForFormula(modifiedProduct.quantity)
                            //             ? provider.executeFormula(modifiedProduct)
                            //             : provider.isJSON(modifiedProduct.quantity)
                            //             ? provider.result(modifiedProduct.quantity)
                            //             : int.parse(modifiedProduct.quantity.toString());
                            //         modifiedProduct.quantity=parsedQuantity;
                            //         modifiedProduct.salePrice=(double.parse(modifiedProduct.quantity.toString()) * double.parse(element3.salePrice.toString())).toString();
                            //         modifiedProduct.belongsTo?.add(element.id!);
                            //         modifiedProduct.belongsTo?.toSet().toList();
                            //         if(exp.eval().toString() == "1"){
                            //           provider.productList.add(modifiedProduct);
                            //         }
                            //
                            //       }
                            //
                            //     });
                            //   }
                            //   // else{
                            //   //   element.products?.forEach((conditionProduct) {
                            //   //     var parsedQuantity=provider.checkForFormula(conditionProduct.quantity)
                            //   //         ? provider.executeFormula(conditionProduct)
                            //   //         : provider.isJSON(conditionProduct.quantity)
                            //   //         ? provider.result(conditionProduct.quantity)
                            //   //         : int.parse(conditionProduct.quantity.toString());
                            //   //     print(parsedQuantity);
                            //   //   });
                            //   // }
                            //
                            // });
                            //
                            // if(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].value != 0){
                            //   localProductListIds=new Set();
                            //   localProductList= new Set();
                            //
                            //   provider.productList.forEach((element) {
                            //     element.belongsTo?.forEach((element2) {
                            //       provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.conditionsForProductSelection?.forEach((element3) {
                            //         String? discount=element3.discount;
                            //         element3.options?.forEach((element4) {
                            //           String? operator=element4.optionOperator;
                            //           bool value=false;
                            //           String? condition="";
                            //
                            //           List<String> conditionList=[];
                            //           int checkIndexForConditionString=0;
                            //           element3.options?.forEach((option) {
                            //             checkIndexForConditionString++;
                            //             conditionList.add("(${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options?[widget.index].value} "
                            //                 "${option.condition} ${option.value}) ${ checkIndexForConditionString < element3.options!.length ? element3.options![checkIndexForConditionString].optionOperator : ""}");
                            //           });
                            //           condition=conditionList.join("");
                            //           Expression exp = Expression(condition);
                            //           if(exp.eval().toString() == "0"){
                            //             if(element2 == element3.id){
                            //               int index=provider.productList.indexWhere((element2) {
                            //                 return element.id==element2.id;
                            //               });
                            //               if(index != null){
                            //                 localProductList.add(index);
                            //                 localProductListIds.add(element2);
                            //               }
                            //             }
                            //           }
                            //         });
                            //       });
                            //     });
                            //   });
                            //
                            //   for(var element in localProductList.toList().reversed){
                            //     localProductListIds.forEach((element2) {
                            //       if(provider.productList[element].belongsTo!.contains(element2)){
                            //         int index=provider.productList[element].belongsTo!.indexWhere((element3) {
                            //           return element2==element3;
                            //         });
                            //         provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.conditionsForProductSelection?.forEach((conditionForProductSelection) {
                            //           double discount=double.parse(conditionForProductSelection.discount.toString()==""?"0.0":conditionForProductSelection.discount.toString());
                            //           if(conditionForProductSelection.id == element2){
                            //             conditionForProductSelection.products?.forEach((product) {
                            //               if(provider.productList[element].id == product.id){
                            //
                            //
                            //
                            //                 map.forEach((key, value) {
                            //                   print("$key and $value");
                            //                 });
                            //
                            //
                            //
                            //                 var parsedQuantity=provider.checkForFormula(product.quantity)
                            //                     ? provider.executeFormula(product)
                            //                     : provider.isJSON(product.quantity)
                            //                     ? provider.result(product.quantity)
                            //                     : int.parse(product.quantity.toString());
                            //
                            //                // provider.productList[element].quantity = provider.productList[element].quantity + parsedQuantity;
                            //                //  if(provider.isInt(product.quantity)){
                            //                //
                            //                //  }
                            //                //  else{
                            //                //
                            //                //    provider.productList[element].quantity = provider.productList[element].quantity
                            //                //        + int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].step.toString());
                            //                //  }
                            //                 provider.productList[element].quantity=provider.productList[element].quantity - parsedQuantity;
                            //                 //provider.productList[element].quantity=provider.productList[element].quantity - product.quantity;
                            //                 provider.productList[element].salePrice=(provider.productList[element].quantity * int.parse(product.salePrice.toString())).toString();
                            //               }
                            //             });
                            //           }
                            //         });
                            //         provider.productList[element].belongsTo?.removeAt(index);
                            //       }
                            //     });
                            //     if(provider.productList[element].belongsTo?.length == 0){
                            //       provider.productList.removeAt(element);
                            //     }
                            //
                            //   }
                            // }


                        }
                      }
                      else{
                        if(int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].value.toString())
                            < int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].max.toString())){


                          // if(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].value == 0){
                          //   localProductList=new Set();
                          //   localProductListIds= new Set();
                          //   for(int i=0; i<provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products!.length ; i++){
                          //     bool checkExistenceOfProduct=false;
                          //     int? matchingIndex;
                          //     for(int j=0;j< provider.productList.length; j++){
                          //       if(provider.productList[j].id == provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i].id){
                          //         checkExistenceOfProduct=true;
                          //         matchingIndex=j;
                          //       }
                          //     }
                          //
                          //     if(checkExistenceOfProduct==true){
                          //       int index= provider.productList.indexWhere((element) {
                          //         return element.id==provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i].id;
                          //       });
                          //
                          //       var encodedFoundProduct=jsonEncode(provider.productList[index]);
                          //       Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
                          //       OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);
                          //
                          //       bool? isContains=foundProduct.belongsTo?.contains(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].id!);
                          //       if(!isContains!){
                          //         foundProduct.belongsTo?.add(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].id!);
                          //       }
                          //       var parsedQuantityFoundProduct=provider.checkForFormula(foundProduct.quantity)
                          //           ? provider.executeFormula(foundProduct)
                          //           : provider.isJSON(foundProduct.quantity)
                          //           ? provider.result(foundProduct.quantity)
                          //           : int.parse(foundProduct.quantity.toString());
                          //       var parsedQuantity=provider.checkForFormula(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i].quantity)
                          //           ? provider.executeFormula(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i])
                          //           : provider.isJSON(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i].quantity)
                          //           ? provider.result(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i].quantity)
                          //           : int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i].quantity.toString());
                          //       foundProduct.quantity=parsedQuantityFoundProduct + parsedQuantity;
                          //       //foundProduct.quantity=foundProduct.quantity + provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i].quantity;
                          //       foundProduct.salePrice=(foundProduct.quantity * int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i].salePrice.toString())).toString();
                          //       provider.productList[index]=foundProduct;
                          //
                          //       // provider.productList[matchingIndex!].quantity=provider.productList[matchingIndex].quantity + 1;
                          //     }else{
                          //       OptionProduct2 product=provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i];
                          //       var encoded=jsonEncode(product);
                          //       Map<String, dynamic> decoded=jsonDecode(encoded) as Map<String, dynamic>;
                          //       OptionProduct2 modifiedProduct=OptionProduct2.fromJson(decoded);
                          //       var parsedQuantity=provider.checkForFormula(modifiedProduct.quantity)
                          //           ? provider.executeFormula(modifiedProduct)
                          //           : provider.isJSON(modifiedProduct.quantity)
                          //           ? provider.result(modifiedProduct.quantity)
                          //           : int.parse(modifiedProduct.quantity.toString());
                          //       modifiedProduct.quantity=parsedQuantity;
                          //       modifiedProduct.salePrice=(modifiedProduct.quantity * double.parse(modifiedProduct.salePrice.toString())).toString();
                          //       modifiedProduct.belongsTo?.add(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].id!);
                          //       provider.productList.add(modifiedProduct);
                          //
                          //     }
                          //   }
                          //
                          // }

                          provider.previousValueMap["${provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].id}"] = provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].value;
                          setState(() {
                            provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].value
                            =(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].value!
                                + int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].step.toString()));
                          });

                          // provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.conditionsForProductSelection?.forEach((element) {
                          //   String? discount=element.discount;
                          //   String? condition="";
                          //   List<String> conditionList=[];
                          //   int checkIndexForConditionString=0;
                          //   element.options?.forEach((element2) {
                          //     checkIndexForConditionString++;
                          //     conditionList.add("(${provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options?[widget.index].value} "
                          //         "${element2.condition} ${element2.value}) ${ checkIndexForConditionString < element.options!.length ? element.options![checkIndexForConditionString].optionOperator : ""}");
                          //   });
                          //
                          //   condition=conditionList.join(" ");
                          //   Expression exp = Expression(condition);
                          //   print(exp.eval().toString());
                          //
                          //
                          //   if(exp.eval().toString() == "1"){
                          //     element.products?.forEach((element3) {
                          //       bool checkExistenceOfProduct=false;
                          //       int? matchingIndex;
                          //       // print(provider.productList.length);
                          //       for(int j=0;j< provider.productList.length; j++){
                          //         if(provider.productList[j].id == element3.id){
                          //           checkExistenceOfProduct=true;
                          //           matchingIndex=j;
                          //         }
                          //       }
                          //
                          //       if(checkExistenceOfProduct == true){
                          //         int index= provider.productList.indexWhere((element4) {
                          //           return element4.id == element3.id;
                          //         });
                          //
                          //         var encodedFoundProduct=jsonEncode(provider.productList[index]);
                          //         Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
                          //         OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);
                          //
                          //         bool? isContains=foundProduct.belongsTo?.contains(element.id);
                          //         if(!isContains!){
                          //           foundProduct.belongsTo?.add(element.id!);
                          //         }
                          //         List? belong=foundProduct.belongsTo;
                          //         var unique=belong?.toSet().toList();
                          //         foundProduct.belongsTo=unique;
                          //         var parsedQuantityFoundProduct=provider.checkForFormula(foundProduct.quantity)
                          //             ? provider.executeFormula(foundProduct)
                          //             : provider.isJSON(foundProduct.quantity)
                          //             ? provider.result(foundProduct.quantity)
                          //             : int.parse(foundProduct.quantity.toString());
                          //         var parsedQuantity=provider.checkForFormula(element3.quantity)
                          //             ? provider.executeFormula(element3)
                          //             : provider.isJSON(element3.quantity)
                          //             ? provider.result(element3.quantity)
                          //             : int.parse(element3.quantity.toString());
                          //         foundProduct.quantity=parsedQuantityFoundProduct + parsedQuantity;
                          //         foundProduct.salePrice= (foundProduct.quantity * int.parse(element3.salePrice.toString())  -
                          //             (foundProduct.quantity *
                          //                 int.parse(element3.salePrice.toString()) *
                          //                 int.parse(discount.toString())) / 100).toString();
                          //         if(exp.eval().toString() == "1"){
                          //           provider.productList[index]=foundProduct;
                          //         }
                          //       }else{
                          //         OptionProduct2 product=element3;
                          //         var encoded=jsonEncode(product);
                          //         Map<String, dynamic> decoded=jsonDecode(encoded) as Map<String, dynamic>;
                          //         OptionProduct2 modifiedProduct=OptionProduct2.fromJson(decoded);
                          //         modifiedProduct.belongsTo?.add(element.id!);
                          //         var parsedQuantity=provider.checkForFormula(modifiedProduct.quantity)
                          //             ? provider.executeFormula(modifiedProduct)
                          //             : provider.isJSON(modifiedProduct.quantity)
                          //             ? provider.result(modifiedProduct.quantity)
                          //             : int.parse(modifiedProduct.quantity.toString());
                          //         modifiedProduct.quantity=parsedQuantity;
                          //         modifiedProduct.salePrice=(double.parse(modifiedProduct.quantity.toString()) * double.parse(element3.salePrice.toString())).toString();
                          //         modifiedProduct.belongsTo?.toSet().toList();
                          //         if(exp.eval().toString() == "1"){
                          //           provider.productList.add(modifiedProduct);
                          //         }
                          //
                          //       }
                          //
                          //     });
                          //   }
                          //   // }
                          //   // });
                          // });
                          //
                          //
                          // if(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].value != 0){
                          //   localProductListIds=new Set();
                          //   localProductList= new Set();
                          //
                          //   provider.productList.forEach((element) {
                          //     element.belongsTo?.forEach((element2) {
                          //       provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.conditionsForProductSelection?.forEach((element3) {
                          //         String? discount=element3.discount;
                          //         element3.options?.forEach((element4) {
                          //           bool value=false;
                          //           String? condition="";
                          //
                          //           List<String> conditionList=[];
                          //           int checkIndexForConditionString=0;
                          //           element3.options?.forEach((option) {
                          //             checkIndexForConditionString++;
                          //             conditionList.add("(${provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options?[widget.index].value} "
                          //                 "${option.condition} ${option.value}) ${ checkIndexForConditionString < element3.options!.length ? element3.options![checkIndexForConditionString].optionOperator : ""}");
                          //           });
                          //           condition=conditionList.join("");
                          //           Expression exp = Expression(condition);
                          //           if(exp.eval().toString() == "0"){
                          //             if(element2 == element3.id){
                          //               int index=provider.productList.indexWhere((element2) {
                          //                 return element.id==element2.id;
                          //               });
                          //               if(index != null){
                          //                 localProductList.add(index);
                          //                 localProductListIds.add(element2);
                          //               }
                          //             }
                          //           }
                          //         });
                          //       });
                          //     });
                          //   });
                          //
                          //   for(var element in localProductList.toList().reversed){
                          //     localProductListIds.forEach((element2) {
                          //       if(provider.productList[element].belongsTo!.contains(element2)){
                          //         int index=provider.productList[element].belongsTo!.indexWhere((element3) {
                          //           return element2==element3;
                          //         });
                          //         provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.conditionsForProductSelection?.forEach((conditionForProductSelection) {
                          //           double discount=double.parse(conditionForProductSelection.discount.toString());
                          //           if(conditionForProductSelection.id == element2){
                          //             conditionForProductSelection.products?.forEach((product) {
                          //               if(provider.productList[element].id == product.id){
                          //                 var parsedQuantity=provider.checkForFormula(product.quantity)
                          //                     ? provider.executeFormula(product)
                          //                     : provider.isJSON(product.quantity)
                          //                     ? provider.result(product.quantity)
                          //                     : int.parse(product.quantity.toString());
                          //                 if(provider.isInt(product.quantity)){
                          //
                          //                 }else{
                          //                   provider.productList[element].quantity=provider.productList[element].quantity + int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].step.toString());
                          //                 }
                          //                 provider.productList[element].quantity=provider.productList[element].quantity - parsedQuantity;
                          //                 //provider.productList[element].quantity=provider.productList[element].quantity - product.quantity;
                          //                 provider.productList[element].salePrice=(provider.productList[element].quantity * int.parse(product.salePrice.toString())).toString();
                          //
                          //                 // provider.productList[element].quantity=provider.productList[element].quantity - product.quantity;
                          //                 // provider.productList[element].salePrice=(provider.productList[element].quantity * double.parse(product.salePrice.toString())).toString();
                          //               }
                          //             });
                          //           }
                          //         });
                          //         provider.productList[element].belongsTo?.removeAt(index);
                          //       }
                          //     });
                          //     if(provider.productList[element].quantity == 0){
                          //       provider.productList.removeAt(element);
                          //     }
                          //
                          //   }
                          // }


                        }
                      }
                      // setState(() {
                      //   provider.setCheckValue(onChanedId);
                      // });
                    },
                      icon: Icon(Icons.add,color: kGreenColor,size: size.width * 0.07),
                      constraints: size.shortestSide < 550 ? BoxConstraints() : BoxConstraints(minHeight: 48,minWidth: 48),
                      padding: size.shortestSide < 550 ? EdgeInsets.only() :EdgeInsets.only(right: 30,left: 30),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // optionSelected(DataProvider provider, Configuration2 selectedQuestion, int index){
  //   Option2 option=selectedQuestion.options![index];
  //   // if(provider.surveyModel!.steps![provider.questionsIndex].type == "question"){
  //   //   option=  provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index];
  //   // }else{
  //   //     option=  provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index];
  //   // }
  //
  // List<OptionProduct2> selectedProducts = [...?option.products];
  // if(option.value > 0){
  //   selectedProducts.forEach((product) {
  //     var parsedQuantity=provider.checkForFormula(product.quantity)
  //         ? provider.executeFormula(product)
  //         : provider.isJSON(product.quantity)
  //         ? provider.result(product.quantity)
  //         : int.parse(product.quantity.toString());
  //     if(provider.productList.any((cp) => cp.id == product.id)){
  //       int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
  //         return selectedProduct.id== product.id;
  //       });
  //
  //       var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
  //       Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
  //       OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);
  //
  //       foundProduct.quantity = parsedQuantity;
  //       foundProduct.belongsTo?.forEach((optionId) {
  //         if(optionId != option.id){
  //           Option2? foundOption = selectedQuestion.options!.firstWhereOrNull((op) {
  //             return op.id == optionId;
  //           });
  //           ConditionsForProductSelection? foundOption2;
  //           if(foundOption == null){
  //             foundOption2=selectedQuestion.conditionsForProductSelection!.firstWhereOrNull((cond) {
  //               return cond.id == optionId;
  //             });
  //           }
  //           OptionProduct2? foundProductOther2;
  //           if(foundOption != null){
  //             foundProductOther2 = foundOption.products?.firstWhereOrNull((pr){
  //               return pr.id == product.id;
  //             });
  //           }else{
  //             if(foundOption2 != null){
  //               foundProductOther2 = foundOption2.products?.firstWhereOrNull((pr){
  //                 return pr.id == product.id;
  //               });
  //             }
  //           }
  //
  //           var encodedFoundProduct2=jsonEncode(foundProductOther2 ?? {});
  //           Map<String, dynamic> decodedFoundProduct2=jsonDecode(encodedFoundProduct2) as Map<String, dynamic>;
  //           OptionProduct2 foundProductOther=OptionProduct2.fromJson(decodedFoundProduct2);
  //
  //           var parsedQuantityFoundProduct=provider.checkForFormula(foundProductOther.quantity)
  //               ? provider.executeFormula(foundProductOther)
  //               : provider.isJSON(foundProductOther.quantity)
  //               ? provider.result(foundProductOther.quantity)
  //               : int.parse(foundProductOther.quantity.toString());
  //
  //           foundProduct.quantity = foundProduct.quantity + parsedQuantityFoundProduct;
  //
  //
  //         }
  //       });
  //
  //       foundProduct.salePrice = (foundProduct.quantity * double.parse(product.salePrice.toString())).toString();
  //       foundProduct.belongsTo?.add(option.id);
  //
  //       List? belong=foundProduct.belongsTo;
  //       var unique=belong?.toSet().toList();
  //       foundProduct.belongsTo=[...?unique];
  //
  //       var encodedFoundProduct3=jsonEncode(foundProduct);
  //       Map<String, dynamic> decodedFoundProduct3=jsonDecode(encodedFoundProduct3) as Map<String, dynamic>;
  //       OptionProduct2 foundProductOther3=OptionProduct2.fromJson(decodedFoundProduct3);
  //
  //       provider.productList[foundProductIndex] = foundProductOther3;
  //
  //     }else{
  //       var encodedFoundProduct4=jsonEncode(product);
  //       Map<String, dynamic> decodedFoundProduct4=jsonDecode(encodedFoundProduct4) as Map<String, dynamic>;
  //       OptionProduct2 foundProductOther4=OptionProduct2.fromJson(decodedFoundProduct4);
  //
  //       OptionProduct2 cartProduct= foundProductOther4;
  //        cartProduct.quantity= parsedQuantity;
  //       cartProduct.belongsTo?.add(option.id);
  //       cartProduct.salePrice= (parsedQuantity * int.parse(product.salePrice.toString())).toString();
  //       provider.productList.add(cartProduct);
  //     }
  //   });
  // }
  // else{
  //   selectedProducts.forEach((product) {
  //     var parsedQuantity=provider.checkForFormula(product.quantity)
  //         ? provider.executeFormula(product)
  //         : provider.isJSON(product.quantity)
  //         ? provider.result(product.quantity)
  //         : int.parse(product.quantity.toString());
  //     int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
  //       return selectedProduct.id== product.id;
  //     });
  //     if(foundProductIndex == -1) return;
  //     var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
  //     Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
  //     OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);
  //
  //     if(foundProduct.belongsTo!.contains(option.id)){
  //       foundProduct.quantity = foundProduct.quantity - parsedQuantity;
  //       foundProduct.salePrice = (foundProduct.quantity * int.parse(product.salePrice.toString())).toString();
  //       foundProduct.belongsTo = foundProduct.belongsTo?.where((id) {
  //         return id != option.id;
  //       }).toList();
  //       if(foundProduct.belongsTo?.length == 0){
  //         provider.productList.removeAt(foundProductIndex);
  //       }else{
  //         provider.productList[foundProductIndex] = foundProduct;
  //       }
  //     }
  //   });
  // }
  // selectedQuestion.conditionsForProductSelection?.forEach((condition) {
  //   String? conditionString="";
  //     List<String> conditionList=[];
  //     int checkIndexForConditionString=0;
  //     condition.options?.forEach((element2) {
  //       checkIndexForConditionString++;
  //       conditionList.add("(${selectedQuestion.options?[widget.index].value} "
  //           "${element2.condition} ${element2.value}) ${ checkIndexForConditionString < condition.options!.length ? condition.options![checkIndexForConditionString].optionOperator : ""}");
  //     });
  //
  //   conditionString=conditionList.join(" ");
  //     Expression exp = Expression(conditionString);
  //
  //     try{
  //       selectedProducts = [...?condition.products];
  //       if(exp.eval().toString() == "1"){
  //         selectedProducts.forEach((product) {
  //           var parsedQuantity=provider.checkForFormula(product.quantity)
  //               ? provider.executeFormula(product)
  //               : provider.isJSON(product.quantity)
  //               ? provider.result(product.quantity)
  //               : int.parse(product.quantity.toString());
  //           if(provider.productList.any((cp) => cp.id == product.id)){
  //             int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
  //               return selectedProduct.id== product.id;
  //             });
  //
  //             var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
  //             Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
  //             OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);
  //
  //             foundProduct.quantity = parsedQuantity;
  //             foundProduct.belongsTo?.forEach((conditionId) {
  //               if(conditionId != condition.id){
  //                 ConditionsForProductSelection? foundCondition = selectedQuestion.conditionsForProductSelection!.firstWhereOrNull((cond) {
  //                   return cond.id == conditionId;
  //                 });
  //                 Option2? foundCondition2;
  //                 if(foundCondition == null){
  //                   foundCondition2=selectedQuestion.options!.firstWhereOrNull((op) {
  //                     return op.id == conditionId;
  //                   });
  //                 }
  //                 OptionProduct2? foundProductOther2;
  //                 if(foundCondition != null){
  //                   foundProductOther2 = foundCondition.products?.firstWhereOrNull((pr){
  //                     return pr.id == product.id;
  //                   });
  //                 }else{
  //                   if(foundCondition2 != null){
  //                     foundProductOther2 = foundCondition2.products?.firstWhereOrNull((pr){
  //                       return pr.id == product.id;
  //                     });
  //                   }
  //                 }
  //                 var encodedFoundProduct2=jsonEncode(foundProductOther2 ?? {});
  //                 Map<String, dynamic> decodedFoundProduct2=jsonDecode(encodedFoundProduct2) as Map<String, dynamic>;
  //                 OptionProduct2 foundProductOther=OptionProduct2.fromJson(decodedFoundProduct2);
  //
  //                 var parsedQuantityFoundProduct=provider.checkForFormula(foundProductOther.quantity)
  //                     ? provider.executeFormula(foundProductOther)
  //                     : provider.isJSON(foundProductOther.quantity)
  //                     ? provider.result(foundProductOther.quantity)
  //                     : int.parse(foundProductOther.quantity.toString());
  //                 foundProduct.quantity = foundProduct.quantity + parsedQuantityFoundProduct;
  //               }
  //             });
  //
  //             foundProduct.salePrice = (foundProduct.quantity *
  //                 double.parse(product.salePrice.toString())  -
  //                 (foundProduct.quantity *
  //                 double.parse(product.salePrice.toString()) *
  //                 double.parse(condition.discount.toString())) / 100).toString();
  //             foundProduct.belongsTo?.add(condition.id);
  //
  //             List? belong=foundProduct.belongsTo;
  //             var unique=belong?.toSet().toList();
  //             foundProduct.belongsTo=[...?unique];
  //
  //             var encodedFoundProduct3=jsonEncode(foundProduct);
  //             Map<String, dynamic> decodedFoundProduct3=jsonDecode(encodedFoundProduct3) as Map<String, dynamic>;
  //             OptionProduct2 foundProductOther3=OptionProduct2.fromJson(decodedFoundProduct3);
  //
  //             provider.productList[foundProductIndex] = foundProductOther3;
  //
  //           } else{
  //             var encodedFoundProduct4=jsonEncode(product);
  //             Map<String, dynamic> decodedFoundProduct4=jsonDecode(encodedFoundProduct4) as Map<String, dynamic>;
  //             OptionProduct2 foundProductOther4=OptionProduct2.fromJson(decodedFoundProduct4);
  //
  //             OptionProduct2 cartProduct= foundProductOther4;
  //             cartProduct.quantity= parsedQuantity;
  //             cartProduct.belongsTo?.add(condition.id);
  //             cartProduct.salePrice =
  //                 (parsedQuantity *
  //                     int.parse(product.salePrice.toString()) -
  //                     (parsedQuantity * int.parse(product.salePrice.toString()) *
  //                         double.parse(condition.discount.toString())) / 100).toString();
  //             provider.productList.add(cartProduct);
  //           }
  //
  //         });
  //
  //       }else{
  //         selectedProducts.forEach((product) {
  //           var parsedQuantity=provider.checkForFormula(product.quantity)
  //               ? provider.executeFormula(product)
  //               : provider.isJSON(product.quantity)
  //               ? provider.result(product.quantity)
  //               : int.parse(product.quantity.toString());
  //           int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
  //             return selectedProduct.id== product.id;
  //           });
  //           if(foundProductIndex == -1) return;
  //           var encodedFoundProduct=jsonEncode(provider.productList[foundProductIndex]);
  //           Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
  //           OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);
  //
  //           if(foundProduct.belongsTo!.contains(condition.id)){
  //             foundProduct.quantity = foundProduct.quantity - parsedQuantity;
  //             foundProduct.salePrice =
  //                 (foundProduct.quantity *
  //                     (int.parse(product.salePrice.toString()) -
  //                     (int.parse(product.salePrice.toString()) *
  //                     double.parse(condition.discount.toString())) / 100 )
  //                 ).toString();
  //             foundProduct.belongsTo = foundProduct.belongsTo?.where((id) {
  //               return id != condition.id;
  //             }).toList();
  //             if(foundProduct.belongsTo?.length == 0){
  //               provider.productList.removeAt(foundProductIndex);
  //             }else{
  //               provider.productList[foundProductIndex] = foundProduct;
  //             }
  //           }
  //
  //
  //         });
  //       }
  //     }catch(e){
  //       print("Error in condition part : $e" );
  //     }
  // });
  // }

}