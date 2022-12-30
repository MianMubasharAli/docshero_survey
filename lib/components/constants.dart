import 'dart:ui';

import 'package:flutter/material.dart';

const Color kWhiteColor=Colors.white;
const Color kBlackColor=Colors.black;
const Color kyellowColor=Colors.yellow;
const Color kBlueColor=Colors.blue;
const Color kGreenColor= Colors.green;
const Color kOrangeColor= Colors.orange;

Text largerText(String text,{Color color=kWhiteColor,double size=32,FontWeight fontWeight=FontWeight.w600,TextOverflow textOverflow=TextOverflow.ellipsis }){
  return Text(text,style: TextStyle(color: color,fontSize: size,fontWeight: fontWeight,),overflow: textOverflow,);
}
Text mediumText(String text,{Color color=kWhiteColor,double size=18,FontWeight fontWeight=FontWeight.w600,TextOverflow textOverflow=TextOverflow.ellipsis,int maxLines=1,bool softWrap=false}){
  return Text(text,style: TextStyle(color: color,fontSize: size,fontWeight: fontWeight),overflow: textOverflow,maxLines: maxLines,softWrap: softWrap,);
}
Text smallText(String text,{Color color=kWhiteColor,double size=14,FontWeight fontWeight=FontWeight.w600,TextOverflow textOverflow=TextOverflow.ellipsis}){
  return Text(text,style: TextStyle(color: color,fontSize: size,fontWeight: fontWeight),overflow: textOverflow,);
}
Text textWithoutLines(String text,{Color color=kWhiteColor,double size=18,FontWeight fontWeight=FontWeight.w600}){
  return Text(text,style: TextStyle(color: color,fontSize: size,fontWeight: fontWeight));
}