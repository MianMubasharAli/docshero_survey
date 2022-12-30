import 'package:docshero/components/constants.dart';
import 'package:docshero/components/providers/data_provilder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Steps extends StatelessWidget {
  const Steps({Key? key}) : super(key: key);

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
                      },
                      child: Container(
                      padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                      margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 5 ),
                      decoration: BoxDecoration(
                        color: kBlackColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          Container(
                            width:size.width,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                            decoration: BoxDecoration(
                              color: consumer.questionsIndex==index? Colors.orange : kBlueColor,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: largerText("${consumer.surveyModel?.steps?[index].value?.title}",size: 20),
                          ),
                          // Container(
                          //   width: size.width,
                          //   padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       textWithoutLines("Lorem Ipsum",color: kBlackColor,fontWeight: FontWeight.bold),
                          //       textWithoutLines("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin suscipit nunc a augue ullamcorper pulvinar. Curabitur sapien urna, pellentesque quis venenatis eget, porttitor ac augue. Pellentesque id nibh dolor. Fusce eget ipsum venenatis, pretium sem nec, blandit risus. Donec luctus metus quis ante elementum hendrerit. Sed dictum vulputate quam sed viverra. Fusce viverra, erat eget blandit finibus, quam diam imperdiet elit,",
                          //           fontWeight: FontWeight.normal,color: kBlackColor)
                          //     ],
                          //   ),
                          // )
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
                            color: kBlackColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            Container(
                              width:size.width,
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                              decoration: BoxDecoration(
                                  color: consumer.questionsIndex==index? Colors.orange : kBlueColor,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: largerText("${consumer.surveyModel?.steps?[index].value?.title}",size: 20),
                            ),

                            ListView.builder(
                              shrinkWrap: true,
                                itemCount: consumer.surveyModel?.steps?[index].value?.questions?.length,
                                itemBuilder: (context, index2){
                              return  InkWell(
                                onTap: (){
                                  consumer.setChaptersquestionIndex(index2);
                                },
                                child: Container(
                                  width:size.width,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 5,right: 20,left: 20),
                                  padding: EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
                                  decoration: BoxDecoration(
                                      color:  consumer.chaptersQuestionsIndex==index2 && consumer.questionsIndex == index? Colors.orange : kBlueColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: largerText("${consumer.surveyModel?.steps?[index].value?.questions?[index2].title}",size: 20),
                                ),
                              );
                            })
                          ],
                        ),
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
