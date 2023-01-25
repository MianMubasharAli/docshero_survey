import 'package:docshero/components/models/survey_model.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:docshero/components/reuseable_widgets/configuration_types_widgets/type_slider.dart';
import 'package:docshero/components/reuseable_widgets/configuration_types_widgets/type_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/constants.dart';
import '../../components/models/option_product2_model.dart';
import '../../components/models/survey_model2.dart';
import '../../components/reuseable_widgets/configuration_types_widgets/type_multi.dart';
import '../../components/reuseable_widgets/configuration_types_widgets/type_number.dart';
import '../../components/reuseable_widgets/configuration_types_widgets/type_single.dart';
class Questions extends StatefulWidget {
   Questions({Key? key}) : super(key: key);

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  String checkValue="";
  bool checkForMultiType=false;
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    DataProvider provider=Provider.of<DataProvider>(context,listen: false);


    return Container(
      padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
      margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 5 ),
      decoration: BoxDecoration(
          color: kBlackColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width:size.width,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 5,right: 5,top: size.height * 0.015,bottom: size.height * 0.015),
                  decoration: BoxDecoration(
                      color: kBlueColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: largerText("${Provider.of<DataProvider>(context,listen: false).surveyModel?.steps?[provider.questionsIndex].value?.title}",size: 20),
                ),
                provider.surveyModel?.steps?[provider.questionsIndex].type == "question" ?
                Container(
                  width: size.width,
                  padding: EdgeInsets.only(left: 5,right: 5,top: size.height * 0.02,bottom: size.height * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWithoutLines("${provider.surveyModel?.steps?[provider.questionsIndex].value?.text}",
                          color: kBlackColor,
                          fontWeight: FontWeight.bold,
                          size: size.width * 0.08),
                      textWithoutLines("${provider.surveyModel?.steps?[provider.questionsIndex].value?.description}",
                          fontWeight: FontWeight.normal,color: kBlackColor,size: size.width * 0.06),

                      ListView.builder(
                          shrinkWrap:true,
                          itemCount: provider.surveyModel?.steps?[provider.questionsIndex].value?.configuration?.options?.length,
                          itemBuilder: (context, index) {
                            return
                              provider.surveyModel?.steps?[provider.questionsIndex].value?.configuration?.type == "single"
                                  ?
                              TypeSingle(index: index)
                                  :
                              provider.surveyModel?.steps?[provider.questionsIndex].value?.configuration?.type == "multi"
                                  ?
                              TypeMulti(index: index)
                                  :
                              provider.surveyModel?.steps?[provider.questionsIndex].value?.configuration?.type == "slider"
                                  ?
                              TypeSlider(index: index,)
                                  :
                              provider.surveyModel?.steps?[provider.questionsIndex].value?.configuration?.type == "text"
                                  ?
                              TypeText(index: index,)
                                  :
                              TypeNumber(index: index);

                          }
                      ),
                    ],
                  ),
                )
                    : Container(
                  width: size.width,
                  padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        padding: EdgeInsets.only(left: 5,right: 5,top: size.height * 0.02,bottom: size.height * 0.02    ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWithoutLines("${provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].title}",color: kBlackColor,fontWeight: FontWeight.bold),
                            textWithoutLines("${provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].description}",
                                fontWeight: FontWeight.normal,color: kBlackColor),

                            ListView.builder(
                                shrinkWrap:true,
                                itemCount: provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.options?.length,
                                itemBuilder: (context, index) {
                                  return
                                    provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.type == "single"
                                        ?
                                    TypeSingle(index: index)
                                        :
                                    provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.type == "multi"
                                        ?
                                    TypeMulti(index: index)
                                        :
                                    provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.type == "slider"
                                        ?
                                    TypeSlider(index: index,)
                                        :
                                    provider.surveyModel?.steps?[provider.questionsIndex].value?.questions?[provider.chaptersQuestionsIndex].configuration2?.type == "text"
                                        ?
                                    TypeText(index: index)
                                        :
                                    TypeNumber(index: index);

                                }
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),



            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kBlackColor.withOpacity(0.4)),
                  ),
                  child: mediumText("Back"),onPressed: (){
                  if(provider.surveyModel?.steps?[provider.questionsIndex].type == "question"){
                    if(provider.questionsIndex > 0){
                      setState((){
                        provider.setQuestionIndex(provider.questionsIndex-1);
                      });
                    }
                  }else{
                    if(provider.surveyModel?.steps?[provider.questionsIndex].type == "chapter"){
                      if(provider.chaptersQuestionsIndex > 0){
                        setState(() {
                          provider.setChaptersquestionIndex(provider.chaptersQuestionsIndex-1);
                        });
                      }else{
                        if(provider.questionsIndex > 0){
                          setState((){
                            provider.setQuestionIndex(provider.questionsIndex-1);
                          });
                        }
                      }
                    }
                  }


                },),
                SizedBox(width: 10,),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kBlueColor),
                  ),
                  child: mediumText("Next"),onPressed: (){
                  if(provider.surveyModel?.steps?[provider.questionsIndex].type == "question"){
                    if(provider.surveyModel!.steps!.length-1 > provider.questionsIndex){
                      setState((){
                        provider.setQuestionIndex(provider.questionsIndex+1);
                      });
                    }
                  }else{
                    if(provider.surveyModel?.steps?[provider.questionsIndex].type == "chapter"){
                      if(provider.surveyModel!.steps![provider.questionsIndex].value!.questions!.length - 1 > provider.chaptersQuestionsIndex){
                        setState(() {
                          provider.setChaptersquestionIndex(provider.chaptersQuestionsIndex + 1);
                        });
                      }else{
                        if(provider.surveyModel!.steps!.length-1 > provider.questionsIndex){
                          setState((){
                            provider.setQuestionIndex(provider.questionsIndex+1);
                          });
                        }
                      }
                    }
                  }
                },
                )
              ],
            )
          ],
        ),
      ),
    );
  }


}








