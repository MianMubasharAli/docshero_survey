import 'dart:convert';

import 'package:docshero/components/models/conditions_for_product_selection.dart';
import 'package:docshero/components/models/option2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../models/option_product2_model.dart';
import '../../providers/data_provilder.dart';
class TypeSingle extends StatefulWidget {
  TypeSingle({
    required this.index,

    Key? key}) : super(key: key);
  int index;

  @override
  State<TypeSingle> createState() => _TypeSingleState();
}

class _TypeSingleState extends State<TypeSingle> {

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    DataProvider provider=Provider.of<DataProvider>(context,listen: false);
    Set localProductList=new Set();
    Set localProductListIds = new Set();
    return Container(
      child: Column(
        children: [
          RadioListTile(
              dense: true,
              title:
              provider.surveyModel?.steps?[provider.questionsIndex].type == "question" ?
              Text("${provider.surveyModel?.steps?[provider.questionsIndex].value?.configuration?.options?[widget.index].title}",style: TextStyle(fontSize: size.width * 0.05),) :
              Text("${provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.options?[widget.index].title}",style: TextStyle(fontSize: size.width * 0.05)),
              value:
              provider.surveyModel?.steps?[provider.questionsIndex].type == "question" ?
              provider.surveyModel?.steps![provider.questionsIndex].value?.configuration?.options![widget.index].id :
              provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.options?[widget.index].id,
              groupValue: Provider.of<DataProvider>(context,listen: true).checkValue,
              onChanged: (onChanged){
                localProductList=new Set();
                localProductListIds=new Set();
                if(provider.surveyModel?.steps?[provider.questionsIndex].type == "question"){
                  provider.productList.forEach((element) {//cart products
                    //selected option
                    element.belongsTo?.forEach((element2) {
                      if(element2 != provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id ){

                        for(int i=0; i < provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options!.length ; i++){
                          if(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id ==
                              provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![i].id){

                          }else{
                            if(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![i].id == element2){
                              int index=provider.productList.indexWhere((element2) {

                                return element.id==element2.id;
                              });
                              if(index != null){
                                localProductList.add(index);
                                localProductListIds.add(element2);
                              }
                            }
                          }
                        }
                      }
                    });
                  });
                  for(int element in localProductList.toList().reversed){

                         localProductListIds.forEach((element2) {
                           if(provider.productList[element].belongsTo!.contains(element2)){
                             int index=provider.productList[element].belongsTo!.indexWhere((element3) {
                               return element2==element3;
                             });
                             provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options!.forEach((option) {
                               if(option.id == element2){
                                 option.products?.forEach((product) {
                                   if(provider.productList[element].id == product.id){

                                     provider.productList[element].quantity=provider.productList[element].quantity - product.quantity;
                                     provider.productList[element].salePrice=(provider.productList[element].quantity * int.parse(product.salePrice.toString())).toString();
                                   }
                                 });
                               }
                             });
                             provider.productList[element].belongsTo?.removeAt(index);
                           }
                         });
                      if(provider.productList[element].quantity == 0){
                        provider.productList.removeAt(element);
                      }
                  }
                  for(int i=0; i<provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products!.length ; i++){
                    bool checkExistenceOfProduct=false;
                    int? matchingIndex;
                    print(provider.productList.length);
                    for(int j=0;j< provider.productList.length; j++){
                      if(provider.productList[j].id == provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].id){
                        checkExistenceOfProduct=true;
                        matchingIndex=j;
                      }
                    }
                    if(checkExistenceOfProduct==true){
                     int index= provider.productList.indexWhere((element) {
                        return element.id==provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].id;
                      });

                     var encodedFoundProduct=jsonEncode(provider.productList[index]);
                     Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;

                     OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);

                     bool? isContains=foundProduct.belongsTo?.contains(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id!);
                    if(!isContains!){
                      foundProduct.belongsTo?.add(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id!);
                    }
                    foundProduct.quantity=foundProduct.quantity + provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].quantity;


                    foundProduct.salePrice= (int.parse(foundProduct.quantity.toString()) *
                        int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].salePrice.toString())).toString();
                    provider.productList[index]=foundProduct;

                     // provider.productList[matchingIndex!].quantity=provider.productList[matchingIndex].quantity + 1;
                    }else{

                      OptionProduct2 product=provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i];
                      var encoded=jsonEncode(product);
                      Map<String, dynamic> decoded=jsonDecode(encoded) as Map<String, dynamic>;
                      OptionProduct2 modifiedProduct=OptionProduct2.fromJson(decoded);
                      modifiedProduct.belongsTo?.add(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id!);
                      provider.productList.add(modifiedProduct);
                    }
                    //localProductList.add(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i]);
                  }

                }else{
                  if(provider.surveyModel?.steps?[provider.questionsIndex].type == "chapter"){

                    provider.productList.forEach((element) { //cart products
                      //selected option
                      element.belongsTo?.forEach((element2) {
                        if(element2 != provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].id){
                          for(int i=0; i < provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options!.length ; i++){
                            if(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].id ==
                                provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![i].id){

                            }else{
                              if(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![i].id == element2){
                                int index=provider.productList.indexWhere((element2) {

                                  return element.id==element2.id;
                                });
                                if(index != null){
                                  localProductList.add(index);
                                  localProductListIds.add(element2);
                                }
                              }
                            }
                          }
                        }
                      });

                    });

                    for(var element in localProductList.toList().reversed){
                      localProductListIds.forEach((element2) {
                        if(provider.productList[element].belongsTo!.contains(element2)){
                          int index=provider.productList[element].belongsTo!.indexWhere((element3) {
                            return element2==element3;
                          });
                          provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options!.forEach((option) {
                            if(option.id == element2){
                              option.products?.forEach((product) {
                                if(provider.productList[element].id == product.id){

                                  provider.productList[element].quantity=provider.productList[element].quantity - product.quantity;
                                  provider.productList[element].salePrice=(provider.productList[element].quantity * int.parse(product.salePrice.toString())).toString();
                                }
                              });
                            }
                          });
                          provider.productList[element].belongsTo?.removeAt(index);
                        }
                      });
                      if(provider.productList[element].quantity == 0){
                        provider.productList.removeAt(element);
                      }
                    }

                    for(int i=0; i<provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products!.length ; i++){
                      bool checkExistenceOfProduct=false;
                      int? matchingIndex;
                      for(int j=0;j< provider.productList.length; j++){
                        if(provider.productList[j].id == provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i].id){
                          checkExistenceOfProduct=true;
                          matchingIndex=j;
                        }
                      }

                      if(checkExistenceOfProduct==true){
                        int index= provider.productList.indexWhere((element) {
                          return element.id==provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i].id;
                        });

                        var encodedFoundProduct=jsonEncode(provider.productList[index]);
                        Map<String, dynamic> decodedFoundProduct=jsonDecode(encodedFoundProduct) as Map<String, dynamic>;
                        OptionProduct2 foundProduct=OptionProduct2.fromJson(decodedFoundProduct);

                        bool? isContains=foundProduct.belongsTo?.contains(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].id!);
                        if(!isContains!){
                          foundProduct.belongsTo?.add(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].id!);
                        }
                        foundProduct.quantity=foundProduct.quantity + provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i].quantity;
                        foundProduct.salePrice= (int.parse(foundProduct.quantity.toString()) *
                            int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i].salePrice.toString())).toString();
                        provider.productList[index]=foundProduct;
                      }else{
                        OptionProduct2 product=provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i];
                        var encoded=jsonEncode(product);
                        Map<String, dynamic> decoded=jsonDecode(encoded) as Map<String, dynamic>;
                        OptionProduct2 modifiedProduct=OptionProduct2.fromJson(decoded);
                        modifiedProduct.belongsTo?.add(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].id!);
                        provider.productList.add(modifiedProduct);

                      }
                    }
                  }
                }

              // calculations(widget.index);
                  provider.setCheckValue(onChanged);

              })
        ],
      ),
    );
  }

  // calculations2(int index){
  //   DataProvider provider=Provider.of<DataProvider>(context,listen: false);
  //   provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options!.forEach((option) {
  //     List<OptionProduct2>? selectedProducts = option.products;
  //     if(option.id == provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![index].id){
  //       selectedProducts?.forEach((product) {
  //         var parsedQuantity = product.quantity;
  //
  //         if(provider.productList.any((cp) => cp.id == product.id)){
  //           int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
  //             return selectedProduct.id == product.id;
  //           });
  //           OptionProduct2 foundProduct= provider.productList[foundProductIndex];
  //           foundProduct.quantity= parsedQuantity;
  //           foundProduct.belongsTo?.forEach((optionId) {
  //             if(optionId != option.id){
  //               Option2 foundOption= provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options!.firstWhere((op) {
  //                 return op.id == optionId;
  //               });
  //               OptionProduct2? foundProductOther = foundOption.products!.firstWhere((pr) {
  //                 return pr.id == product.id;
  //               });
  //
  //               var parsedQuantityFoundProduct= foundProductOther.quantity;
  //
  //               foundProduct.quantity = foundProduct.quantity + parsedQuantityFoundProduct;
  //             }
  //           });
  //           foundProduct.salePrice = (foundProduct.quantity * int.parse(product.salePrice.toString())).toString();
  //           foundProduct.belongsTo?.add(option.id!);
  //           Set uniqueSet= foundProduct.belongsTo!.toSet();
  //           List uniqueItems= uniqueSet.toList();
  //           foundProduct.belongsTo=uniqueItems;
  //           provider.productList[foundProductIndex]=foundProduct;
  //         }else{
  //           OptionProduct2 cartProduct=product;
  //           cartProduct.belongsTo=[option.id!];
  //           cartProduct.salePrice = (parsedQuantity * int.parse(product.salePrice.toString())).toString();
  //           provider.productList.add(cartProduct);
  //         }
  //       });
  //     } else {
  //       selectedProducts?.forEach((product) {
  //         var parsedQuantity= product.quantity;
  //         int foundProdcutIndex= provider.productList.indexWhere((selectedProduct) {
  //           return selectedProduct.id == product.id;
  //         });
  //         if(foundProdcutIndex == -1) return;
  //         OptionProduct2 foundProduct= provider.productList[foundProdcutIndex];
  //         if(foundProduct.belongsTo!.contains(option.id)){
  //           foundProduct.quantity = foundProduct.quantity - parsedQuantity;
  //           foundProduct.salePrice = (foundProduct.quantity * int.parse(product.salePrice.toString())).toString();
  //           foundProduct.belongsTo = foundProduct.belongsTo?.where((id) {
  //             return id != option.id;
  //           }).toList();
  //           if(foundProduct.belongsTo?.length == 0){
  //             provider.productList.removeAt(foundProdcutIndex);
  //           }else{
  //             provider.productList[foundProdcutIndex]=foundProduct;
  //           }
  //
  //         }
  //       });
  //     }
  //   });
  // }
  // calculations(int index){
  //   DataProvider provider=Provider.of<DataProvider>(context,listen: false);
  //   provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options!.forEach((option) {
  //     List<OptionProduct2>? selectedProducts = [...?option.products];
  //     if(option.id == provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![index].id){
  //       selectedProducts.forEach((product) {
  //         var parsedQuantity = product.quantity;
  //
  //           if(provider.productList.any((cp) => cp.id == product.id)){
  //             int foundProductIndex = provider.productList.indexWhere((selectedProduct) {
  //               return selectedProduct.id == product.id;
  //             });
  //             OptionProduct2 foundProduct=OptionProduct2.fromJson(jsonDecode(OptionProduct2ToJson(provider.productList[foundProductIndex])));
  //
  //             foundProduct.quantity= parsedQuantity;
  //             foundProduct.belongsTo?.forEach((optionId) {
  //               if(optionId != option.id){
  //                 Option2? foundOption= provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options!.firstWhereOrNull((op) => op.id == optionId );
  //                 ConditionsForProductSelection? foundOption2;
  //                 if(foundOption == null){
  //                   foundOption2=provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.conditionsForProductSelection!.firstWhereOrNull((cond) => cond.id == optionId );
  //                 }
  //                 OptionProduct2? foundProductOther = foundOption != null ? foundOption.products!.firstWhere((pr) {
  //                   return pr.id == product.id;
  //                 })
  //
  //                 :
  //                     foundOption2 != null ? foundOption2.products!.firstWhere((pr) {
  //                       return pr.id == product.id;
  //                     })
  //                 :
  //                 null;
  //
  //                 if(foundProductOther != null){
  //                   var parsedQuantityFoundProduct= foundProductOther.quantity;
  //                   foundProduct.quantity = foundProduct.quantity + parsedQuantityFoundProduct;
  //                 }
  //                }
  //             });
  //             foundProduct.salePrice = (foundProduct.quantity * int.parse(product.salePrice.toString())).toString();
  //             foundProduct.belongsTo?.add(option.id!);
  //             Set uniqueSet= foundProduct.belongsTo!.toSet();
  //             List uniqueItems= uniqueSet.toList();
  //             foundProduct.belongsTo=uniqueItems;
  //             provider.productList[foundProductIndex]=foundProduct;
  //           }else{
  //             OptionProduct2 cartProduct=OptionProduct2.fromJson(jsonDecode(OptionProduct2ToJson(product)) ) ;
  //             cartProduct.belongsTo=[option.id!];
  //             cartProduct.salePrice = (parsedQuantity * int.parse(product.salePrice.toString())).toString();
  //             provider.productList.add(cartProduct);
  //           }
  //
  //       });
  //     } else {
  //       selectedProducts.forEach((product) {
  //         var parsedQuantity= product.quantity;
  //         int foundProdcutIndex= provider.productList.indexWhere((selectedProduct) {
  //           return selectedProduct.id == product.id;
  //         });
  //         if(foundProdcutIndex == -1) return;
  //         OptionProduct2 foundProduct= OptionProduct2.fromJson(jsonDecode(OptionProduct2ToJson(provider.productList[foundProdcutIndex])) as Map<String, dynamic>);
  //         if(foundProduct.belongsTo!.contains(option.id)){
  //           foundProduct.quantity = foundProduct.quantity - parsedQuantity;
  //           foundProduct.salePrice = (foundProduct.quantity * int.parse(product.salePrice.toString())).toString();
  //           foundProduct.belongsTo = foundProduct.belongsTo?.where((id) {
  //             return id != option.id;
  //           }).toList();
  //           if(foundProduct.belongsTo?.length == 0){
  //             provider.productList.removeAt(foundProdcutIndex);
  //           }else{
  //             provider.productList[foundProdcutIndex]=foundProduct;
  //           }
  //
  //         }
  //       });
  //     }
  //   });
  // }


}