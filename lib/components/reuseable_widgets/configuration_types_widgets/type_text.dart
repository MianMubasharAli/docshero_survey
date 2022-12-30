import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/option_product2_model.dart';
import '../../providers/data_provilder.dart';

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
                mediumText("${provider.surveyModel?.steps?[provider.questionsIndex].value?.configuration?.options?[widget.index].title}",
                    color: kBlackColor,
                    maxLines: 2,
                    softWrap: false) :
                mediumText("${provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.options?[widget.index].title}",
                    color: kBlackColor,
                    maxLines: 2,
                    softWrap: false),

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
                        provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].placeholder
                    }",
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: kWhiteColor,
                    filled: true,
                    isDense: true,
                  ),
                  onChanged: (onChanged){
                    if(onChanged.isNotEmpty ){
                      if( check==0){
                      if(provider.surveyModel!.steps![provider.questionsIndex].type == "question"){
                        for(int i=0; i<provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].products!.length ; i++){
                          bool checkExistenceOfProduct=false;
                          int? matchingIndex;
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
                      check=1;
                      setState((){
                        provider.setCheckValue("1");
                      });
                      }
                    }
                    else{
                      if(provider.surveyModel!.steps![provider.questionsIndex].type == "question"){
                        provider.productList.forEach((element) { //cart products
                          //selected option
                          element.belongsTo?.forEach((element2) {
                            print("${provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id}");
                            if(element2 == provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id ){
                              for(int i=0; i < provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options!.length ; i++){
                                if(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].id ==
                                    provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![i].id){
                                  if(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![i].id == element2){
                                    int index=provider.productList.indexWhere((element2) {

                                      return element.id==element2.id;
                                    });
                                    if(index != null){
                                      localProductList.add(index);
                                      localProductListIds.add(element2);
                                    }
                                  }
                                }else{

                                }
                              }
                            }
                          });

                        });
                        for(var element in localProductList.toList().reversed){
                          if( provider.productList[element].quantity > 1){
                            provider.productList[element].quantity=provider.productList[element].quantity - 1;
                            provider.productList[element].salePrice=(int.parse(provider.productList[element].salePrice.toString()) * int.parse(provider.productList[element].quantity.toString())).toString();
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
                      }else{
                        provider.productList.forEach((element) { //cart products
                          //selected option
                          element.belongsTo?.forEach((element2) {
                            print("${provider.surveyModel!.steps![provider.questionsIndex].value!.questions?[provider.chaptersQuestionsIndex].configuration2?.options![widget.index].id}");
                            if(element2 == provider.surveyModel!.steps![provider.questionsIndex].value!.questions?[provider.chaptersQuestionsIndex].configuration2?.options![widget.index].id ){
                              for(int i=0; i < provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options!.length ; i++){
                                if(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].id ==
                                    provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![i].id){
                                  if(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![i].id == element2){
                                    int index=provider.productList.indexWhere((element2) {

                                      return element.id==element2.id;
                                    });
                                    if(index != null){
                                      localProductList.add(index);
                                      localProductListIds.add(element2);
                                    }
                                  }
                                }else{

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
                      }
                      check=0;
                      setState((){
                        provider.setCheckValue("1");
                      });
                    }

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
