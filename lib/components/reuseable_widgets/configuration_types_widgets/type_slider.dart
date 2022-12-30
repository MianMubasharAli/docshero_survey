import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../constants.dart';
import '../../models/option_product2_model.dart';
import '../../providers/data_provilder.dart';

class TypeSlider extends StatefulWidget {
   TypeSlider({
     required this.index,
     Key? key}) : super(key: key);
   int index;
  @override
  State<TypeSlider> createState() => _TypeSliderState();
}

class _TypeSliderState extends State<TypeSlider> {
  int check=0;
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
              SfSlider(
                min: provider.surveyModel!.steps![provider.questionsIndex].type == "question" ?
                        provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].min :
                        provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.options?[widget.index].min,
                max: provider.surveyModel!.steps![provider.questionsIndex].type == "question" ?
                        int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].max.toString()) :
                        int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].max.toString()),
                value: provider.surveyModel!.steps![provider.questionsIndex].type == "question" ?
                        provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].value :
                        provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.options?[widget.index].value,
                interval:
                provider.surveyModel!.steps![provider.questionsIndex].type == "question" ?
                (int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].max.toString())
                    /
                int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].step.toString()))
                :
                (int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].max.toString())
                    /
                int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].step.toString())),
                showTicks: false,
                showLabels: false,
                enableTooltip: true,
                stepSize: provider.surveyModel!.steps![provider.questionsIndex].type == "question" ?
                      double.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].step.toString()) :
                      double.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].step.toString()),

                minorTicksPerInterval: provider.surveyModel!.steps![provider.questionsIndex].type == "question" ?
                int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].step.toString()) :
                int.parse(provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].step.toString()),
                onChanged: (dynamic value){

                  if(provider.surveyModel!.steps![provider.questionsIndex].type == "question"){
                    provider.surveyModel!.steps![provider.questionsIndex].value!.configuration!.options![widget.index].value=value;
                    if(value <= 0 && check==1){
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
                      check=0;
                    }
                    if(value > 0 && check==0){

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
                      check=1;
                    }
                  }else{
                    provider.surveyModel!.steps![provider.questionsIndex].value!.questions![provider.chaptersQuestionsIndex].configuration2!.options![widget.index].value=value;
                    if(value <= 0 && check==1){
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
                      check=0;
                    }
                    if(value > 0 && check==0){
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
                      check=1;
                    }
                  }

                    setState((){
                      provider.setCheckValue("1");
                    });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
