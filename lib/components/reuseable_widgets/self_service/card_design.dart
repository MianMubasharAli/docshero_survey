import 'package:docshero/components/constants.dart';
import 'package:flutter/material.dart';

class CardDesign extends StatelessWidget {
   CardDesign({
     required this.icon,
     required this.title,
     Key? key}) : super(key: key);

   String title;
   IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20,bottom: 20,left: 10,right: 10),
      decoration: BoxDecoration(
        color: kOrangeColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kBlackColor)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: kBlueColor,size: 50,),
          Center(child: mediumText("$title",size: 15,maxLines: 3))
        ],
      ),
    );
  }
}
