import 'package:flutter/material.dart';
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
              Text("${provider.surveyModel?.steps?[provider.questionsIndex].value?.configuration?.options?[widget.index].title}") :
              Text("${provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.options?[widget.index].title}"),
              value:
              provider.surveyModel?.steps?[provider.questionsIndex].type == "question" ?
              provider.surveyModel?.steps![provider.questionsIndex].value?.configuration?.options![widget.index].id :
              provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.options?[widget.index].id,
              groupValue: Provider.of<DataProvider>(context,listen: true).checkValue,
              onChanged: (onChanged){
                // localProductList=new Set();
                // localProductListIds=new Set();
                if(provider.surveyModel?.steps?[provider.questionsIndex].type == "question"){
                  provider.productList.forEach((element) { //cart products
                    //selected option
                    element.belongsTo?.forEach((element2) {
                      // provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options!.forEach((element3) {
                      //   if(element2 != element3.id){
                      //     element3.products?.forEach((element4) {
                      //       if(element.id == element4.id){
                      //         int index=provider.productList.indexWhere((element2) {
                      //
                      //           return element.id==element2.id;
                      //         });
                      //         localProductList.add(index);
                      //         localProductListIds.add(element2);
                      //       }
                      //     });
                      //   }
                      // });
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
                        // int index=provider.productList.indexWhere((element2) {
                        //
                        //   return element.id==element2.id;
                        // });
                        // if(index != null){
                        //   localProductList.add(index);
                        //   // localProductListIds.add(element2);
                        // }

                      }
                    });

                  });
                  for(int element in localProductList.toList().reversed){
                      if( provider.productList[element].quantity > 1){
                         provider.productList[element].quantity=provider.productList[element].quantity - 1;
                         localProductListIds.forEach((element2) {
                           if(provider.productList[element].belongsTo!.contains(element2)){
                             int index=provider.productList[element].belongsTo!.indexWhere((element3) {
                               return element2==element3;
                             });
                             provider.productList[element].belongsTo?.removeAt(index);
                           }
                         });
                      }else{
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
                     OptionProduct2 foundProduct=provider.productList[index];
                     bool? isContains=foundProduct.belongsTo?.contains(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id!);
                    if(!isContains!){
                      foundProduct.belongsTo?.add(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id!);
                    }
                    foundProduct.quantity=foundProduct.quantity + provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].quantity;
                     foundProduct.salePrice=(foundProduct.quantity * int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i].salePrice.toString())).toString();
                     provider.productList[index]=foundProduct;

                     // provider.productList[matchingIndex!].quantity=provider.productList[matchingIndex].quantity + 1;
                    }else{
                      OptionProduct2 product=provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products![i];
                      OptionProduct2 modifiedProduct=product;
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
                      if( provider.productList[element].quantity > 1){
                        provider.productList[element].quantity=provider.productList[element].quantity - 1;
                        localProductListIds.forEach((element2) {
                          if(provider.productList[element].belongsTo!.contains(element2)){
                            int index=provider.productList[element].belongsTo!.indexWhere((element3) {
                              return element2==element3;
                            });
                            provider.productList[element].belongsTo?.removeAt(index);
                          }
                        });
                      }else{
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
                        OptionProduct2 foundProduct=provider.productList[index];
                        bool? isContains=foundProduct.belongsTo?.contains(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].id!);
                        if(!isContains!){
                          foundProduct.belongsTo?.add(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].id!);
                        }
                        foundProduct.quantity=foundProduct.quantity + provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i].quantity;
                        provider.productList[index]=foundProduct;

                        // provider.productList[matchingIndex!].quantity=provider.productList[matchingIndex].quantity + 1;
                      }else{
                        OptionProduct2 product=provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].products![i];
                        OptionProduct2 modifiedProduct=product;
                        modifiedProduct.belongsTo?.add(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].id!);
                        provider.productList.add(modifiedProduct);

                      }
                    }
                  }
                }
                setState(() {
                  provider.setCheckValue(onChanged);
                });
              })
        ],
      ),
    );
  }
}