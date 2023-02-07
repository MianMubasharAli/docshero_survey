import 'package:docshero/components/constants.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Steps extends StatefulWidget {
  const Steps({Key? key}) : super(key: key);

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    DataProvider provider=Provider.of<DataProvider>(context,listen: false);
    return Container(
      child: SingleChildScrollView(
        child: Consumer<DataProvider>(
          builder: (context, consumer, child) {
            return Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:consumer.surveyModel?.steps?.length,
                    itemBuilder: (BuildContext context,index){
                  return
                    consumer.surveyModel?.steps?[index].type == "question" ?
                    InkWell(
                      onTap: (){
                        consumer.setQuestionIndex(index);
                        DefaultTabController.of(context)?.animateTo(1);
                      },
                      child: Container(
                      padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                      margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 5 ),
                      decoration: BoxDecoration(
                        // color: kBlackColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          Container(
                            width:size.width,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 5,right: 5,top: size.height * 0.02,bottom: size.height * 0.02),
                            decoration: BoxDecoration(
                              color: consumer.questionsIndex==index? kOrangeColor : consumer.surveyModel?.steps?[index].value?.isVisited == true ? kGreenColor : kBlueColor,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: largerText("${consumer.surveyModel?.steps?[index].value?.title}",size: size.shortestSide < 550 ? 20 : 30),
                          ),

                        ],
                      ),
                  ),
                    ) : InkWell(
                      onTap: (){
                        consumer.setQuestionIndex(index);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                        margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 5 ),
                        decoration: BoxDecoration(
                            // color: kBlackColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: InkWell(
                          onTap: (){
                            consumer.setQuestionIndex(index);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            // width: size.width * 4,
                            child: ExpansionTile(
                              initiallyExpanded: consumer.questionsIndex == index,
                              key: Key(consumer.questionsIndex.toString()),
                              backgroundColor: kBlueColor,
                                tilePadding: EdgeInsets.only(left: 20),
                                trailing: SizedBox.shrink(),
                                iconColor: kWhiteColor,
                                // maintainState: true,
                                onExpansionChanged: (changed){
                                  consumer.setQuestionIndex(index);
                                  if(provider.surveyModel!.steps![provider.questionsIndex].value!.questions!.isNotEmpty){
                                    // int len=provider.surveyModel!.steps![provider.questionsIndex].value!.questions!.length - 1;
                                    provider.setChaptersquestionIndex(0);
                                  }
                                  setState((){});

                                },
                                collapsedBackgroundColor: kBlueColor,
                                title: Text("${consumer.surveyModel?.steps?[index].value?.title}",textAlign: TextAlign.center,style: TextStyle(
                                    fontSize: size.shortestSide < shortestSideCheck ? 20 : 30,
                                    color: kWhiteColor,
                                  fontWeight: FontWeight.w600
                                ),),
                                // largerText("${consumer.surveyModel?.steps?[index].value?.title}",size:  size.shortestSide < shortestSideCheck ? 20 : 30),
                            children: [
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: consumer.surveyModel?.steps?[index].value?.questions?.length,
                                  itemBuilder: (context,index2){
                                return InkWell(
                                  onTap: () async{
                                    consumer.setChaptersquestionIndex(index2);
                                    consumer.setQuestionIndex(index);
                                    DefaultTabController.of(context)?.animateTo(1);
                                  },
                                  child: Container(
                                    // color: kOrangeColor,
                                    margin: EdgeInsets.only(top: 1,bottom: 1,left: 5,right: 5),
                                    decoration: BoxDecoration(
                                      color:

                                      consumer.chaptersQuestionsIndex==index2 && consumer.questionsIndex == index? kOrangeColor
                                          : consumer.surveyModel?.steps?[index].value?.questions?[index2].value?.isVisited == true ?  kGreenColor : kBlueColor,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: kBlackColor)
                                    ),
                                    child: ListTile(
                                      dense: true,
                                      // tileColor: kOrangeColor,
                                      selectedColor: kOrangeColor,
                                      onTap: () async{
                                        consumer.setChaptersquestionIndex(index2);
                                        consumer.setQuestionIndex(index);
                                        DefaultTabController.of(context)?.animateTo(1);
                                      },
                                      title: Text("${consumer.surveyModel?.steps?[index].value?.questions?[index2].value?.title}",textAlign: TextAlign.center,style: TextStyle(
                                        fontSize: size.shortestSide < shortestSideCheck ? 20 : 30,
                                        color: kWhiteColor
                                      ),),
                                      // largerText("${consumer.surveyModel?.steps?[index].value?.questions?[index2].title}",size:  size.shortestSide < 550 ? 20 : 30),
                                    ),
                                  ),
                                );
                              })
                            ],
                            ),
                          ),
                        ),
                        // child: Column(
                        //   children: [
                        //     Container(
                        //       width:size.width,
                        //       alignment: Alignment.center,
                        //       padding: EdgeInsets.only(left: 5,right: 5,top: size.height * 0.02,bottom: size.height * 0.02),
                        //       decoration: BoxDecoration(
                        //           color: consumer.questionsIndex==index? kOrangeColor : kBlueColor,
                        //           borderRadius: BorderRadius.circular(10)
                        //       ),
                        //       child: largerText("${consumer.surveyModel?.steps?[index].value?.title}",size:  size.shortestSide < 550 ? 20 : 30),
                        //     ),
                        //
                        //     ListView.builder(
                        //       physics: NeverScrollableScrollPhysics(),
                        //       shrinkWrap: true,
                        //         itemCount: consumer.surveyModel?.steps?[index].value?.questions?.length,
                        //         itemBuilder: (context, index2){
                        //       return  InkWell(
                        //         onTap: (){
                        //           consumer.setChaptersquestionIndex(index2);
                        //         },
                        //         child: Container(
                        //           width:size.width,
                        //           alignment: Alignment.center,
                        //           margin: EdgeInsets.only(top: 5,right: 20,left: 20),
                        //           padding: EdgeInsets.only(left: 5,right: 5,top: size.height * 0.015,bottom: size.height * 0.015),
                        //           decoration: BoxDecoration(
                        //               color:  consumer.chaptersQuestionsIndex==index2 && consumer.questionsIndex == index? kOrangeColor : kBlueColor,
                        //               borderRadius: BorderRadius.circular(10)
                        //           ),
                        //           child: largerText("${consumer.surveyModel?.steps?[index].value?.questions?[index2].title}",size:  size.shortestSide < 550 ? 20 : 30),
                        //         ),
                        //       );
                        //     })
                        //   ],
                        // ),
                      ),
                    );
                })
              ],
            );
          }
        ),
      ),
    );
  }
}
